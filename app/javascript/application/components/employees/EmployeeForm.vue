<template>
  <v-card class="pa-4">
    <v-card-title>
      <span class="headline">{{ options.action | capitalize }} {{ options.model }}</span>
    </v-card-title>

    <v-form>
      <v-card-text>
        <v-text-field
          v-model="employee.first_name"
          :error-messages="employee.errors.first_name"
          label="First name"
        ></v-text-field>

        <v-text-field
          v-model="employee.last_name"
          :error-messages="employee.errors.last_name"
          label="Last name"
        ></v-text-field>

        <v-combobox
          v-model="employee.position"
          :error-messages="employee.errors.position"
          :items="positions"
          append-icon="expand_more"
          chips
          label="Position"
        ></v-combobox>

        <v-menu
          ref="menu"
          :close-on-content-click="false"
          v-model="menu"
          :nudge-right="40"
          :return-value.sync="employee.hired_at"
          lazy
          transition="scale-transition"
          offset-y
          full-width
          min-width="290px"
        >
          <v-text-field
            slot="activator"
            v-model="employee.hired_at"
            :error-messages="employee.errors.hired_at"
            label="On board since"
            prepend-icon="event"
            readonly
          ></v-text-field>
          <v-date-picker v-model="employee.hired_at" @input="$refs.menu.save(employee.hired_at)" no-title scrollable></v-date-picker>
        </v-menu>
      </v-card-text>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="grey darken-1" flat @click="closeModal">Cancel</v-btn>
        <v-btn color="green darken-1" flat @click="sendForm">{{ options.action }}</v-btn>
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
      menu: false
    }
  },
  methods: {
    closeModal() {
      this.employee.reset()
      this.$emit('close')
    },

    sendForm() {
      if (this.employee.validate()) {
        switch(this.options.action) {
          case 'create':
            this.$store.dispatch('EmployeesStore/create', { employee: this.employee.attributes })
              .then(() => {
                this.flash({ success: 'Employee has been succefully created.' })
                this.$emit('close')
              })
              .catch(error => {
                this.flash({ error: 'Employee cannot be created due to some error: ' + this.renderError(error.response) })
              })

            break

          case 'edit':
            this.$store.dispatch('EmployeesStore/update', { employee: this.employee.attributes })
              .then(() => {
                this.flash({ success: 'Employee has been succefully updated' })
                this.$emit('close')
              })
              .catch(error => {
                this.flash({ error: 'Employee cannot be updated due to some error: ' + this.renderError(error.response) })
              })

            break
        }
      }
    }
  },
  computed: {
    ...mapGetters({
      employee: 'EmployeesStore/employee',
      positions: 'EmployeesStore/positions'
    })
  }
}
</script>
