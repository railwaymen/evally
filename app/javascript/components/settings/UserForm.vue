<template>
  <v-form @submit.prevent="save" class="pa-3">
    <h2 class="subheading my-3">{{ $t('components.settings.userForm.subtitle') }}</h2>

    <v-layout wrap row>
      <v-flex xs12>
        <v-text-field
          v-model="localUser.email"
          prepend-icon="alternate_email"
          :label="$t('components.settings.userForm.email')"
          disabled
        />
      </v-flex>

      <v-flex xs12 md6>
        <v-text-field
          v-model="localUser.first_name"
          :rules="[vRequired]"
          maxlength="32"
          :label="$t('components.settings.userForm.firstName')"
        />
      </v-flex>

      <v-flex xs12 md6>
        <v-text-field
          v-model="localUser.last_name"
          :rules="[vRequired]"
          maxlength="32"
          :label="$t('components.settings.userForm.lastName')"
        />
      </v-flex>
    </v-layout>

    <div class="settings__actions text-xs-right">
      <v-btn @click="reset" flat>
        {{ $t('shared.buttons.reset') }}
      </v-btn>

      <v-btn type="submit" class="primary" flat>
        {{ $t('shared.buttons.save') }}
      </v-btn>
    </div>
  </v-form>
</template>

<script>
import { User } from '@models/user'

export default {
  name: 'UserForm',
  props: {
    user: {
      type: User,
      required: true,
      default: () => new User()
    }
  },
  data() {
    return {
      localUser: new User({ ...this.user })
    }
  },
  methods: {
    reset() {
      this.localUser = new User({ ...this.user })
    },
    save() {
      this.$store.dispatch('SessionModule/updateUser', this.localUser)
    }
  }
}
</script>