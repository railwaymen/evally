<template>
  <v-card class="pa-3">
    <v-card-title>
      <span class="headline">{{ $t('evaluations.forms.create_title') }}</span>
    </v-card-title>

    <v-form>
      <v-card-text>
        <div class="step">
          <div class="step__header">
            <v-chip color="white" disabled>
              <v-avatar :class="[employeeId ? 'success' : 'grey darken-4', 'white--text']">
                <v-icon color="white" v-if="employeeId">done</v-icon>
                <span v-else>1</span>
              </v-avatar>
              <span class="step__text black--text">{{ $t('evaluations.forms.select_employee') }}</span>
            </v-chip>
          </div>

          <div class="step__content">
            <v-select
              v-model="employeeId"
              :items="[]"
              item-value="id"
              item-text="value"
              :label="$t('evaluations.forms.employee_label')"
            />
          </div>
        </div>

        <div class="step">
          <div class="step__header">
            <v-chip color="white" disabled>
              <v-avatar :class="[employeeId || latestTemplate ? 'success' : 'grey darken-4', 'white--text']">
                <v-icon color="white" v-if="employeeId || latestTemplate">done</v-icon>
                <span v-else>2</span>
              </v-avatar>
              <span class="step__text black--text">{{ $t('evaluations.forms.select_template') }}</span>
            </v-chip>
          </div>

          <div class="step__buttons">
            <div class="text-xs-center">
              <v-btn
                @click="useLatest(true)"
                :input-value="latestTemplate"
                flat
              >
                Latest Template
              </v-btn>

              <v-btn
                @click="useLatest(false)"
                :input-value="newTemplate"
                flat
              >
                New Template
              </v-btn>
            </div>
          </div>

          <div class="step__content">
            <v-select
              v-if="newTemplate"
              v-model="templateId"
              :items="[]"
              item-value="id"
              item-text="value"
              :label="$t('evaluations.forms.template_label')"
            />
          </div>
        </div>
      </v-card-text>

      <v-card-actions>
        <v-spacer />
        <v-btn
          @click="closeDialog"
          color="grey darken-1"
          flat
        >
          {{ $t('buttons.cancel') }}
        </v-btn>

        <v-btn
          type="submit"
          color="green darken-1"
          flat
          disabled
        >
          {{ $t('buttons.create') }}
        </v-btn>
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script>
export default {
  name: 'CreateForm',
  data() {
    return {
      employeeId: null,
      templateId: null,
      latestTemplate: null
    }
  },
  computed: {
    newTemplate() {
      return this.latestTemplate === false
    }
  },
  methods: {
    closeDialog() {
      this.$emit('closeDialog')
    },
    useLatest(val) {
      this.latestTemplate = val
    }
  }
}
</script>
