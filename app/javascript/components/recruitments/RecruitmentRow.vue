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
            (started on {{ localRecruitment.startedOn }})
          </span>

          <span
            class="recruitment-row__date"
            v-if="localRecruitment.isCompleted"
          >
            (completed on {{ localRecruitment.completedOn }})
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

        <div class="recruitment-row__actions">
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

            <span>Start</span>
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

            <span>Complete</span>
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

            <span>Edit</span>
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

            <span>Delete</span>
          </v-tooltip>
        </div>
      </header>

      <div class="recruitment-row__description">
        {{ localRecruitment.description }}
      </div>

      <div class="recruitment-stages">
        <div
          v-for="(candidates, stage) in localRecruitment.groupedCandidates"
          :key="stage"
          class="recruitment-stage"
        >
          <div class="recruitment-stage__title">
            {{ stage }}

            <span class="recruitment-stage__actions">
              <v-tooltip
                v-if="candidates.length === 0"
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

                <span>Remove stage</span>
              </v-tooltip>
            </span>
          </div>

          <draggable
            class="recruitment-stage__content"
            :list="candidates"
            :group="localRecruitment.id"
            :data-stage="stage"
            handle=".drag-section-btn"
            draggable=".drag-section"
            animation="300"
            @end="moveCandidate"
          >
            <recruitment-candidate
              class="drag-section"
              v-for="candidate in candidates"
              :data-candidate_id="candidate.id"
              :recruitment="recruitment"
              :candidate="candidate"
              :key="candidate.id"
            />
          </draggable>
        </div>

        <div class="recruitment-stage">
          <form class="recruitment-stage__form" @submit.prevent="addStage">
            <v-text-field
              v-model="newStage"
              label="Add stage"
              prepend-inner-icon="mdi-folder-plus-outline"
              append-icon="mdi-plus"
              filled
              @click:append="addStage"
            />
          </form>
        </div>
      </div>
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
      'moveRecruitmentCandidate'
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
    moveCandidate(event) {
      const payload = {
        stage: event.to.dataset.stage,
        position: event.newIndex + 1
      }

      this.moveRecruitmentCandidate({ candidateId: event.item.dataset.candidate_id, payload })
    }
  },
  computed: {
    ...mapState('RecruitmentsModule', [
      'users'
    ]),
    localRecruitment() {
      const newRecruitment = new Recruitment(this.recruitment)

      newRecruitment
        .setGroupedCandidates(this.candidatesGroup)
        .setParticipants(this.users.models)

      return newRecruitment
    }
  }
}
</script>
