<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">
        <h2>{{ $t('views.drafts.index.title') }}</h2>
      </div>

      <div class="panel__actions">
        <v-tooltip bottom>
          <v-btn
            @click="openCreateForm"
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
            @click="openCompleteForm"
            :disabled="draft.isNewRecord"
            color="green"
            slot="activator"
            icon
            flat
          >
            <v-icon>how_to_vote</v-icon>
          </v-btn>
          <span>{{ $t('shared.tooltips.complete') }}</span>
        </v-tooltip>

        <v-tooltip bottom>
          <v-btn
            @click="update"
            :disabled="draft.isNewRecord"
            color="black"
            slot="activator"
            icon
            flat
          >
            <v-icon>save_alt</v-icon>
          </v-btn>
          <span>{{ $t('shared.tooltips.save') }}</span>
        </v-tooltip>

        <v-tooltip bottom>
          <v-btn
            @click="reset"
            :disabled="draft.isNewRecord"
            color="black"
            slot="activator"
            icon
            flat
          >
            <v-icon>restore</v-icon>
          </v-btn>
          <span>{{ $t('shared.tooltips.reset') }}</span>
        </v-tooltip>

        <v-tooltip bottom>
          <v-btn
            @click="openDeleteConfirm"
            :disabled="draft.isNewRecord"
            color="red"
            slot="activator"
            icon
            flat
          >
            <v-icon>delete</v-icon>
          </v-btn>
          <span>{{ $t('shared.tooltips.delete') }}</span>
        </v-tooltip>

        <v-tooltip bottom>
          <v-btn
            @click="toggleSidebar"
            slot="activator"
            icon
            flat
          >
            <v-icon>{{ isSidebarVisible ? 'visibility_off' : 'visibility' }}</v-icon>
          </v-btn>
          <span>
            {{ isSidebarVisible ? $t('shared.tooltips.hideSidebar') : $t('shared.tooltips.showSidebar') }}
          </span>
        </v-tooltip>
      </div>
    </div>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout wrap row>
          <v-flex v-show="isSidebarVisible" xs10 offset-xs1 lg3 offset-lg0>
            <drafts-search-list
              :drafts="drafts"
              :loading="loading"
            />
          </v-flex>

          <v-flex xs12 :lg9="isSidebarVisible" :lg12="!isSidebarVisible">
            <div v-if="$route.name === 'drafts_path'" class="box">
              <v-layout row>
                <v-flex xs12>
                  <h4 class="box__header">
                    {{ $t('views.drafts.index.instruction') }}
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

import CompleteForm from '@components/drafts/CompleteForm'
import CreateForm from '@components/drafts/CreateForm'
import DeleteConfirm from '@components/drafts/DeleteConfirm'
import DraftsSearchList from '@components/drafts/DraftsSearchList'

export default {
  name: 'DraftsIndex',
  components: { DraftsSearchList },
  data() {
    return {
      isSidebarVisible: true
    }
  },
  methods: {
    toggleSidebar() {
      this.isSidebarVisible = !this.isSidebarVisible
    },
    reset() {
      this.$store.dispatch('DraftsModule/show', this.draft.id)
    },
    openCreateForm() {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: CreateForm,
        props: {
          employees: this.employees,
          templates: this.templates
        }
      })
    },
    openCompleteForm() {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: CompleteForm
      })
    },
    openDeleteConfirm() {
      DialogsBus.$emit('openConfirmDialog', {
        innerComponent: DeleteConfirm
      })
    },
    ...mapActions({
      fetchData: 'DraftsModule/index',
      update: 'DraftsModule/update',
    })
  },
  computed: {
    ...mapGetters({
      drafts: 'DraftsModule/drafts',
      draft: 'DraftsModule/draft',
      employees: 'DraftsModule/employees',
      templates: 'DraftsModule/templates',
      loading: 'DraftsModule/loading',
    })
  },
  created() {
    this.fetchData()
  },
  beforeDestroy() {
    this.$store.commit('DraftsModule/resetState')
  }
}
</script>
