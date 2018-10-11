<template>
  <v-flex :xs6="section.width === 'half'" :xs12="section.width === 'full'">
    <div class="form-box">
      <h5 class="form-box__heading">
        <span class="form-box__heading-content" v-if="template.editable">
          <v-text-field
            v-model="section.name"
            :error-messages="section.errors.name"
            label="Section title"
            outline
          ></v-text-field>
        </span>

        <span class="form-box__heading-content" v-else>{{ section.name }}</span>
      </h5>

      <group-form :skills="section.skills" :group="section.group"></group-form>

    </div>
  </v-flex>
</template>

<script>
import { mapGetters } from 'vuex'

import GroupForm from './GroupForm'

export default {
  name: 'SectionBox',
  components: { GroupForm },
  props: ['section'],
  computed: {
    ...mapGetters({
      template: 'TemplatesStore/template'
    })
  }
}
</script>