<template>
  <v-card class="pa-3">
    <v-card-title>
      <span class="headline">{{ $t(`components.employees.employeeForm.${action}Title`) }}</span>
    </v-card-title>

    <v-form ref="form" @submit.prevent="save" lazy-validation>
      <v-card-text>
        <v-layout row wrap>
          <v-flex class="pa-2" xs12>
            <h3 class="subtitle-1">{{ $t('components.employees.employeeForm.general') }}</h3>
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-text-field
              v-model="localEmployee.first_name"
              :rules="[vRequired]"
              :label="$t('components.employees.employeeForm.firstName')"
              prepend-inner-icon="mdi-account-outline"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-text-field
              v-model="localEmployee.last_name"
              :rules="[vRequired]"
              :label="$t('components.employees.employeeForm.lastName')"
              prepend-inner-icon="mdi-account-outline"
            />
          </v-flex>

          <v-flex class="pa-2" xs12>
            <h3 class="subtitle-1">{{ $t('components.employees.employeeForm.employment') }}</h3>
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-combobox
              v-model="localEmployee.position"
              :items="this.positions"
              :rules="[vRequired]"
              append-icon="mdi-chevron-down"
              prepend-inner-icon="mdi-briefcase-outline"
              chips
              :label="$t('components.employees.employeeForm.position')"
              @change="localEmployee.set('position_set_on', null)"
              :loading="loading"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-combobox
              v-model="localEmployee.group"
              :items="this.groups"
              :rules="[vRequired]"
              append-icon="mdi-chevron-down"
              prepend-inner-icon="mdi-account-multiple-outline"
              chips
              :label="$t('components.employees.employeeForm.group')"
              :loading="loading"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-menu
              ref="hiredAtPicker"
              v-model="hiredAtPicker"
              :close-on-content-click="false"
              :nudge-right="40"
              transition="scale-transition"
              offset-y
              min-width="290px"
            >
              <template v-slot:activator="{ on }">
                <v-text-field
                  :value="localEmployee.hiredOn"
                  :label="$t('components.employees.employeeForm.hiredOn')"
                  :rules="[vRequired]"
                  prepend-inner-icon="mdi-calendar"
                  readonly
                  v-on="on"
                />
              </template>
              <v-date-picker
                v-model="localEmployee.hiredDate"
                @input="hiredAtPicker = false"
                :locale="$i18n.locale"
                no-title
                scrollable
              />
            </v-menu>
          </v-flex>

          <v-flex
            v-if="localEmployee.isPersisted"
            class="px-2"
            xs12
            lg6
          >
            <v-menu
              ref="positionSetAtPicker"
              v-model="positionSetAtPicker"
              :close-on-content-click="false"
              :nudge-right="40"
              transition="scale-transition"
              offset-y
              min-width="290px"
            >
              <template v-slot:activator="{ on }">
                <v-text-field
                  :value="localEmployee.positionSetOn"
                  :label="$t('components.employees.employeeForm.positionSetOn')"
                  :rules="[vRequired]"
                  prepend-inner-icon="mdi-calendar"
                  readonly
                  v-on="on"
                />
              </template>
              <v-date-picker
                v-model="localEmployee.positionSetDate"
                @input="positionSetAtPicker = false"
                :min="localEmployee.hiredDate"
                :locale="$i18n.locale"
                no-title
                scrollable
              />
            </v-menu>
          </v-flex>

          <v-flex class="pa-2" xs12>
            <h3 class="subtitle-1">{{ $t('components.employees.employeeForm.evaluation') }}</h3>
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-menu
              ref="nextEvaluationAtPicker"
              v-model="nextEvaluationAtPicker"
              :close-on-content-click="false"
              :nudge-right="40"
              transition="scale-transition"
              offset-y
              min-width="290px"
            >
              <template v-slot:activator="{ on }">
                <v-text-field
                  :value="nextEvaluationDate"
                  :label="$t('components.employees.employeeForm.nextEvaluationOn')"
                  prepend-inner-icon="mdi-calendar"
                  readonly
                  v-on="on"
                />
              </template>
              <v-date-picker
                v-model="localEmployee.nextEvaluationDate"
                @input="nextEvaluationAtPicker = false"
                :min="localEmployee.hiredDate"
                :locale="$i18n.locale"
                type="month"
                no-title
                scrollable
              />
            </v-menu>
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-select
              :value="localEmployee.evaluator_id"
              @change="localEmployee.set('evaluator_id', $event || null)"
              :items="evaluators.models"
              :label="$t('components.employees.employeeForm.evaluator')"
              item-value="id"
              item-text="fullname"
              prepend-inner-icon="mdi-account-plus-outline"
              :loading="loading"
              clearable
            />
          </v-flex>
        </v-layout>
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
          text
        >
          {{ $t('shared.buttons.save') }}
        </v-btn>
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script>
import { mapActions, mapState } from 'vuex'

import { Employee } from '@models/employee'

export default {
  name: 'EmployeeForm',
  props: {
    employee: {
      type: Employee,
      required: true,
      default: () => new Employee()
    },
    loading: {
      type: Boolean,
      required: true,
      default: true
    }
  },
  data() {
    return {
      localEmployee: new Employee({ ...this.employee }),
      hiredAtPicker: false,
      positionSetAtPicker: false,
      nextEvaluationAtPicker: false
    }
  },
  methods: {
    ...mapActions('EmployeesModule', [
      'createEmployee',
      'updateEmployee',
      'fetchFormData'
    ]),
    closeDialog() {
      this.$emit('closeDialog')
    },
    save() {
      if (!this.$refs.form.validate()) return

      (this.localEmployee.isPersisted ? this.updateEmployee : this.createEmployee)(this.localEmployee)
        .then(this.closeDialog)
    }
  },
  computed: {
    ...mapState('EmployeesModule', [
      'positions',
      'groups',
      'evaluators'
    ]),
    action() {
      return this.localEmployee.isPersisted ? 'update' : 'create'
    },
    nextEvaluationDate() {
      const mDate = this.$moment(this.localEmployee.nextEvaluationDate, 'YYYY-MM')

      return mDate.isValid() ? mDate.format('MMMM YYYY') : ''
    }
  },
  created() {
    this.fetchFormData()
  }
}
</script>
