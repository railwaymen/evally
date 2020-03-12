<template>
  <div class="widget widget--border-primary">
		<h3 class="widget__header">
      {{ $t('components.dashboard.upcoming.title') }}
    </h3>

		<div class="widget__body">
      <div v-if="loading" class="widget__loader">
				<v-progress-circular :size="30" :width="3" color="primary" indeterminate />
			</div>

      <v-list v-else>
        <v-list-item v-if="employees.isEmpty">
          <v-list-item-action>
            <v-icon>mdi-check-all</v-icon>
          </v-list-item-action>
          <v-list-item-content>
            <v-list-item-title>There are no upcoming evaluations to show</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-list-item v-for="employee in employees.models" :key="employee.id">
          <v-list-item-content>
            <v-list-item-title>
							<strong>{{ employee.fullname }}</strong>
							{{ $t('components.dashboard.upcoming.as') }}
							<em>{{ employee.position }}</em> - {{ employee.nextEvaluationOn }}
						</v-list-item-title>
          </v-list-item-content>

          <v-list-item-action>
            <v-tooltip bottom>
              <template #activator="{ on }">
                <v-btn
                  @click="openCreateForm(employee)"
                  v-on="on"
                  color="green"
                  icon
                >
                  <v-icon>mdi-plus</v-icon>
                </v-btn>
              </template>

              <span>{{ $t('shared.tooltips.create') }}</span>
            </v-tooltip>
					</v-list-item-action>
        </v-list-item>
      </v-list>
    </div>
  </div>
</template>

<script>
import { DialogsBus } from '@utils/dialogs_bus'

import { EmployeesList } from '@models/employee'
import { TemplatesList } from '@models/template'

import CreateForm from '@components/evaluations/CreateForm'

export default {
  name: 'UpcomingList',
  props: {
    employees: {
      type: EmployeesList,
      required: true,
      default: () => new EmployeesList()
    },
    templates: {
      type: TemplatesList,
      required: true,
      default: () => new TemplatesList()
    },
    loading: {
      type: Boolean,
      required: true,
      default: true
    }
  },
  methods: {
    openCreateForm(employee) {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: CreateForm,
        props: {
          templates: this.templates,
          defaultEmployee: employee
        }
      })
    },
  }
}
</script>
