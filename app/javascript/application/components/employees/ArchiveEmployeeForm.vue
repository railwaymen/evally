<template>
  <v-card class="pa-4">
    <v-card-title>
      <span class="headline">{{ options.action | capitalize }} {{ options.model }}</span>
    </v-card-title>

    <v-form>
      <v-card-text>
        <v-alert :value="true" type="warning" class="text-xs-center" outline>
          This action cannot be undo. All drafted evaluations of the employee will be destroyed!
        </v-alert>
        <p class="subheading pt-3">Please, provide the reason to {{ options.action }} the {{ options.model }}:</p>

        <v-form ref="archiveEmployee">
          <v-radio-group v-model="state" class="pt-3 text-xs-center" row>
            <v-radio label="Too experienced" value="experienced"></v-radio>
            <v-radio label="Released" value="released"></v-radio>
          </v-radio-group>

          <div v-if="isReleasedSet" class="date">
            <v-menu
              ref="menu2"
              :close-on-content-click="false"
              v-model="dateMenu"
              :nudge-right="40"
              :return-value.sync="released_at"
              lazy
              transition="scale-transition"
              offset-y
              full-width
              min-width="290px"
            >
              <v-text-field
                slot="activator"
                v-model="released_at"
                label="Released at"
                append-icon="event"
                readonly
              ></v-text-field>
              <v-date-picker
                v-model="released_at"
                @input="$refs.menu2.save(released_at)"
                :max="$moment().format()"
                no-title scrollable></v-date-picker>
            </v-menu>
          </div>
        </v-form>

      </v-card-text>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="grey darken-1" flat @click="cancel">Cancel</v-btn>
        <v-btn color="green darken-1" @click="archiveEmployee" :disabled="isBtnDisabled" flat>{{ options.action }}</v-btn>
      </v-card-actions>
    </v-form>

  </v-card>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'ArchiveEmployeeForm',
  props: { options: Object },
  data() {
    return {
      state: null,
      released_at: null,
      dateMenu: false
    }
  },
  methods: {
    cancel() {
      this.$refs.archiveEmployee.reset()
      this.$emit('close')
    },

    archiveEmployee() {
      this.employee.state = this.state
      if (this.state === 'released') this.employee.released_at = this.released_at

      this.$store.dispatch('EmployeesStore/update', { employee: this.employee.attributes })
        .then(() => {
          this.flash({ success: 'Employee has been succefully archived' })
          this.$emit('close')
        })
        .catch(error => {
          this.flash({ error: 'Employee cannot be updated due to some error: ' + this.renderError(error.response) })
        })
    }
  },
  computed: {
    ...mapGetters({
      employee: 'EmployeesStore/employee'
    }),

    isReleasedSet() {
      return this.state === 'released'
    },

    isBtnDisabled() {
      return (this.state === 'released' && this.released_at === null) || this.state === null
    }
  }
}
</script>
