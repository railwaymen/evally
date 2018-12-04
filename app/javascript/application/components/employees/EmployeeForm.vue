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
          ref="hiredMenu"
          :close-on-content-click="false"
          v-model="hiredMenu"
          :nudge-right="40"
          lazy
          :return-value.sync="hiredDate"
          transition="scale-transition"
          offset-y
          full-width
          min-width="290px"
        >
          <v-text-field
            slot="activator"
            v-model="hiredDate"
            :error-messages="employee.errors.hired_at"
            label="On board since"
            prepend-icon="event"
            readonly
          ></v-text-field>
          <v-date-picker
            v-model="hiredDate"
            @input="$refs.hiredMenu.save(employee.hired_at)"
            no-title
            scrollable
          ></v-date-picker>
        </v-menu>

        <v-menu
          v-if="employee.next_evaluation_at"
          ref="nextMenu"
          :close-on-content-click="false"
          v-model="nextMenu"
          :nudge-right="40"
          :return-value.sync="nextDate"
          lazy
          transition="scale-transition"
          offset-y
          full-width
          min-width="290px"
        >
          <v-text-field
            slot="activator"
            v-model="nextDate"
            label="Next evaluation at"
            prepend-icon="event"
            readonly
          ></v-text-field>
          <v-date-picker
            type="month"
            v-model="nextDate"
            @input="$refs.nextMenu.save(employee.next_evaluation_at)"
            :min="$moment().format()"
            no-title scrollable></v-date-picker>
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
      hiredMenu: false,
      nextMenu: false
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
    }),

    hiredDate: {
      get() {
        return this.employee.hired_at ? this.$moment(this.employee.hired_at).format('YYYY-MM-DD') : ''
      },
      
      set(date) {
        this.employee.hired_at = this.$moment(date, 'YYYY-MM-DD').format()
      }
    },

    nextDate: {
      get() {
        return this.$moment(this.employee.next_evaluation_at).format('YYYY-MM')
      },
      
      set(date) {
        this.employee.next_evaluation_at = this.$moment(date, 'YYYY-MM').format()
      }
    }
  }
}
</script>
