<template>
  <div class="sidebar sidebar--boxed">
    <div class="vcard">
      <h3 class="vcard__fullname">{{ employee.fullname }}</h3>
      <h4 class="vcard__position">{{ employee.position }}</h4>

      <div class="vcard__content">
        <div class="vcard__info">
          <div class="vcard__label">Group</div>
          <div class="vcard__value">{{ employee.group }}</div>
        </div>

        <div class="vcard__info">
          <div class="vcard__label">Hired At</div>
          <div class="vcard__value">{{ employee.hiredAt }}</div>
        </div>

        <div class="vcard__info">
          <div class="vcard__label">Next Evaluation At</div>
          <div class="vcard__value">{{ employee.nextEvaluationAt }}</div>
        </div>
      </div>
    </div>

    <v-expansion-panel class="elevation-0">
      <v-expansion-panel-content>
        <template #header>
          <h5 class="body-1">Completed Evaluations</h5>
        </template>

        <v-list two-line subheader>
          <v-list-tile v-for="evaluation in evaluations.models" :key="evaluation.id">
            <v-list-tile-content>
              <v-list-tile-title class="body-1">{{ evaluation.template_name }}</v-list-tile-title>
              <v-list-tile-sub-title>{{ evaluation.completedAt }}</v-list-tile-sub-title>
            </v-list-tile-content>
          </v-list-tile>

          <v-list-tile v-if="evaluations.isEmpty">
            <v-list-tile-content>
              <v-list-tile-title class="body-1">No evaluations yet</v-list-tile-title>
            </v-list-tile-content>
          </v-list-tile>
        </v-list>
      </v-expansion-panel-content>
    </v-expansion-panel>

    <v-expansion-panel class="elevation-0">
      <v-expansion-panel-content>
        <template #header>
          <h5 class="body-1">Position Changes</h5>
        </template>

        <v-list two-line>
          <v-list-tile v-for="positionChange in positionChanges.models" :key="positionChange.id">
            <v-list-tile-content>
              <v-list-tile-title class="body-1">
                {{ positionChange.current_position }}
              </v-list-tile-title>

              <v-list-tile-sub-title class="body-2">
                {{ positionChange.changedAt }}
              </v-list-tile-sub-title>

              <v-list-tile-sub-title class="body-2">
                Previous: {{ positionChange.previous_position }}
              </v-list-tile-sub-title>
            </v-list-tile-content>
          </v-list-tile>

          <v-list-tile v-if="positionChanges.isEmpty">
            <v-list-tile-content>
              <v-list-tile-title class="body-1">No position changes yet</v-list-tile-title>
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
