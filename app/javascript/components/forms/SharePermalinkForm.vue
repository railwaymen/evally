<template>
  <v-card class="pa-4">
    <v-card-title>
      <span class="headline">Share {{ options.action }}</span>
    </v-card-title>

    <v-form>
      <v-card-text>
        <div class="text-xs-center">
          <p class="subheading">Copy the permalink below to share the latest {{ employee.first_name }}'s evaluation:</p>
          <span class="body-1">{{ `${baseURL}/browse/${employee.public_token}` }}</span>
          <v-btn icon flat>
            <v-icon small>file_copy</v-icon>
          </v-btn>
        </div>
      </v-card-text>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="grey darken-1" flat @click="closeModal">Close</v-btn>
        <!-- <v-btn color="green darken-1" flat @click="sendForm">{{ options.action }}</v-btn> -->
      </v-card-actions>
    </v-form>

  </v-card>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'EmployeeForm',
  props: { options: Object },
  data() {
    return {
      baseURL: window.location.origin
    }
  },
  methods: {
    closeModal() {
      this.employee.reset()
      this.$emit('close')
    },
  },
  computed: {
    ...mapGetters({
      employee: 'EmployeesStore/employee'
    })
  }
}
</script>
