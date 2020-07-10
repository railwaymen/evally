<template>
  <div class="sidebar">
    <div class="siedebar__search">
      <v-text-field
        v-model="search"
        append-icon="mdi-magnify"
        label="Search"
        filled
      />
    </div>

    <div class="sidebar__list">
      <v-list two-line subheader>
        <v-subheader>Available Email Tempaltes</v-subheader>

        <div v-if="loading" class="sidebar__loader">
          <v-progress-circular :size="30" :width="3" color="primary" indeterminate />
        </div>

        <template v-else>
          <v-list-item
            v-for="emailTemplate in searchedEmailTemplates"
            :key="emailTemplate.id"
            :to="emailTemplate.path"
          >
            <v-list-item-avatar>
              <v-icon>mdi-email-edit-outline</v-icon>
            </v-list-item-avatar>

            <v-list-item-content>
              <v-list-item-title>{{ emailTemplate.name }}</v-list-item-title>
              <v-list-item-subtitle>
                Created by {{ emailTemplate.creator_fullname}}
              </v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>

          <v-list-item v-if="searchedEmailTemplates.length === 0">
            <v-list-item-action>
              <v-icon>mdi-alert-circle-outline</v-icon>
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title>
                There are no email templates
              </v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </template>
      </v-list>
    </div>
  </div>
</template>

<script>
import { EmailTemplatesList } from '@models/email_template'

export default {
  name: 'SearchableList',
  props: {
    emailTemplates: {
      type: EmailTemplatesList,
      required: true,
      default: () => new EmailTemplatesList()
    },
    loading: {
      type: Boolean,
      required: false,
      default: false
    }
  },
  data() {
    return {
      search: ''
    }
  },
  computed: {
    searchedEmailTemplates() {
      if (this.search.length === 0) return this.emailTemplates.models

      return this.emailTemplates.models.filter(template => (
        template.name.toLowerCase().indexOf(this.search.toLowerCase()) > -1
      ))
    }
  }
}
</script>
