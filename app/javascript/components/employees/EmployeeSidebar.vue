<template>
  <div class="sidebar sidebar--boxed">
    <div class="vcard">
      <h3 class="vcard__fullname">{{ employee.fullname }}</h3>
      <h4 class="vcard__position">{{ employee.position }}</h4>

      <div class="vcard__content">
        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.employees.sidebar.group') }}</div>
          <div class="vcard__value">{{ employee.group }}</div>
        </div>

        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.employees.sidebar.hiredOn') }}</div>
          <div class="vcard__value">{{ employee.hiredOn }}</div>
        </div>

        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.employees.sidebar.nextEvaluationAt') }}</div>
          <div class="vcard__value">{{ employee.nextEvaluationAt }}</div>
        </div>
      </div>
    </div>

    <v-expansion-panels v-model="panel" multiple accordion>
      <v-expansion-panel>
        <v-expansion-panel-header>
          <h5 class="body-2">
            {{ $t('components.employees.sidebar.completedEvaluations.title') }}
          </h5>
        </v-expansion-panel-header>

        <v-expansion-panel-content>
          <v-list two-line subheader>
            <v-list-item
              v-for="evaluation in evaluations.models"
              :key="evaluation.id"
              :to="evaluation.path"
            >
              <v-list-item-content>
                <v-list-item-title>{{ evaluation.template_name }}</v-list-item-title>
                <v-list-item-subtitle>{{ evaluation.completedAt }}</v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>

            <v-list-item v-if="evaluations.isEmpty">
              <v-list-item-content>
                <v-list-item-title>
                  {{ $t('components.employees.sidebar.completedEvaluations.noContent') }}
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list>
        </v-expansion-panel-content>
      </v-expansion-panel>

      <v-expansion-panel>
        <v-expansion-panel-header>
          <h5 class="body-2">
            {{ $t('components.employees.sidebar.positionChanges.title') }}
          </h5>
        </v-expansion-panel-header>

        <v-expansion-panel-content>
          <v-list two-line>
            <v-list-item v-for="positionChange in positionChanges.models" :key="positionChange.id">
              <v-list-item-content>
                <v-list-item-title>
                  {{ positionChange.current_position }}
                </v-list-item-title>

                <v-list-item-subtitle class="body-2">
                  {{ positionChange.changedAt }}
                </v-list-item-subtitle>

                <v-list-item-subtitle class="body-2">
                  {{ $t('components.employees.sidebar.positionChanges.previous', { name: positionChange.previous_position }) }}
                </v-list-item-subtitle>
              </v-list-item-content>
            </v-list-item>

            <v-list-item v-if="positionChanges.isEmpty">
              <v-list-item-content>
                <v-list-item-title>
                  {{ $t('components.employees.sidebar.positionChanges.noContent') }}
                </v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list>
        </v-expansion-panel-content>
      </v-expansion-panel>
    </v-expansion-panels>
  </div>
</template>

<script>
import { Employee } from '@models/employee'
import { EvaluationsList } from '@models/evaluation'
import { PositionChangesList } from '@models/position_change'

export default {
  name: 'EmployeeSidebar',
  props: {
    employee: {
      type: Employee,
      required: true,
      default: () => new Employee()
    },
    evaluations: {
      type: EvaluationsList,
      required: true,
      default: () => new EvaluationsList()
    },
    positionChanges: {
      type: PositionChangesList,
      required: true,
      default: () => new PositionChangesList()
    }
  },
  data() {
    return {
      panel: [0, 1]
    }
  }
}
</script>
