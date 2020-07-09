<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">
        <h2>{{ $t('views.templates.index.title') }}</h2>
      </div>

      <div class="panel__nav">
        <v-btn
          color="primary"
          :to="{ name: 'evaluation_templates_path' }"
          text
        >
          Evaluation
        </v-btn>

        <v-btn
          color="primary"
          :to="{ name: 'email_templates_path' }"
          text
        >
          Email
        </v-btn>
      </div>

      <div class="panel__actions">
        <v-tooltip bottom>
          <template #activator="{ on }">
            <v-btn
              :to="{ name: 'evaluation_template_path', params: { id: 'new' } }"
              v-on="on"
              color="green"
              icon
            >
              <v-icon>mdi-plus</v-icon>
            </v-btn>
          </template>

          <span>{{ $t('shared.tooltips.addNew') }}</span>
        </v-tooltip>

        <template v-if="$route.name === 'evaluation_template_path'">
          <v-tooltip bottom>
            <template #activator="{ on }">
              <v-btn
                @click="save"
                v-on="on"
                :disabled="!templatePolicy.canSave"
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
                :disabled="!templatePolicy.canEdit"
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
                :disabled="!templatePolicy.canRemove"
                icon
              >
                <v-icon>mdi-delete-outline</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.delete') }}</span>
          </v-tooltip>
        </template>
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
            <div v-if="$route.name === 'evaluation_templates_path'" class="box">
              <v-layout row>
                <v-flex xs12>
                  <h4 class="box__header">
                    {{ $t('views.templates.index.instruction') }}
                  </h4>
                </v-flex>
              </v-layout>
            </div>

            <router-view v-else :key="$route.fullPath" />
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import { mapActions, mapState, mapGetters } from 'vuex'
import { DialogsBus } from '@utils/dialogs_bus'

import DeleteConfirm from '@components/templates/DeleteConfirm'
import TemplatesSearchList from '@components/templates/TemplatesSearchList'

export default {
  name: 'Templates',
  components: { TemplatesSearchList },
  methods: {
    ...mapActions('TemplatesModule', [
      'fetchTemplates',
      'createTemplate',
      'updateTemplate'
    ]),
    edit() {
      this.$store.commit('TemplatesModule/SET_EDITABLE')
    },
    save() {
      (this.template.isPersisted ? this.updateTemplate : this.createTemplate)()
        .then(data => this.$router.push({ name: 'evaluation_template_path', params: { id: data.template.id } }))
    },
    openDeleteConfirm() {
      DialogsBus.$emit('openConfirmDialog', {
        innerComponent: DeleteConfirm
      })
    }
  },
  computed: {
    ...mapState('TemplatesModule', [
      'templates',
      'template',
      'loading'
    ]),
    ...mapGetters('TemplatesModule', [
      'templatePolicy'
    ])
  },
  created() {
    this.fetchTemplates()
  },
  destroyed() {
    this.$store.commit('TemplatesModule/RESET_STATE')
  }
}
</script>
