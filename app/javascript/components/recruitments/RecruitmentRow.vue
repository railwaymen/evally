<template>
  <div class="box mb-4">
    <div class="recruitment-row">
      <header class="recruitment-row__header">
        <h3 class="recruitment-row__title">
          {{ recruitment.name }}
          <span
            class="recruitment-row__date"
            v-if="recruitment.isStarted"
          >
            (started on {{ recruitment.startedOn }})
          </span>

          <span
            class="recruitment-row__date"
            v-if="recruitment.isCompleted"
          >
            (completed on {{ recruitment.completedOn }})
          </span>

          <span class="recruitment-row__participants">
            <v-tooltip
              v-for="user in participants"
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
            v-if="recruitment.isDraft"
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
            v-if="recruitment.isStarted"
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
            v-if="!recruitment.isCompleted"
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
            v-if="!recruitment.isCompleted"
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
        {{ recruitment.description }}
      </div>

      <div class="recruitment-stages">
        <div
          v-for="stage in recruitment.stages"
          :key="stage"
          class="recruitment-stage"
        >
          <div class="recruitment-stage__title">
            {{ stage }}

            <span class="recruitment-stage__actions">
              <v-tooltip bottom>
                <template #activator="{ on }">
                  <v-icon
                    @click="dropRecruitmentStage({ recruitment, stage })"
                    v-on="on"
                    class="mx-1"
                    color="red"
                    dense
                  >
                    mdi-close
                  </v-icon>
                </template>

                <span>Remove stage</span>
              </v-tooltip>
            </span>
          </div>
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
import { DialogsBus } from '@utils/dialogs_bus'

import RecruitmentForm from '@components/recruitments/RecruitmentForm'
import DeleteRecruitmentConfirm from '@components/recruitments/DeleteRecruitmentConfirm'
import RecruitmentStatusConfirm from '@components/recruitments/RecruitmentStatusConfirm'

import { Recruitment } from '@models/recruitment'

export default {
  name: 'RecruitmentRow',
  props: {
    recruitment: {
      type: Recruitment,
      required: true
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
      'dropRecruitmentStage'
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
    }
  },
  computed: {
    ...mapState('RecruitmentsModule', [
      'users'
    ]),
    participants() {
      return this.users.models.filter(user => this.recruitment.user_tokens.includes(user.email_token))
    }
  }
}
</script>
