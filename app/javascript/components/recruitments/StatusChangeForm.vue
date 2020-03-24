<template>
  <v-card class="pa-3">
    <v-card-title>
      <span class="headline">{{ $t(`components.recruitments.statusChangeForm.title`) }}</span>
    </v-card-title>

    <v-form ref="form" @submit.prevent="save">
      <v-card-text>
        <v-layout row wrap>
          <v-flex class="pa-2" xs12>
            <p class="subtitle-1 text-center">
              Please provide additional information required to change status to:

              <v-chip
                :color="status.color"
                small
                dark
                label
              >
                {{ status.label }}
              </v-chip>
            </p>
          </v-flex>

          <v-flex
            v-for="field in status.required_fields"
            :key="field.value"
            class="pa-2"
            xs12
          >
            <template v-if="field.type === 'datetime'">
              <v-menu
                :close-on-content-click="true"
                :nudge-right="40"
                transition="scale-transition"
                offset-y
                min-width="290px"
              >
                <template v-slot:activator="{ on }">
                  <v-text-field
                    :value="form[field.value]"
                    :label="field.label"
                    :rules="[vRequired]"
                    prepend-inner-icon="mdi-calendar"
                    readonly
                    v-on="on"
                  />
                </template>
                <v-date-picker
                  v-model="form[field.value]"
                  :locale="$i18n.locale"
                  no-title
                  scrollable
                />
              </v-menu>
            </template>
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

import { Status } from '@models/status'

export default {
  name: 'StatusChangeForm',
  props: {
    status: {
      type: Status,
      required: true,
      default: () => new Status(),
    }
  },
  data() {
    return {
      form : Object.assign({}, ...this.status.required_fields.map(field => ({ [field['value']]: '' }))),
      test: ''
    }
  },
  methods: {
    closeDialog() {
      this.$emit('closeDialog')
    },
    save() {
      console.log('Save!')
    },
    ...mapActions({

    })
  },
}
</script>
