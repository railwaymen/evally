<template>
  <v-text-field
    v-bind="$attrs"
    v-on="$listeners"
    v-mask="'###-###-####'"
  />
</template>

<script>
import { mask } from 'vue-the-mask'

export default {
  name: 'PhoneNumberField',
  inheritAttrs: false,
  directives: { mask }
}
</script>
