<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">
        <h2>{{ $t('views.templates.title') }}</h2>
      </div>

      <div class="panel__actions">
        <v-tooltip bottom>
          <v-btn
            :to="{ name: 'template_path', params: { id: 'new' } }"
            color="green"
            slot="activator"
            icon
            flat
          >
            <v-icon>add</v-icon>
          </v-btn>
          <span>{{ $t('shared.tooltips.addNew') }}</span>
        </v-tooltip>

        <v-tooltip bottom>
          <v-btn
            @click="save"
            slot="activator"
            :disabled="!template.editable"
            icon
            flat
          >
            <v-icon>save_alt</v-icon>
          </v-btn>
          <span>{{ $t('shared.tooltips.save') }}</span>
        </v-tooltip>

        <v-tooltip bottom>
          <v-btn
            @click="edit"
            slot="activator"
            :disabled="template.isNewRecord"
            icon
            flat
          >
            <v-icon>edit</v-icon>
          </v-btn>
          <span>{{ $t('shared.tooltips.edit') }}</span>
        </v-tooltip>

        <v-tooltip bottom>
          <v-btn
            @click="openDeleteConfirm"
            color="red"
            slot="activator"
            :disabled="template.isNewRecord"
            icon
            flat
          >
            <v-icon>delete</v-icon>
          </v-btn>
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
                    {{ $t('views.templates.instruction') }}
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
    redirectToTemplate() {
      this.$router.push({ name: 'template_path', params: { id: data.id } })
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
