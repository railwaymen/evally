<template>
  <v-form ref="generalSettingForm" @submit.prevent="save">
    <div class="settings pa-3">
      <h2 class="subtitle-1 my-3">{{ $t('components.settings.generalForm.language.subtitle') }}</h2>

      <div class="setting">
        <v-radio-group v-model="localSetting.lang" row>
          <v-radio :label="$t('components.settings.generalForm.language.polish')" value="pl" />
          <v-radio :label="$t('components.settings.generalForm.language.english')" value="en" />
        </v-radio-group>
      </div>

      <h2 class="subtitle-1 my-3">{{ $t('components.settings.generalForm.widgets.subtitle') }}</h2>

      <div class="setting">
        <v-subheader>{{ $t('components.settings.generalForm.widgets.drafts') }}</v-subheader>
        <v-slider
          v-model="localSetting.default_draft_items"
          min="3"
          max="12"
          step="1"
          thumb-label="always"
        />
      </div>

      <div class="setting">
        <v-subheader>{{ $t('components.settings.generalForm.widgets.upcoming') }}</v-subheader>
        <v-slider
          v-model="localSetting.default_upcoming_items"
          min="3"
          max="12"
          step="1"
          thumb-label="always"
        />
      </div>

      <h2 class="subtitle-1 my-3">
        {{ $t('components.settings.generalForm.evaluations.subtitle') }}
      </h2>

      <div class="setting">
        <v-subheader>
          {{ $t('components.settings.generalForm.evaluations.nextEvaluationOffset') }}
        </v-subheader>

        <v-slider
          v-model="localSetting.default_next_evaluation_time"
          min="3"
          max="12"
          step="1"
          thumb-label="always"
        />
      </div>

      <div class="settings__actions text-xs-right">
        <v-btn @click="reset" flat>
          {{ $t('shared.buttons.reset') }}
        </v-btn>

        <v-btn type="submit" class="primary" flat>
          {{ $t('shared.buttons.save') }}
        </v-btn>
      </div>
    </div>
  </v-form>
</template>

<script>
import { Setting } from '@models/setting'

export default {
  name: 'GeneralForm',
  props: {
    setting: {
      type: Setting,
      required: true,
      default: () => new Setting()
    }
  },
  data() {
    return {
      localSetting: new Setting({ ...this.setting })
    }
  },
  methods: {
    reset() {
      this.localSetting = new Setting({ ...this.setting })
    },
    save() {
      this.$store.dispatch('SessionModule/updateSetting', this.localSetting)
        .then(setting => this.updateLocale(setting.lang))
    }
  }
}
</script>
