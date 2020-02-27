<template>
  <v-card class="pa-3">
    <div v-if="loading" class="numbers-tile__loader">
      <v-progress-circular :size="30" :width="3" :color="color" indeterminate />
    </div>

    <div v-else class="numbers-tile__row">
      <div v-if="$slots['left-side']" class="numbers-tile__side numbers-tile__side--left">
        <slot name="left-side" />
      </div>

      <div v-if="$slots['right-side']" class="numbers-tile__side numbers-tile__side--right">
        <slot name="right-side" />
      </div>
    </div>

    <div class="numbers-tile__title">
      <v-card-subtitle class="text-center">{{ title }}</v-card-subtitle>
    </div>
  </v-card>
</template>

<script>
import { EmployeesAnalytics } from '@models/employees_analytics'

export default {
  name: 'NumbersTile',
  props: {
    title: {
      type: String,
      required: true,
      default: 'Widget'
    },
    loading: {
      type: Boolean,
      required: true,
      default: true
    },
    color: {
      type: String,
      required: false,
      default: 'primary'
    }
  }
}
</script>
