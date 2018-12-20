<template>
  <v-card class="pa-4">
    <v-card-title>
      <span class="headline">{{ $t('employees.forms.archive.title') }}</span>
    </v-card-title>

    <v-form>
      <v-card-text>
        <v-alert :value="true" type="warning" class="text-xs-center" outline>
          {{ $t('employees.forms.archive.warning') }}
        </v-alert>
        <p class="subheading pt-3">{{ $t('employees.forms.archive.text') }}</p>

        <v-form ref="archiveEmployee">
          <v-radio-group v-model="state" class="pt-3 text-xs-center" row>
            <v-radio :label="$t('employees.forms.archive.too_experienced')" value="experienced"></v-radio>
            <v-radio :label="$t('employees.forms.archive.released')" value="released"></v-radio>
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
                :label="$t('employees.forms.archive.released_at')"
                :rules="[vRequired]"
                append-icon="event"
                readonly
              ></v-text-field>
              <v-date-picker
                v-model="released_at"
                @input="$refs.menu2.save(released_at)"
                :locale="$i18n.locale"
                :max="$moment().format()"
                no-title scrollable></v-date-picker>
            </v-menu>
          </div>
        </v-form>

      </v-card-text>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="grey darken-1" flat @click="cancel">{{ $t('buttons.cancel') }}</v-btn>
        <v-btn color="green darken-1" @click="archiveEmployee" :disabled="isBtnDisabled" flat>{{ $t('buttons.archive') }}</v-btn>
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
          this.flash({ success: this.$root.$t('employees.flashes.archive.success') })
          this.$emit('close')
        })
        .catch(error => {
          this.flash({ error: this.$root.$t('employees.flashes.archive.error', { reason: this.renderError(error.response) }) })
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
