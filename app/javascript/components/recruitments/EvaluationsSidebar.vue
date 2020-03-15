<template>
  <div class="sidebar sidebar--boxed">
    <div class="sidebar__section">
      <v-select
        :value="evaluation.id"
        :items="evaluations.models"
        label="Evaluation"
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

        <v-tooltip bottom key="complete">
          <template #activator="{ on }">
            <v-btn
              @click="openCompleteEvaluationConfirm"
              v-on="on"
              color="green"
              icon
              :disabled="!evaluation.editable"
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
              :disabled="!evaluation.editable"
            >
              <v-icon>mdi-content-save-outline</v-icon>
            </v-btn>
          </template>

          <span>{{ $t('shared.tooltips.save') }}</span>
        </v-tooltip>

        <v-tooltip bottom key="reset">
          <template #activator="{ on }">
            <v-btn
              @click="reset"
              v-on="on"
              color="black"
              icon
              :disabled="!evaluation.editable"
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
              :disabled="!evaluation.editable"
            >
              <v-icon>mdi-delete</v-icon>
            </v-btn>
          </template>

          <span>{{ $t('shared.tooltips.delete') }}</span>
        </v-tooltip>
      </div>
    </div>

    <v-form ref="form">
      <div class="sidebar__section">
        <v-expansion-panels v-model="panels" multiple accordion>
          <expandable-section-box
            v-for="section in sections.models"
            :section="section"
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
    }
  },
  data() {
    return {
      openSections: null
    }
  },
  methods: {
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
    reset() {
      this.showEvaluation(this.evaluation.id)
    },
    ...mapActions({
      showEvaluation: 'RecruitDocumentsModule/showEvaluation',
      updateEvaluation: 'RecruitDocumentsModule/updateEvaluation'
    })
  },
  computed: {
    panels: {
      get() {
        return this.openSections || this.sections.models.map((_model, index) => index)
      },
      set(val) {
        this.openSections = val
      }
    }
  }
}
</script>
