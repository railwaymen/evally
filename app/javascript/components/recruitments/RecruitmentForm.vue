<template>
  <v-card class="pa-3">
    <v-card-title>
      <span class="headline">{{ $t(`components.recruitments.recruitmentForm.${action}Title`) }}</span>
    </v-card-title>

    <v-form ref="form" @submit.prevent="save" lazy-validation>
      <v-card-text>
        <v-layout row wrap>
          <v-flex class="px-2" xs12>
            <v-text-field
              v-model="localRecruitment.name"
              :rules="[vRequired]"
              :label="$t('shared.general.fields.name')"
              prepend-inner-icon="mdi-notebook-outline"
            />
          </v-flex>

          <v-flex class="px-2" xs12>
            <v-select
              v-model="localRecruitment.user_tokens"
              :items="users.models"
              :label="$t('shared.general.fields.participants')"
              prepend-inner-icon="mdi-account-group-outline"
              item-text="fullname"
              item-value="email_token"
              multiple
              chips
            />
          </v-flex>

          <v-flex class="px-2" xs12>
            <v-textarea
              v-model="localRecruitment.description"
              :label="$t('shared.general.fields.description')"
              prepend-inner-icon="mdi-clipboard-edit-outline"
            />
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
import { mapActions, mapState } from 'vuex'

import { Recruitment } from '@models/recruitment'

export default {
  name: 'RecruitmentForm',
  props: {
    recruitment: {
      type: Recruitment,
      required: false,
      default: () => new Recruitment()
    }
  },
  data() {
    return {
      localRecruitment: new Recruitment({ ...this.recruitment })
    }
  },
  methods: {
    ...mapActions('RecruitmentsModule', [
      'createRecruitment',
      'updateRecruitment'
    ]),
    closeDialog() {
      this.$emit('closeDialog')
    },
    save() {
      if (!this.$refs.form.validate()) return

      (this.localRecruitment.isPersisted ? this.updateRecruitment : this.createRecruitment)(this.localRecruitment)
        .then(this.closeDialog)
    }
  },
  computed: {
    ...mapState('RecruitmentsModule', [
      'users'
    ]),
    action() {
      return this.localRecruitment.isPersisted ? 'update' : 'create'
    }
  }
}
</script>
