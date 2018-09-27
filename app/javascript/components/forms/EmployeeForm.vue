<template>
  <v-card class="pa-4">
    <v-card-title>
      <span class="headline">{{ options.action | capitalize }} {{ options.model }}</span>
    </v-card-title>

    <v-form>
      <v-card-text>
        <v-text-field
          v-model="employee.first_name"
          label="First name"
        ></v-text-field>

        <v-text-field
          v-model="employee.last_name"
          label="Last name"
        ></v-text-field>

        <v-combobox
          v-model="employee.position"
          :items="items"
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
      menu: false,
      items: ['Ruby on Rails Developer', 'iOS Developr', 'Accountant']
    }
  },
  methods: {
    closeModal() {
      this.$emit('close')
    },
    sendForm() {
      console.log(this.employee)
      this.$emit('close')
    }
  },
  computed: {
    ...mapGetters({
      employee: 'EmployeesStore/employee',
    })
  }
}
</script>