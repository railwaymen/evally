<template>
  <v-card class="pa-3">
    <v-card-title>
      <span class="headline">{{ $t('components.recruitments.createEvaluationForm.title') }}</span>
    </v-card-title>

    <v-form @submit.prevent="create">
      <v-card-text>
        <div class="step">
          <div class="step__header">
            <v-chip color="white">
              <v-avatar :class="[templateId ? 'success' : 'grey darken-4', 'white--text', 'mr-2']">
                <v-icon color="white">{{ templateId ? 'mdi-check' : 'mdi-minus' }}</v-icon>
              </v-avatar>

              <span class="step__text black--text">
                {{ $t('components.recruitments.createEvaluationForm.selectTemplate') }}
              </span>
            </v-chip>
          </div>

          <div class="step__content">
            <v-select
              v-model="templateId"
              :items="templates.models"
              item-value="id"
              item-text="name"
              :label="$t('components.recruitments.createEvaluationForm.templateLabel')"
            />
          </div>
        </div>
      </v-card-text>

      <v-card-actions>
        <v-spacer />
        <v-btn
          @click="closeDialog"
          color="grey darken-1"
          text
        >
          {{ $t('shared.buttons.cancel') }}
        </v-btn>

        <v-btn
          type="submit"
          color="green darken-1"
          :disabled="!templateId"
          text
        >
          {{ $t('shared.buttons.create') }}
        </v-btn>
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script>
import { TemplatesList } from '@models/template'

export default {
  name: 'CreateEvaluationForm',
  props: {
    templates: {
      type: TemplatesList,
      required: true,
      default: () => new TemplatesList()
    }
  },
  data() {
    return {
      templateId: null
    }
  },
  methods: {
    closeDialog() {
      this.$emit('closeDialog')
    },
    create() {
      this.$store.dispatch('RecruitDocumentsModule/createEvaluation', this.$data)
        .then(this.closeDialog)
    }
  }
}
</script>
