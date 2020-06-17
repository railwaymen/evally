<template>
  <v-form ref="form" @submit.prevent="save">
    <div class="settings pa-3">
      <div class="setting">
        <v-list>
          <v-list-item>
            <v-list-item-action>
              <v-chip-group
                v-model="localSetting.enable_upcoming_notifications"
                color="primary"
                mandatory
              >
                <v-chip :value="false" filter-icon="mdi-close" label filter>
                  {{ $t('shared.buttons.no') }}
                </v-chip>

                <v-chip :value="true" filter-icon="mdi-check" label filter>
                  {{ $t('shared.buttons.yes') }}
                </v-chip>
              </v-chip-group>
            </v-list-item-action>

            <v-list-item-content>
              <v-list-item-title>
                {{ $t('components.settings.notificationsForm.enableUpcomingNotifications') }}
              </v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list>
      </div>

      <div class="settings__actions text-right">
        <v-btn @click="reset" text>
          {{ $t('shared.buttons.reset') }}
        </v-btn>

        <v-btn type="submit" color="primary" text>
          {{ $t('shared.buttons.save') }}
        </v-btn>
      </div>
    </div>
  </v-form>
</template>

<script>
import { Setting } from '@models/setting'

export default {
  name: 'NotificationsForm',
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
      this.$store.dispatch('AuthenticationModule/updateSetting', this.localSetting)
    }
  }
}
</script>
