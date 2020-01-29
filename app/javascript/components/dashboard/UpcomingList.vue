<template>
  <div class="widget widget--border-primary">
		<h3 class="widget__header">{{ $t('dashboard.upcoming.title') }}</h3>

		<div class="widget__body">
      <div v-if="loading" class="widget__loader">
				<v-progress-circular :size="30" :width="3" color="primary" indeterminate></v-progress-circular>
			</div>

      <v-list v-else>
        <v-list-tile v-if="employees.isEmpty">
          <v-list-tile-action>
            <v-icon>done_all</v-icon>
          </v-list-tile-action>
          <v-list-tile-content>
            <v-list-tile-title>There are no upcoming evaluations to show</v-list-tile-title>
          </v-list-tile-content>
        </v-list-tile>

        <v-list-tile v-for="employee in employees.models" :key="employee.id" avatar>
          <v-list-tile-content>
            <v-list-tile-title>
							<strong>{{ employee.fullname }}</strong>
							{{ $t('dashboard.common.as') }}
							<em>{{ employee.position }}</em> - {{ employee.nextEvaluationAt }}
						</v-list-tile-title>
          </v-list-tile-content>

          <v-list-tile-action>
						<v-tooltip bottom>
							<v-btn
                @click="openCreateForm(employee)"
                slot="activator"
                color="green"
                icon
                flat
              >
								<v-icon>add</v-icon>
							</v-btn>
							<span>{{ $t('dashboard.upcoming.new_tooltip') }}</span>
						</v-tooltip>
					</v-list-tile-action>
        </v-list-tile>
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
