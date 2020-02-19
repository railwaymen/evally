<template>
  <v-card class="pa-3">
    <v-card-title>
      <span class="headline">{{ $t(`components.users.userForm.${action}Title`) }}</span>
    </v-card-title>

    <v-form ref="form" @submit.prevent="save">
      <v-card-text>
        <v-layout row wrap>
          <v-flex class="px-3" xs12>
            <v-text-field
              v-model="localUser.email"
              :rules="[vRequired]"
              prepend-inner-icon="mdi-at"
              type="email"
              :label="$t('components.users.userForm.email')"
            />
          </v-flex>

          <v-flex class="px-3" xs12>
            <v-text-field
              v-model="localUser.first_name"
              :rules="[vRequired]"
              prepend-inner-icon="mdi-account-outline"
              :label="$t('components.users.userForm.firstName')"
            />
          </v-flex>

          <v-flex class="px-3" xs12>
            <v-text-field
              v-model="localUser.last_name"
              :rules="[vRequired]"
              prepend-inner-icon="mdi-account-outline"
              :label="$t('components.users.userForm.lastName')"
            />
          </v-flex>

          <v-flex class="px-3" xs12>
            <v-select
              v-model="localUser.role"
              :items="roles"
              :rules="[vRequired]"
              prepend-inner-icon="mdi-account-cog-outline"
              :label="$t('components.users.userForm.role')"
            />
          </v-flex>

          <v-flex v-if="localUser.isPersisted" class="px-3" xs12>
            <v-radio-group v-model="localUser.status" row>
              <template #label>{{ $t('components.users.userForm.status') }}: </template>

              <v-spacer />

              <v-radio :label="$t('models.user.statuses.active')" value="active" />
              <v-radio :label="$t('models.user.statuses.inactive')" value="inactive" />
            </v-radio-group>
          </v-flex>
        </v-layout>
      </v-card-text>

      <v-card-actions>
        <v-spacer />
        <v-btn
          @click="closeDialog"
          color="grey darken-1"
          text
        >
          {{ $t('shared.buttons.cancel') }}
        </v-btn>

        <v-btn
          type="submit"
          color="green darken-1"
          text
        >
          {{ $t('shared.buttons.save') }}
        </v-btn>
      </v-card-actions>
    </v-form>
  </v-card>
</template>

<script>
import { mapActions } from 'vuex'

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
      roles: [
        { text: this.$t('models.user.roles.admin'), value: 'admin' },
        { text: this.$t('models.user.roles.evaluator'), value: 'evaluator' }
      ]
    }
  },
  methods: {
    closeDialog() {
      this.$emit('closeDialog')
    },
    save() {
      if (!this.$refs.form.validate()) return

      (this.localUser.isPersisted ? this.update : this.create)(this.localUser)
        .then(this.closeDialog)
    },
    ...mapActions({
      create: 'UsersModule/create',
      update: 'UsersModule/update'
    })
  },
  computed: {
    action() {
      return this.localUser.isPersisted ? 'update' : 'create'
    }
  }
}
</script>
