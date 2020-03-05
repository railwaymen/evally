<template>
  <v-card class="pa-3">
    <v-card-title>
      <span class="headline">{{ $t(`components.recruitments.recruitmentForm.${action}Title`) }}</span>
    </v-card-title>

    <v-flex class="px-2" xs12 lg6>
      <v-combobox
        v-model="localRecruitment.status"
        :items="this.statuses"
        :rules="[vRequired]"
        append-icon="mdi-chevron-down"
        prepend-inner-icon="mdi-account-multiple-outline"
        chips
        :label="$t('components.employees.employeeForm.group')"
      />
    </v-flex>

    <v-form ref="form" @submit.prevent="save">
      <v-card-text>
        <v-layout row wrap>
          <v-flex class="pa-2" xs12>
            <h3 class="subtitle-1">{{ $t('components.employees.employeeForm.general') }}</h3>
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-text-field
              v-model="localRecruitment.first_name"
              :rules="[vRequired]"
              :label="$t('shared.general.fields.firstName')"
              prepend-inner-icon="mdi-account-outline"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-text-field
              v-model="localRecruitment.last_name"
              :rules="[vRequired]"
              :label="$t('shared.general.fields.lastName')"
              prepend-inner-icon="mdi-account-outline"
            />
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
                v-model="localRecruitment.email"
                :rules="[vRequired]"
                :label="$t('shared.general.fields.phoneNumber')"
                prepend-inner-icon="mdi-account-outline"
              />
            </v-flex>


          <v-flex class="pa-2" xs12>
            <h3 class="subtitle-1">{{ $t('components.employees.employeeForm.employment') }}</h3>
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-combobox
              v-model="localRecruitment.group"
              :items="this.groups"
              :rules="[vRequired]"
              append-icon="mdi-chevron-down"
              prepend-inner-icon="mdi-account-multiple-outline"
              chips
              :label="$t('components.employees.employeeForm.group')"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-combobox
              v-model="localRecruitment.position"
              :items="this.positions"
              :rules="[vRequired]"
              append-icon="mdi-chevron-down"
              prepend-inner-icon="mdi-account-multiple-outline"
              chips
              :label="$t('components.employees.employeeForm.group')"
            />
          </v-flex>


        </v-layout>
      </v-card-text>

      <v-card-actions>
        <v-spacer />
        <v-btn
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

import { Recruitment } from '@models/recruitment'
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
      type: Recruitment,
      required: false,
      default: () => new Recruitment()
    }
  },
  data() {
    return {
      localRecruitment: new Recruitment({ ...this.recruitment }),
    }
  },
  methods: {
    save() {
      if (!this.$refs.form.validate()) return

    },
    ...mapActions({
      create: 'RecruitmentsModule/create',
    })
  },
  computed: {
    action() {
      return this.localRecruitment.isPersisted ? 'update' : 'create'
    }
  }
}
</script>
