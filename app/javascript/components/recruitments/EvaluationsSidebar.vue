<template>
  <div class="sidebar sidebar--boxed">
    <div class="sidebar__section">
      <v-select
        @change="fetchEvaluation"
        :value="evaluation.id"
        :items="evaluations.models"
        :label="$t('components.recruitments.evaluationsSidebar.selectLabel')"
        item-value="id"
        item-text="recruitableSelectOption"
        outlined
      />
    </div>

    <div class="sidebar__section">
      <div class="sidebar__actions">
        <v-tooltip bottom key="add">
          <template #activator="{ on }">
            <v-btn
              @click="openCreateEvaluationForm"
              v-on="on"
              color="green"
              icon
            >
              <v-icon>mdi-clipboard-plus-outline</v-icon>
            </v-btn>
          </template>

          <span>{{ $t('shared.tooltips.addNew') }}</span>
        </v-tooltip>

        <template v-if="evaluation.editable">
          <v-tooltip bottom key="complete">
            <template #activator="{ on }">
              <v-btn
                @click="openCompleteEvaluationConfirm"
                v-on="on"
                color="green"
                icon
              >
                <v-icon>mdi-clipboard-check-outline</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.complete') }}</span>
          </v-tooltip>

          <v-tooltip bottom key="save">
            <template #activator="{ on }">
              <v-btn
                @click="updateEvaluation"
                v-on="on"
                color="black"
                icon
              >
                <v-icon>mdi-content-save-outline</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.save') }}</span>
          </v-tooltip>

          <v-tooltip bottom key="reset">
            <template #activator="{ on }">
              <v-btn
                @click="fetchEvaluation(evaluation.id)"
                v-on="on"
                color="black"
                icon
              >
                <v-icon>mdi-restore</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.reset') }}</span>
          </v-tooltip>

          <v-tooltip bottom key="delete">
            <template #activator="{ on }">
              <v-btn
                @click="openDeleteEvaluationConfirm"
                v-on="on"
                color="red"
                icon
              >
                <v-icon>mdi-delete-outline</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.delete') }}</span>
          </v-tooltip>
        </template>
      </div>
    </div>

    <div v-if="loading" class="sidebar__loader">
      <v-progress-circular :size="30" :width="3" color="primary" indeterminate />
    </div>

    <v-form v-else ref="form">
      <div class="sidebar__section">
        <v-expansion-panels
          v-model="openSections"
          multiple
          accordion
        >
          <expandable-section-box
            v-for="section in sections.models"
            :section="section"
            :editable="evaluation.editable"
            :key="section.id"
          />
        </v-expansion-panels>
      </div>
    </v-form>
  </div>
</template>

<script>
import { mapActions } from 'vuex'
import { DialogsBus } from '@utils/dialogs_bus'

import { Evaluation, EvaluationsList } from '@models/evaluation'
import { SectionsList } from '@models/section'
import { TemplatesList } from '@models/template'

import CreateEvaluationForm from '@components/recruitments/CreateEvaluationForm'
import CompleteEvaluationConfirm from '@components/recruitments/CompleteEvaluationConfirm'
import DeleteEvaluationConfirm from '@components/recruitments/DeleteEvaluationConfirm'
import ExpandableSectionBox from '@components/recruitments/ExpandableSectionBox'

import { arrayRange } from '@utils/helpers'

export default {
  name: 'EvaluationsSidebar',
  components: { ExpandableSectionBox },
  props: {
    templates: {
      type: TemplatesList,
      required: true,
      default: () => new TemplatesList()
    },
    evaluations: {
      type: EvaluationsList,
      required: true,
      default: () => new EvaluationsList()
    },
    evaluation: {
      type: Evaluation,
      required: true,
      default: () => new Evaluation()
    },
    sections: {
      type: SectionsList,
      required: true,
      default: () => new SectionsList()
    },
    loading: {
      type: Boolean,
      required: true,
      default: true
    }
  },
  data() {
    return {
      openSections: arrayRange(this.sections.models.length)
    }
  },
  methods: {
    ...mapActions('RecruitDocumentsModule', [
      'fetchEvaluation',
      'updateEvaluation'
    ]),
    openCreateEvaluationForm() {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: CreateEvaluationForm,
        props: {
          templates: this.templates
        }
      })
    },
    openDeleteEvaluationConfirm() {
      DialogsBus.$emit('openConfirmDialog', {
        innerComponent: DeleteEvaluationConfirm
      })
    },
    openCompleteEvaluationConfirm() {
      DialogsBus.$emit('openConfirmDialog', {
        innerComponent: CompleteEvaluationConfirm
      })
    },
  },
  watch: {
    sections(val) {
      this.openSections = arrayRange(val.models.length)
    }
  }
}
</script>
