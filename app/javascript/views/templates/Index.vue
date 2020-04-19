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

        <template v-if="$route.name === 'template_path'">
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
                :disabled="!templatePolicy.canDestroy"
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
            <div v-if="$route.name === 'templates_path'" class="box">
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
import { mapGetters } from 'vuex'
import { DialogsBus } from '@utils/dialogs_bus'

import { TemplatePolicy } from '@policies/template_policy'

import DeleteConfirm from '@components/templates/DeleteConfirm'
import TemplatesSearchList from '@components/templates/TemplatesSearchList'

export default {
  name: 'Templates',
  components: { TemplatesSearchList },
  methods: {
    edit() {
      this.$store.commit('TemplatesModule/SET_EDITABLE')
    },
    save() {
      this.$store.dispatch(
        this.template.isPersisted
          ? 'TemplatesModule/updateTemplate'
          : 'TemplatesModule/createTemplate'
      ).then(data => this.$router.push({ name: 'template_path', params: { id: data.template.id } }))
    },
    openDeleteConfirm() {
      DialogsBus.$emit('openConfirmDialog', {
        innerComponent: DeleteConfirm
      })
    }
  },
  computed: {
    templatePolicy() {
      return new TemplatePolicy(this.user, this.template)
    },
    ...mapGetters({
      user: 'AuthenticationModule/user',
      templates: 'TemplatesModule/templates',
      template: 'TemplatesModule/template',
      loading: 'TemplatesModule/loading',
    })
  },
  created() {
    this.$store.dispatch('TemplatesModule/fetchTemplates')
  },
  destroyed() {
    this.$store.commit('TemplatesModule/RESET_STATE')
  }
}
</script>
