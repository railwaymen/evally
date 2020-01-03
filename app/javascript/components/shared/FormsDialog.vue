<template>
  <v-dialog v-model="dialog" persistent :max-width="maxWidth">
    <component :is="innerComponent" v-bind="props" @closeDialog="closeDialog"/>
  </v-dialog>
</template>

<script>
import { DialogsBus } from '@utils/dialogs_bus'

const initialData = () => ({
  dialog: false,
  innerComponent: null,
  maxWidth: null,
  props: null
})

export default {
  name: 'FormsDialog',
  data: () => initialData(),
  methods: {
    closeDialog() {
      Object.assign(this.$data, initialData())
    }
  },
  created() {
    DialogsBus.$on('openFormsDialog', ({ innerComponent, props, maxWidth = 500 }) => {
      this.innerComponent = innerComponent
      this.maxWidth = maxWidth
      this.props = props
      this.dialog = true
    })
  }
}
</script>
