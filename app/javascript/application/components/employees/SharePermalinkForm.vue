<template>
  <v-card class="pa-4">
    <v-card-title>
      <span class="headline">{{ $t('employees.forms.permalink.title') }}</span>
    </v-card-title>

    <v-form>
      <v-card-text>
        <div class="text-xs-center">
          <p class="subheading">{{ $t('employees.forms.permalink.text') }}</p>
          <span class="subheading">{{ link }}</span>
        </div>
      </v-card-text>

      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="grey darken-1" flat @click="closeModal">{{ $t('buttons.cancel') }}</v-btn>
        <v-btn color="primary" flat @click="copyLink">
          <v-icon small>file_copy</v-icon>
          <span class="separator"></span>
          {{ $t('buttons.copy') }}
        </v-btn>
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

    copyLink() {
      this.$copyText(this.link).then(() => {
        this.flash({ success: this.$root.$t('employees.flashes.permalink.success') })
        this.$emit('close')
      })
    }
  },
  computed: {
    ...mapGetters({
      employee: 'EmployeesStore/employee'
    }),

    link() {
      return `${this.baseURL}/browse/${this.employee.public_token}`
    }
  }
}
</script>
