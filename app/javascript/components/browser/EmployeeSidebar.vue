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
      </div>
    </div>

    <v-expansion-panel class="elevation-0" expand :value="[true, true]">
      <v-expansion-panel-content>
        <template #header>
          <h5 class="body-2">
            {{ $t('components.employees.sidebar.completedEvaluations.title') }}
          </h5>
        </template>

        <v-list two-line subheader>
          <v-list-tile
            v-for="evaluation in evaluations.models"
            :key="evaluation.id"
            :to="evaluation.browsePath(employee.public_token)"
          >
            <v-list-tile-content>
              <v-list-tile-title>{{ evaluation.template_name }}</v-list-tile-title>
              <v-list-tile-sub-title>{{ evaluation.completedAt }}</v-list-tile-sub-title>
            </v-list-tile-content>
          </v-list-tile>

          <v-list-tile v-if="evaluations.isEmpty">
            <v-list-tile-content>
              <v-list-tile-title>
                {{ $t('components.employees.sidebar.completedEvaluations.noContent') }}
              </v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
        </v-list>
      </v-expansion-panel-content>

      <v-expansion-panel-content>
        <template #header>
          <h5 class="body-2">
            {{ $t('components.employees.sidebar.positionChanges.title') }}
          </h5>
        </template>

        <v-list two-line>
          <v-list-tile v-for="positionChange in positionChanges.models" :key="positionChange.id">
            <v-list-tile-content>
              <v-list-tile-title>
                {{ positionChange.current_position }}
              </v-list-tile-title>

              <v-list-tile-sub-title class="body-2">
                {{ positionChange.changedAt }}
              </v-list-tile-sub-title>

              <v-list-tile-sub-title class="body-2">
                {{ $t('components.employees.sidebar.positionChanges.previous', { name: positionChange.previous_position }) }}
              </v-list-tile-sub-title>
            </v-list-tile-content>
          </v-list-tile>

          <v-list-tile v-if="positionChanges.isEmpty">
            <v-list-tile-content>
              <v-list-tile-title>
                {{ $t('components.employees.sidebar.positionChanges.noContent') }}
              </v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
        </v-list>
      </v-expansion-panel-content>
    </v-expansion-panel>
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
  }
}
</script>
