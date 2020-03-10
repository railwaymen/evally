<template>
  <v-card class="pa-3">
    <v-card-title>
      <span class="headline">{{ $t(`components.recruitments.recruitmentForm.${formAction}Title`) }}</span>
    </v-card-title>

    <v-form ref="form" @submit.prevent="save">
      <v-card-text>

        <v-layout row wrap>
          <v-flex class="px-2" xs12 lg6>
            <v-combobox
              v-model="localRecruitment.status"
              :items="this.statuses"
              :rules="[vRequired]"
              append-icon="mdi-chevron-down"
              prepend-inner-icon="mdi-account-box-outline"
              chips
              :label="$t('shared.general.fields.status')"
            />
          </v-flex>

          <v-flex class="pa-2" xs12>
            <h3 class="subtitle-1">{{ $t('components.recruitments.recruitmentForm.general') }}</h3>
          </v-flex>

          <v-flex class="px-2" xs12 lg4>
            <v-text-field
              v-model="localRecruitment.first_name"
              :rules="[vRequired]"
              :label="$t('shared.general.fields.firstName')"
              prepend-inner-icon="mdi-account-outline"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg4>
            <v-text-field
              v-model="localRecruitment.last_name"
              :rules="[vRequired]"
              :label="$t('shared.general.fields.lastName')"
              prepend-inner-icon="mdi-account-outline"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg4>
            <v-radio-group v-model="localRecruitment.gender">
              <v-radio label="male" :value="$t('components.recruitments.male')" />
              <v-radio label="female" value="female" />
            </v-radio-group>
          </v-flex>

          <v-flex class="pa-2" xs12 >
            <h3 class="subtitle-1">{{ $t('components.recruitments.recruitmentForm.contact') }}</h3>
          </v-flex>

            <v-flex class="px-2" xs12 lg6>
              <v-text-field
                v-model="localRecruitment.email"
                :rules="[vRequired]"
                :label="$t('shared.general.fields.email')"
                prepend-inner-icon="mdi-account-outline"
              />
            </v-flex>

            <v-flex class="px-2" xs12 lg6>
              <v-text-field
                v-model="localRecruitment.phone"
                :rules="[vRequired]"
                :label="$t('shared.general.fields.phoneNumber')"
                prepend-inner-icon="mdi-account-outline"
              />
            </v-flex>


          <v-flex class="px-2" xs12 lg6>
            <v-combobox
              v-model="localRecruitment.group"
              :items="this.groups"
              :rules="[vRequired]"
              prepend-inner-icon="mdi-account-group-outline"
              chips
              :label="$t('shared.general.fields..group')"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-combobox
              v-model="localRecruitment.position"
              :items="this.positions"
              :rules="[vRequired]"
              append-icon="mdi-chevron-down"
              prepend-inner-icon="mdi-briefcase-outline"
              chips
              :label="$t('components.recruitments.recruitmentForm.position')"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
              <v-text-field
                v-model="localRecruitment.source"
                :rules="[vRequired]"
                :label="$t('shared.general.fields.source')"
                prepend-inner-icon="mdi-account-outline"
              />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-menu
              :close-on-content-click="true"
            >
            <template v-slot:activator="{ on }">
              <v-text-field
                :value="localRecruitment.received_at"
                prepend-inner-icon="mdi-calendar"
                :rules="[vRequired]"
                readonly
                v-on="on">
              </v-text-field>
            </template>

            <v-date-picker
              v-model="localRecruitment.received_at"
              :locale="$i18n.locale"
              no-title
              scrollable
             />
             </v-menu>
          </v-flex>

          <v-flex class="px-2" xs12 lg4>
            <v-radio-group v-model="localRecruitment.gender">
              <v-radio label="male" value="male" />
              <v-radio label="female" value="female" />
            </v-radio-group>
          </v-flex>

        </v-layout>
      </v-card-text>

      <v-card-actions>
        <v-spacer />
        <v-btn color="grey darken-1" text>
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

import { RecruitDocument } from '@models/recruit_document'
import { UsersList } from '@models/user'

export default {
  name: 'RecruitmentForm',
  props: {
    groups: {
      type: Array,
      required: true,
      default: () => []
    },
    positions: {
      type: Array,
      required: true,
      default: () => []
    },
    statuses: {
      type: Array,
      required: true,
      default: () => []
    },
    recruitment: {
      type: RecruitDocument,
      required: false,
      default: () => new RecruitDocument()
    }
  },
  data() {
    return {
      localRecruitment: new RecruitDocument({ ...this.recruitment }),
    }
  },
  methods: {
    save() {
      if (!this.$refs.form.validate()) return

      this.create( {recruitDocument: this.localRecruitment,
                    successHandler: this.$refs.form.reset} )
    },
    ...mapActions({
      create: 'RecruitDocumentsModule/create',
    })
  },
  computed: {
    formAction() {
      return this.localRecruitment.isPersisted ? 'update' : 'create'
    }
  }
}
</script>
