<template>
  <v-form @submit.prevent="save" class="pa-3">
    <h2 class="subtitle-1 my-3">{{ $t('components.settings.userForm.basicInfo') }}</h2>

    <v-layout wrap row>
      <v-flex xs12>
        <v-text-field
          v-model="localUser.email"
          prepend-icon="mdi-at"
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

    <h2 class="subtitle-1 my-3">{{ $t('components.settings.userForm.signature') }}</h2>

    <v-layout>
      <v-flex xs12>
        <v-chip-group
          v-model="signaturePreview"
          color="primary"
          class="mb-3"
          mandatory
        >
          <v-chip :value="false" filter-icon="mdi-pencil" label filter>
            {{ $t('shared.buttons.edit') }}
          </v-chip>

          <v-chip :value="true" filter-icon="mdi-eye-outline" label filter>
            {{ $t('shared.buttons.preview') }}
          </v-chip>
        </v-chip-group>

        <div
          v-if="signaturePreview"
          class="email__signature"
          v-html="localUser.signature"
        />

        <v-textarea
          v-else
          v-model="localUser.signature"
        />
      </v-flex>
    </v-layout>

    <div class="settings__actions text-right">
      <v-btn @click="reset" text>
        {{ $t('shared.buttons.reset') }}
      </v-btn>

      <v-btn type="submit" color="primary" text>
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
      localUser: new User({ ...this.user }),
      signaturePreview: !!this.user.signature
    }
  },
  methods: {
    reset() {
      this.localUser = new User({ ...this.user })
      this.signaturePreview = !!this.user.signature
    },
    save() {
      this.$store.dispatch('AuthenticationModule/updateUser', this.localUser)
    }
  }
}
</script>
