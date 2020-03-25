<template>
  <div class="sidebar sidebar--boxed">
    <div class="vcard">
      <div class="vcard__header">
        <h3 class="vcard__fullname">{{ recruitDocument.fullname }}</h3>

        <div class="vcard__socials">
          <v-btn icon href="http://github.com" target="_blank">
            <v-icon>mdi-github</v-icon>
          </v-btn>

          <v-btn icon href="http://linkedin.com" target="_blank">
            <v-icon>mdi-linkedin</v-icon>
          </v-btn>
        </div>
      </div>

      <div class="vcard__content">
        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.gender') }}</div>
          <div class="vcard__value">{{ recruitDocument.gender }}</div>
        </div>

        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.nationality') }}</div>
          <div class="vcard__value">{{ recruitDocument.nationality }}</div>
        </div>

        <h4 class="vcard__subheader">Contact Information</h4>

        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.phoneNumber') }}</div>
          <div class="vcard__value">{{ recruitDocument.phone }}</div>
        </div>

        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.email') }}</div>
          <div class="vcard__value">{{ recruitDocument.email }}</div>
        </div>

        <h4 class="vcard__subheader">Application Details</h4>

        <div class="vcard__info vcard__info--editable">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.status') }}</div>

          <div class="vcard__input">
            <status-select
              :items="statuses"
              :value="recruitDocument.status"
              @input="updateStatus"
              item-value="value"
              item-text="label"
              return-object
              dense
              block
            />
          </div>
        </div>

        <div class="vcard__info vcard__info--editable">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.group') }}</div>

          <div class="vcard__input">
            <v-combobox
              :items="groups"
              :value="recruitDocument.group"
              filled
              dense
            />
          </div>
        </div>

        <div class="vcard__info vcard__info--editable">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.position') }}</div>

          <div class="vcard__input">
            <v-combobox
              :items="positions"
              :value="recruitDocument.position"
              filled
              dense
            />
          </div>
        </div>

        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.source') }}</div>
          <div class="vcard__value">{{ recruitDocument.source }}</div>
        </div>

        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.receivedDate') }}</div>
          <div class="vcard__value">{{ recruitDocument.receivedAt }}</div>
        </div>

        <h4 class="vcard__subheader">Attached Files</h4>

        <div class="vcard__list">
          <v-list-item two-line>
            <v-list-item-action>
              <v-icon>mdi-file-pdf</v-icon>
            </v-list-item-action>

            <v-list-item-content>
              <v-list-item-title>CV.pdf</v-list-item-title>
              <v-list-item-subtitle>354kB</v-list-item-subtitle>
            </v-list-item-content>

            <v-list-item-action>
              <v-btn icon>
                <v-icon>mdi-close</v-icon>
              </v-btn>
            </v-list-item-action>
          </v-list-item>

          <v-list-item two-line>
            <v-list-item-action>
              <v-icon>mdi-folder-zip</v-icon>
            </v-list-item-action>

            <v-list-item-content>
              <v-list-item-title>portfolio.zip</v-list-item-title>
              <v-list-item-subtitle>1758kB</v-list-item-subtitle>
            </v-list-item-content>

            <v-list-item-action>
              <v-btn icon>
                <v-icon>mdi-close</v-icon>
              </v-btn>
            </v-list-item-action>
          </v-list-item>
        </div>
      </div>
    </div>

  </div>
</template>

<script>
import { DialogsBus } from '@utils/dialogs_bus'

import { RecruitDocument } from '@models/recruit_document'
import { Status } from '@models/status'

import StatusChangeForm from '@components/recruitments/StatusChangeForm'
import StatusSelect from '@components/recruitments/StatusSelect'

export default {
  name: 'RecruitmentsSidebar',
  components: { StatusSelect },
  props: {
    recruitDocument: {
      type: RecruitDocument,
      required: true,
      default: () => new RecruitDocument()
    },
    statuses: {
      type: Array,
      required: true,
      default: () => []
    },
    groups: {
      type: Array,
      required: true,
      default: () => []
    },
    positions: {
      type: Array,
      required: true,
      default: () => []
    }
  },

  methods: {
    updateStatus(selected) {
      const status = new Status({ ...selected })


      if (status.required_fields.length === 0) {
        return console.log('Save!')
      }

      DialogsBus.$emit('openFormsDialog', {
        innerComponent: StatusChangeForm,
        maxWidth: 500,
        props: { status }
      })
    }
  }
}
</script>
