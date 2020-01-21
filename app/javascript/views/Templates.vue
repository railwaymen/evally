<template>
  <section class="panel">
    <v-layout row>
      <v-flex>
        <h2 class="panel__heading">{{ $t('templates.title') }}</h2>
      </v-flex>

      <v-flex>
        <div class="panel__action-bar">
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
            <span>{{ $t('templates.buttons.add_new') }}</span>
          </v-tooltip>

          <v-tooltip bottom>
            <v-btn
              @click="save"
              slot="activator"
              icon
              flat
            >
              <v-icon>save_alt</v-icon>
            </v-btn>
            <span>{{ $t('templates.buttons.save') }}</span>
          </v-tooltip>

          <v-tooltip bottom>
            <v-btn
              @click="edit"
              slot="activator"
              icon
              flat
            >
              <v-icon>edit</v-icon>
            </v-btn>
            <span>{{ $t('templates.buttons.edit') }}</span>
          </v-tooltip>

          <v-tooltip bottom>
            <v-btn color="red" slot="activator" icon flat>
              <v-icon>delete</v-icon>
            </v-btn>
            <span>{{ $t('templates.buttons.delete') }}</span>
          </v-tooltip>
        </div>
      </v-flex>
    </v-layout>

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
            <div v-if="$route.name === 'templates_path'" class="box box--with-content">
              <v-layout row>
                <v-flex xs12>
                  <h4 class="no-content__header no-content__header--large">
                    {{ $t('templates.messages.select') }}
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

import TemplatesSearchList from '@components/templates/TemplatesSearchList'

export default {
  name: 'Templates',
  components: { TemplatesSearchList },
  methods: {
    edit() {
      this.$store.commit('TemplatesModule/edit')
    },
    save() {
      this.template.isPersisted ? this.update() : this.create()
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
  }
}
</script>
