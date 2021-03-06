<template>
  <div class="box mb-4">
    <div class="recruitment-row">
      <header class="recruitment-row__header">
        <h3 class="recruitment-row__title">
          {{ localRecruitment.name }}
          <span
            class="recruitment-row__date"
            v-if="localRecruitment.isStarted"
          >
            {{ $t('components.recruitments.recruitmentRow.startedOn', { date: localRecruitment.startedOn }) }}
          </span>

          <span
            class="recruitment-row__date"
            v-if="localRecruitment.isCompleted"
          >
            {{ $t('components.recruitments.recruitmentRow.completedOn', { date: localRecruitment.completedOn }) }}
          </span>

          <span class="recruitment-row__participants">
            <v-tooltip
              v-for="user in localRecruitment.participants"
              :key="user.id"
              bottom
            >
              <template #activator="{ on }">
                <v-avatar v-on="on" color="primary" size="24">
                  <span class="recruitment-participant">{{ user.initials }}</span>
                </v-avatar>
              </template>

              <span>{{ user.fullname }} ({{ user.role }})</span>
            </v-tooltip>
          </span>
        </h3>

        <div
          v-if="recruitmentPolicy.canManage"
          class="recruitment-row__actions"
        >
          <v-tooltip
            v-if="localRecruitment.isDraft"
            bottom
          >
            <template #activator="{ on }">
              <v-icon
                @click="openStatusConfirm('start')"
                v-on="on"
                class="mx-1"
                color="green"
              >
                mdi-clock-start
              </v-icon>
            </template>

            <span>{{ $t('shared.tooltips.start') }}</span>
          </v-tooltip>

          <v-tooltip
            v-if="localRecruitment.isStarted"
            bottom
          >
            <template #activator="{ on }">
              <v-icon
                @click="openStatusConfirm('complete')"
                v-on="on"
                class="mx-1"
                color="primary"
              >
                mdi-clock-end
              </v-icon>
            </template>

            <span>{{ $t('shared.tooltips.complete') }}</span>
          </v-tooltip>

          <v-tooltip
            v-if="!localRecruitment.isCompleted"
            bottom
          >
            <template #activator="{ on }">
              <v-icon
                @click="openRecruitmentForm"
                v-on="on"
                class="mx-1"
                color="black"
              >
                mdi-pencil
              </v-icon>
            </template>

            <span>{{ $t('shared.tooltips.edit') }}</span>
          </v-tooltip>

          <v-tooltip
            v-if="!localRecruitment.isCompleted"
            bottom
          >
            <template #activator="{ on }">
              <v-icon
                @click="openDeleteConfirm"
                v-on="on"
                class="mx-1"
                color="red"
              >
                mdi-delete-outline
              </v-icon>
            </template>

            <span>{{ $t('shared.tooltips.delete') }}</span>
          </v-tooltip>
        </div>
      </header>

      <div class="recruitment-row__description">
        {{ localRecruitment.description }}
      </div>

      <draggable
        class="recruitment-stages"
        :list="localRecruitment.stages"
        handle=".drag-stage-btn"
        draggable=".drag-stage"
        animation="300"
        @change="moveStage"
        :disabled="recruitment.isCompleted"
      >
        <div
          v-for="(candidates, stage) in localRecruitment.groupedCandidates"
          :key="stage"
          class="recruitment-stage drag-stage"
        >
          <div class="recruitment-stage__title">
            <span>{{ stage }}</span>

            <div
              v-if="recruitmentPolicy.canManage"
              class="recruitment-stage__actions"
            >
              <v-tooltip
                v-if="candidates.length === 0 && recruitmentPolicy.canEdit"
                bottom
              >
                <template #activator="{ on }">
                  <v-icon
                    @click="dropRecruitmentStage({ recruitment: localRecruitment, stage })"
                    v-on="on"
                    class="mx-1"
                    color="red"
                    dense
                  >
                    mdi-delete-outline
                  </v-icon>
                </template>

                <span>{{ $t('shared.tooltips.removeStage') }}</span>
              </v-tooltip>

              <div
                v-if="!recruitment.isCompleted"
                class="recruitment-stage__drag"
              >
                <v-btn class="drag-stage-btn" icon small>
                  <v-icon dense>mdi-drag</v-icon>
                </v-btn>
              </div>
            </div>
          </div>

          <draggable
            class="recruitment-stage__content"
            :list="candidates"
            :group="localRecruitment.id"
            :data-stage="stage"
            handle=".drag-candidate-btn"
            draggable=".drag-candidate"
            animation="300"
            @end="moveCandidate"
            :disabled="recruitment.isCompleted"
          >
            <recruitment-candidate
              class="drag-candidate"
              v-for="candidate in candidates"
              :data-candidate_id="candidate.id"
              :recruitment-policy="recruitmentPolicy"
              :recruitment="recruitment"
              :candidate="candidate"
              :key="candidate.id"
            />
          </draggable>
        </div>

        <div
          v-if="recruitmentPolicy.canEdit"
          class="recruitment-stage"
        >
          <form class="recruitment-stage__form" @submit.prevent="addStage">
            <v-text-field
              v-model="newStage"
              :label="$t('components.recruitments.recruitmentRow.addStage')"
              prepend-inner-icon="mdi-folder-plus-outline"
              append-icon="mdi-plus"
              filled
              @click:append="addStage"
            />
          </form>
        </div>
      </draggable>
    </div>
  </div>
</template>

<script>
import { mapActions, mapState } from 'vuex'
import Draggable from 'vuedraggable'

import { DialogsBus } from '@utils/dialogs_bus'

import RecruitmentForm from '@components/recruitments/RecruitmentForm'
import RecruitmentCandidate from '@components/recruitments/RecruitmentCandidate'
import DeleteRecruitmentConfirm from '@components/recruitments/DeleteRecruitmentConfirm'
import RecruitmentStatusConfirm from '@components/recruitments/RecruitmentStatusConfirm'

import RecruitmentPolicy from '@policies/recruitment_policy'

import { Recruitment } from '@models/recruitment'

export default {
  name: 'RecruitmentRow',
  components: { Draggable, RecruitmentCandidate },
  props: {
    recruitment: {
      type: Recruitment,
      required: true
    },
    candidatesGroup: {
      type: Object,
      required: false,
      default: () => ({})
    }
  },
  data() {
    return {
      newStage: ''
    }
  },
  methods: {
    ...mapActions('RecruitmentsModule', [
      'addRecruitmentStage',
      'dropRecruitmentStage',
      'moveRecruitmentCandidate',
      'updateRecruitment'
    ]),
    openRecruitmentForm() {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: RecruitmentForm,
        maxWidth: 800,
        props: {
          recruitment: this.recruitment
        }
      })
    },
    openStatusConfirm(action) {
      DialogsBus.$emit('openConfirmDialog', {
        innerComponent: RecruitmentStatusConfirm,
        props: {
          recruitment: this.recruitment,
          action
        }
      })
    },
    openDeleteConfirm() {
      DialogsBus.$emit('openConfirmDialog', {
        innerComponent: DeleteRecruitmentConfirm,
        props: {
          recruitment: this.recruitment
        }
      })
    },
    addStage() {
      if (!this.newStage) return

      this.addRecruitmentStage({ recruitment: this.recruitment, stage: this.newStage })
        .then(() => this.newStage = '')
    },
    moveStage({ moved: { element, newIndex } }) {
      this.recruitment.moveStage(element, newIndex)
      this.updateRecruitment(this.recruitment)
    },
    moveCandidate(event) {
      const payload = {
        stage: event.to.dataset.stage,
        position: event.newIndex + 1
      }

      this.moveRecruitmentCandidate({ candidateId: event.item.dataset.candidate_id, payload })
    }
  },
  computed: {
    ...mapState('AuthenticationModule', [
      'user'
    ]),
    ...mapState('RecruitmentsModule', [
      'users'
    ]),
    localRecruitment() {
      const newRecruitment = new Recruitment(this.recruitment)

      newRecruitment
        .setGroupedCandidates(this.candidatesGroup)
        .setParticipants(this.users.models)

      return newRecruitment
    },
    recruitmentPolicy() {
      return new RecruitmentPolicy(this.user, this.recruitment)
    }
  }
}
</script>
