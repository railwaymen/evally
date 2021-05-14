<template>
  <div class="sidebar sidebar--boxed mb-3">
    <div v-if="loading" class="sidebar__loader">
      <v-progress-circular :size="30" :width="3" color="primary" indeterminate />
    </div>

    <div v-else class="sidebar__section">
      <div class="sidebar__header">
        <h3 class="sidebar__title">
          {{ $t('components.recruitments.assignmentSidebar.title', { n: recruitments.length }) }}
        </h3>

        <div class="sidebar__actions">
          <v-tooltip bottom key="add">
            <template #activator="{ on }">
              <v-btn
                @click="openAssignmentForm"
                v-on="on"
                color="green"
                icon
              >
                <v-icon>mdi-notebook-edit-outline</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.newAssignment') }}</span>
          </v-tooltip>
        </div>
      </div>

      <v-list>
        <v-list-item
          v-for="recruitment in recruitments.models"
          :key="recruitment.id"
          two-line
        >
          <v-list-item-content>
            <v-list-item-title>{{ recruitment.name }}</v-list-item-title>

            <v-list-item-subtitle v-if="recruitment.isDraft">
              {{ $t('components.recruitments.assignmentSidebar.notStarted') }}
            </v-list-item-subtitle>

            <v-list-item-subtitle v-else>
              {{ $t('components.recruitments.assignmentSidebar.startedOn', { date: recruitment.startedOn }) }}
            </v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </div>
  </div>
</template>

<script>
import { DialogsBus } from '@utils/dialogs_bus'

import AssignmentForm from '@components/recruitments/AssignmentForm'

import { RecruitmentsList } from '@models/recruitment'

export default {
  name: 'RecruitmentsSidebar',
  props: {
    recruitments: {
      type: RecruitmentsList,
      required: true,
      default: () => new RecruitmentsList()
    },
    loading: {
      type: Boolean,
      required: true,
      default: true
    }
  },
  data() {
    return {
      open: false
    }
  },
  methods: {
    openAssignmentForm() {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: AssignmentForm
      })
    },
  }
}
</script>
