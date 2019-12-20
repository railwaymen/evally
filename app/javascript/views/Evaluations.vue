<template>
  <section class="panel">
    <v-layout row>
      <v-flex>
        <h2 class="panel__heading">{{ $t('evaluations.title') }}</h2>
      </v-flex>

      <v-flex>
        <div class="panel__action-bar">
          <v-tooltip bottom>
            <v-btn color="green" slot="activator" icon flat>
              <v-icon>add</v-icon>
            </v-btn>
            <span>{{ $t('evaluations.buttons.add_new') }}</span>
          </v-tooltip>

          <v-tooltip class="divider-before" bottom>
            <v-btn @click="toggleSidebar" slot="activator" icon flat>
              <v-icon>{{ isSidebarVisible ? 'visibility_off' : 'visibility' }}</v-icon>
            </v-btn>
            <span>{{ isSidebarVisible ? $t('buttons.hide') : $t('buttons.show') }} sidebar</span>
          </v-tooltip>

        </div>
      </v-flex>
    </v-layout>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout wrap row>
          <v-flex v-show="isSidebarVisible" xs10 offset-xs1 lg3 offset-lg0>
            <drafts-sidebar
              :drafts="drafts"
              :loading="loading"
            />
          </v-flex>

          <v-flex xs12 :lg9="isSidebarVisible" :lg12="!isSidebarVisible">
            <div v-if="$route.name === 'evaluations_path'" class="box box--with-content">
              <v-layout row>
                <v-flex xs12>
                  <h4 class="no-content__header no-content__header--large">{{ $t('evaluations.message') }}</h4>
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
import { mapGetters } from 'vuex'

import DraftsSidebar from '@components/evaluations/DraftsSidebar'

export default {
  name: 'Evaluations',
  components: { DraftsSidebar },
  data() {
    return {
      isSidebarVisible: true
    }
  },
  methods: {
    toggleSidebar() {
      this.isSidebarVisible = !this.isSidebarVisible
    }
  },
  computed: {
    ...mapGetters({
      drafts: 'EvaluationsStore/evaluations',
      loading: 'EvaluationsStore/loading',
    })
  },
  created() {
    this.$store.dispatch('EvaluationsStore/drafts')
      .catch(error => {
        this.flash({ error: this.$root.$t('evaluations.flashes.fetch.error', { reason: this.renderError(error.response) }) })
      })
  },
  beforeDestroy() {
    this.$store.commit('EvaluationsStore/resetState')
  }
}
</script>
