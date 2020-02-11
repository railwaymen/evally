<template>
  <div class="widget widget--border-primary">
    <h3 class="widget__header">
      Average Employment
    </h3>

    <div class="widget__body">
      <div v-if="loading" class="widget__loader">
        <v-progress-circular :size="30" :width="3" color="primary" indeterminate />
      </div>

      <h3 class="widget__info">{{ analytics.averageEmployment }}</h3>
    </div>
  </div>
</template>

<script>
import { EmployeesAnalytics } from '@models/employees_analytics'

export default {
  name: 'AverageEmploymentWidget',
  props: {
    analytics: {
      type: EmployeesAnalytics,
      required: true,
      default: () => new EmployeesAnalytics()
    },
    loading: {
      type: Boolean,
      required: true,
      default: true
    }
  }
}
</script>
