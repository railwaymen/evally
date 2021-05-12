<template>
  <div class="recruitment-candidate">
    <div class="recruitment-candidate__body">
      <div class="recruitment-candidate__info">
        <div class="recruitment-candidate__name">
          <router-link :to="localCandidate.showPath">
            <strong class="mr-2">{{ localCandidate.fullname }}</strong>
          </router-link>

          <v-chip :color="localCandidate.status.color" dark x-small label>
            <strong>{{ localCandidate.status.label }}</strong>
          </v-chip>
        </div>

        <div class="recruitment-candidate__details">
          {{ localCandidate.position }} - {{ localCandidate.receivedAt }}
        </div>
      </div>

      <div
        v-if="!recruitment.isCompleted"
        class="recruitment-candidate__drag"
      >
        <v-btn class="drag-section-btn" icon small>
          <v-icon>mdi-drag</v-icon>
        </v-btn>
      </div>
    </div>

    <div class="recruitment-candidate__footer">
      <div class="recruitment-candidate__asignee">
        <v-tooltip v-if="evaluator" bottom>
          <template #activator="{ on }">
            <v-avatar v-on="on" color="primary" size="24">
              <span class="recruitment-participant">{{ evaluator.initials }}</span>
            </v-avatar>
          </template>

          <span>{{ evaluator.fullname }}</span>
        </v-tooltip>

        <v-avatar v-else color="white" size="24" />
      </div>

      <div class="recruitment-candidate__priority">
        <v-rating
          :value="localCandidate.priority"
          @input="updatePriority"
          background-color="primary"
          color="primary"
          length="3"
          size="18"
          clearable
        />
      </div>

      <div
        v-if="recruitmentPolicy.canEdit"
        class="recruitment-candidate__delete"
      >
        <v-btn @click="openDeleteConfirm" icon x-small>
          <v-icon color="red">mdi-close</v-icon>
        </v-btn>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from 'vuex'

import { DialogsBus } from '@utils/dialogs_bus'

import { Recruitment } from '@models/recruitment'
import { RecruitmentCandidate } from '@models/recruitment_candidate'

import DeleteRecruitmentCandidateConfirm from '@components/recruitments/DeleteRecruitmentCandidateConfirm'

import RecruitmentPolicy from '@policies/recruitment_policy'

export default {
  name: 'RecruitmentCandidate',
  props: {
    candidate: {
      type: Object,
      required: true
    },
    recruitment: {
      type: Recruitment,
      required: true
    },
    recruitmentPolicy: {
      type: RecruitmentPolicy,
      required: true
    }
  },
  methods: {
    ...mapActions('RecruitmentsModule', [
      'updateRecruitmentCandidate'
    ]),
    updatePriority(value) {
     const payload = {
       priority: value
     }

     this.updateRecruitmentCandidate({ candidateId: this.candidate.id, payload })
    },
    openDeleteConfirm() {
      DialogsBus.$emit('openConfirmDialog', {
        innerComponent: DeleteRecruitmentCandidateConfirm,
        props: {
          candidate: this.localCandidate,
          recruitment: this.recruitment
        }
      })
    },
  },
  computed: {
    ...mapState('RecruitmentsModule', [
      'users'
    ]),
    localCandidate() {
      return new RecruitmentCandidate(this.candidate)
    },
    evaluator() {
      return this.users.models.find(user => user.email_token === this.localCandidate.evaluator_token)
    }
  }
}
</script>
