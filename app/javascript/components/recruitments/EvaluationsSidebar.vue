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

    <v-form ref="form" @submit.prevent="submit">
      <div class="sidebar__section">
        <v-expansion-panels v-model="panel" multiple accordion>
          <expandable-section-box
            v-for="section in sections.models"
            :section="section"
            :key="section.id"
          />
        </v-expansion-panels>

        <div class="sidebar__actions text-right">
          <v-btn
            color="grey darken-1"
            text
          >
            {{ $t('shared.buttons.reset') }}
          </v-btn>

          <v-btn
            type="submit"
            color="green darken-1"
            text
          >
            {{ $t('shared.buttons.save') }}
          </v-btn>
        </div>
      </div>
    </v-form>
  </div>
</template>

<script>
import { Evaluation, EvaluationsList } from '@models/evaluation'
import { SectionsList } from '@models/section'

import ExpandableSectionBox from '@components/recruitments/ExpandableSectionBox'

export default {
  name: 'EvaluationsSidebar',
  components: { ExpandableSectionBox },
  props: {
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
      panel: [0, 1, 2]
    }
  },
  methods: {
    submit() {
      console.log('Submitted!')
    }
  }
}
</script>
