<template>
  <v-card class="pa-3">
    <v-card-title>
      <span class="headline">{{ $t('employees.forms.create_title') }}</span>
    </v-card-title>

    <v-form @submit.prevent="save">
      <v-card-text>
        <v-layout row wrap>
          <v-flex class="px-3" xs12 lg6>
            <h3 class="subheading">General Information</h3>

            <v-text-field
              v-model="localEmployee.first_name"
              :rules="[vRequired, vIsString]"
              :label="$t('employees.forms.first_name')"
            />

            <v-text-field
              v-model="localEmployee.last_name"
              :rules="[vRequired, vIsString]"
              :label="$t('employees.forms.last_name')"
            />

            <v-combobox
              v-model="localEmployee.position"
              :items="this.positions"
              :rules="[vRequired]"
              append-icon="expand_more"
              chips
              :label="$t('employees.forms.position')"
            />

            <v-combobox
              v-model="localEmployee.group"
              :items="this.groups"
              append-icon="expand_more"
              chips
              :label="$t('employees.forms.group')"
            />
          </v-flex>

          <v-flex class="px-3" xs12 lg6>
            <h3 class="subheading">Key Dates</h3>

            <v-menu
              ref="hiredAtPicker"
              v-model="hiredAtPicker"
              :close-on-content-click="true"
              :nudge-right="40"
              lazy
              transition="scale-transition"
              offset-y
              full-width
              min-width="290px"
            >
              <template v-slot:activator="{ on }">
                <v-text-field
                  :value="localEmployee.hiredDate"
                  :label="$t('employees.forms.hired_at')"
                  prepend-icon="event"
                  readonly
                  v-on="on"
                />
              </template>
              <v-date-picker
                v-model="localEmployee.hiredDate"
                :locale="$i18n.locale"
                no-title
                scrollable
              />
            </v-menu>

            <v-menu
              ref="positionSetAtPicker"
              v-model="positionSetAtPicker"
              :close-on-content-click="true"
              :nudge-right="40"
              lazy
              transition="scale-transition"
              offset-y
              full-width
              min-width="290px"
            >
              <template v-slot:activator="{ on }">
                <v-text-field
                  :value="localEmployee.positionSetDate"
                  :label="$t('employees.forms.position_set_at')"
                  prepend-icon="event"
                  readonly
                  v-on="on"
                />
              </template>
              <v-date-picker
                v-model="localEmployee.positionSetDate"
                :locale="$i18n.locale"
                no-title
                scrollable
              />
            </v-menu>

            <v-menu
              ref="nextEvaluationAtPicker"
              v-model="nextEvaluationAtPicker"
              :close-on-content-click="true"
              :nudge-right="40"
              lazy
              transition="scale-transition"
              offset-y
              full-width
              min-width="290px"
            >
              <template v-slot:activator="{ on }">
                <v-text-field
                  :value="localEmployee.nextEvaluationDate"
                  :label="$t('employees.forms.next_review')"
                  prepend-icon="event"
                  readonly
                  v-on="on"
                />
              </template>
              <v-date-picker
                v-model="localEmployee.nextEvaluationDate"
                :locale="$i18n.locale"
                type="month"
                no-title
                scrollable
              />
            </v-menu>
          </v-flex>
        </v-layout>
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
        >
          {{ $t('buttons.create') }}
        </v-btn>
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script>
import { mapActions } from 'vuex'

import { Employee } from '@models/employee'

export default {
  name: 'CreateForm',
  props: {
    positions: {
      type: Array,
      required: true,
      default: () => []
    },
    groups: {
      type: Array,
      required: true,
      default: () => []
    },
    employee: {
      type: Employee,
      required: true,
      default: () => new Employee()
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
    closeDialog() {
      this.$emit('closeDialog')
    },
    save() {
      (this.localEmployee.isPersisted ? this.update : this.create)(this.localEmployee)
        .then(this.closeDialog)
    },
    ...mapActions({
      create: 'EmployeesModule/create',
      update: 'EmployeesModule/update'
    })
  }
}
</script>
