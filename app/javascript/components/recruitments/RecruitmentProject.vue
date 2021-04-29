<template>
  <div class="box mb-4">
    <div class="recruitment-project">
      <header class="recruitment-project__header">
        <h3 class="recruitment-project__title">{{ recruitment.name }}</h3>

        <div class="recruitment-project__actions">
          <v-tooltip bottom>
            <template #activator="{ on }">
              <v-icon
                @click="openDeleteConfirm"
                v-on="on"
                color="red"
                class="mx-1"
              >
                mdi-delete-outline
              </v-icon>
            </template>

            <span>Delete</span>
          </v-tooltip>
        </div>
      </header>

      <div class="recruitment-project__stages">
        <div
          v-for="stage in recruitment.stages"
          :key="stage"
          class="recruitment-stage"
        >
          <div class="recruitment-stage__title">
            {{ stage }}
          </div>

          <div class="recruitment-stage__content">
            <draggable
              :list="candidates[stage].models"
              :group="recruitment.id"
              handle=".drag-section-btn"
              draggable=".drag-section"
              animation="300"
            >
              <div
                v-for="candidate in candidates[stage].models"
                :key="candidate.id"
                class="recruitment-item drag-section"
              >
                <div class="recruitment-item__content">
                  <div class="recruitment-item__name">
                    <strong>{{ candidate.fullname }}</strong>
                    ({{ candidate.status.label }})
                  </div>

                  <div class="recruitment-item__details">
                    {{ candidate.position }} - {{ candidate.receivedAt }}
                  </div>
                </div>

                <div class="recruitment_item__actions">
                  <v-btn class="drag-section-btn" icon small>
                    <v-icon>mdi-drag</v-icon>
                  </v-btn>

                  <v-btn icon small>
                    <v-icon>mdi-close</v-icon>
                  </v-btn>
                </div>
              </div>
            </draggable>
          </div>
        </div>

        <div class="recruitment-stage">
          <form class="recruitment-stage__form" @submit.prevent="addStage">
            <v-text-field
              v-model="stage"
              label="New stage"
              prepend-inner-icon="mdi-folder-plus-outline"
              append-icon="mdi-plus"
              filled
              dense
              @click:append="addStage"
            />
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex'

import Draggable from 'vuedraggable'
import { DialogsBus } from '@utils/dialogs_bus'

import DeleteRecruitmentProjectConfirm from '@components/recruitments/DeleteRecruitmentProjectConfirm'

import { RecruitDocumentsList } from '@models/recruit_document'
import { Recruitment } from '@models/recruitment'

const docs = () => new RecruitDocumentsList([
  {
    id: 1,
    first_name: 'John',
    last_name: 'Doe',
    status: {
      label: 'recruitment task'
    },
    position: 'Head of Pajacera',
    received_at: '2021-01-01'
  },
  {
    id: 2,
    first_name: 'Jane',
    last_name: 'Doe',
    status: {
      label: 'phone call'
    },
    position: 'Head of Marketing',
    received_at: '2021-01-01'
  }
])

export default {
  name: 'RecruitmentProject',
  components: { Draggable },
  props: {
    recruitment: {
      type: Recruitment,
      required: true,
      default: () => new Recruitment()
    }
  },
  data() {
    return {
      stage: '',
      candidates: {
        task: docs(),
        interview: docs(),
        decision: docs(),
        final: docs(),
        login: docs(),
        onboarding: new RecruitDocumentsList()
      }
    }
  },
  methods: {
    ...mapActions('RecruitmentsModule', [
      'updateRecruitment'
    ]),
    addStage() {
      if (this.stage) {
        const localRecruitment = new Recruitment({ ...this.recruitment })
        localRecruitment.stages.push(this.stage)

        this.updateRecruitment(localRecruitment)
          .then(() => this.stage = '')
      }
    },
    openDeleteConfirm() {
      DialogsBus.$emit('openConfirmDialog', {
        innerComponent: DeleteRecruitmentProjectConfirm,
        props: {
          recruitment: this.recruitment
        }
      })
    }
  }
}
</script>
