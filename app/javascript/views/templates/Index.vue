<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">
        <h2>{{ $t('views.templates.index.title') }}</h2>
      </div>

      <div class="panel__actions">
        <v-tooltip bottom>
          <template #activator="{ on }">
            <v-btn
              :to="{ name: 'template_path', params: { id: 'new' } }"
              v-on="on"
              color="green"
              icon
            >
              <v-icon>mdi-plus</v-icon>
            </v-btn>
          </template>

          <span>{{ $t('shared.tooltips.addNew') }}</span>
        </v-tooltip>

        <v-tooltip bottom>
          <template #activator="{ on }">
            <v-btn
              @click="save"
              v-on="on"
              :disabled="!template.editable"
              color="black"
              icon
            >
              <v-icon>mdi-content-save-outline</v-icon>
            </v-btn>
          </template>

          <span>{{ $t('shared.tooltips.save') }}</span>
        </v-tooltip>

        <v-tooltip bottom>
          <template #activator="{ on }">
            <v-btn
              @click="edit"
              v-on="on"
              :disabled="template.isNewRecord"
              color="black"
              icon
            >
              <v-icon>mdi-pencil</v-icon>
            </v-btn>
          </template>

          <span>{{ $t('shared.tooltips.edit') }}</span>
        </v-tooltip>

        <v-tooltip bottom>
          <template #activator="{ on }">
            <v-btn
              @click="openDeleteConfirm"
              color="red"
              v-on="on"
              :disabled="template.isNewRecord"
              icon
            >
              <v-icon>mdi-delete-outline</v-icon>
            </v-btn>
          </template>

          <span>{{ $t('shared.tooltips.delete') }}</span>
        </v-tooltip>
      </div>
    </div>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout wrap row>
          <v-flex xs10 offset-xs1 lg3 offset-lg0>
            <templates-search-list
              :templates="templates"
              :loading="loading"
            />
          </v-flex>

          <v-flex xs12 lg9>
            <div v-if="$route.name === 'templates_path'" class="box">
              <v-layout row>
                <v-flex xs12>
                  <h4 class="box__header">
                    {{ $t('views.templates.index.instruction') }}
                  </h4>
                </v-flex>
              </v-layout>
            </div>

            <router-view v-else />
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import { DialogsBus } from '@utils/dialogs_bus'

import DeleteConfirm from '@components/templates/DeleteConfirm'
import TemplatesSearchList from '@components/templates/TemplatesSearchList'

export default {
  name: 'Templates',
  components: { TemplatesSearchList },
  methods: {
    edit() {
      this.$store.commit('TemplatesModule/setEditable')
    },
    redirectToTemplate(data) {
      this.$router.push({ name: 'template_path', params: { id: data.template.id } })
    },
    save() {
      this.template.isPersisted
        ? this.update()
        : this.create().then(this.redirectToTemplate)
    },
    openDeleteConfirm() {
      DialogsBus.$emit('openConfirmDialog', {
        innerComponent: DeleteConfirm
      })
    },
    ...mapActions({
      fetchData: 'TemplatesModule/index',
      create: 'TemplatesModule/create',
      update: 'TemplatesModule/update',
    })
  },
  computed: {
    ...mapGetters({
      templates: 'TemplatesModule/templates',
      template: 'TemplatesModule/template',
      loading: 'TemplatesModule/loading',
    })
  },
  created() {
    this.fetchData()
  },
  beforeDestroy() {
    this.$store.commit('TemplatesModule/resetState')
  }
}
</script>
