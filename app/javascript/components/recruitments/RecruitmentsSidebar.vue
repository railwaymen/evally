<template>
  <div class="sidebar sidebar--boxed">
    <div class="vcard">
      <div class="vcard__header">
        <h3 class="vcard__fullname">{{ localRecruitDocument.fullname }}</h3>

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
        <div class="vcard__info vcard__info--editable">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.status') }}</div>

          <div class="vcard__input">
            <status-select
              :items="statuses"
              v-model="localRecruitDocument.status"
              @change="updateStatus"
              item-value="value"
              item-text="label"
              return-object
              filled
              dense
            />
          </div>
        </div>

        <div
          v-for="field in localRecruitDocument.status.required_fields"
          :key="field.value"
          class="vcard__info"
        >
          <template v-if="field.type === 'datetime'">
            <div class="vcard__label">{{ field.label }}</div>
            <div class="vcard__value">{{ recruitDocument.datetimeFormattedProperty(field.value) }}</div>
          </template>

          <v-textarea
            v-if="field.type === 'text'"
            :value="recruitDocument[field.value]"
            :label="field.label"
            readonly
            filled
          />
        </div>

        <h4 class="vcard__subheader">{{ $t('components.recruitments.sidebar.contactInformation') }}</h4>

        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.phoneNumber') }}</div>
          <div class="vcard__value">{{ localRecruitDocument.phone }}</div>
        </div>

        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.email') }}</div>
          <div class="vcard__value">{{ localRecruitDocument.email }}</div>
        </div>

        <h4 class="vcard__subheader">{{ $t('components.recruitments.sidebar.applicationDetails') }}</h4>

        <div class="vcard__info vcard__info--editable">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.group') }}</div>

          <div class="vcard__input">
            <v-combobox
              :items="groups"
              v-model="localRecruitDocument.group"
              @change="updateGroup"
              :rules="[vRequired]"
              :disabled="!policy.canEdit"
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
              v-model="localRecruitDocument.position"
              @change="updatePosition"
              :rules="[vRequired]"
              :disabled="!policy.canEdit"
              filled
              dense
            />
          </div>
        </div>

        <div class="vcard__info vcard__info--editable">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.evaluator') }}</div>

          <div class="vcard__input">
            <v-select
              :items="evaluators.models"
              :value="localRecruitDocument.evaluator_id"
              @input="assignEvaluator"
              :disabled="!policy.canEdit"
              :clearable="policy.canEdit"
              item-value="id"
              item-text="fullname"
              filled
              dense
            />
          </div>
        </div>

        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.source') }}</div>
          <div class="vcard__value">{{ localRecruitDocument.source }}</div>
        </div>

        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.receivedDate') }}</div>
          <div class="vcard__value">{{ localRecruitDocument.receivedAt }}</div>
        </div>

        <h4 class="vcard__subheader">{{ $t('components.recruitments.sidebar.attachments', { n: attachments.models.length }) }}</h4>

        <div class="vcard__list">
          <v-list-item
            v-for="attachment in attachments.models"
            :key="attachment.id"
            two-line
          >
            <v-list-item-action>
              <v-icon>{{ attachment.content_type | contentType2Icon }}</v-icon>
            </v-list-item-action>

            <v-list-item-content>
              <v-list-item-title>
                <a :href="attachment.url" target="_blank">{{ attachment.name }}</a>
              </v-list-item-title>

              <v-list-item-subtitle>{{ attachment.size }}</v-list-item-subtitle>
            </v-list-item-content>

            <v-list-item-action v-if="policy.canEdit">
              <v-btn
                @click.stop="openDeleteAttachmentConfirm(attachment)"
                color="red lighten-3"
                icon
              >
                <v-icon>mdi-delete-outline</v-icon>
              </v-btn>
            </v-list-item-action>
          </v-list-item>

          <v-list-item v-if="policy.canEdit">
            <v-list-item-content>
              <v-file-input
                @change="upload"
                v-model="localAttachments"
                :label="$t('components.recruitments.sidebar.addFile')"
                prepend-inner-icon="mdi-paperclip"
                prepend-icon=""
                multiple
                filled
                dense
              />
            </v-list-item-content>
          </v-list-item>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex'
import { DialogsBus } from '@utils/dialogs_bus'

import { RecruitDocumentPolicy } from '@policies/recruit_document_policy'

import { AttachmentsList } from '@models/attachment'
import { RecruitDocument } from '@models/recruit_document'
import { Status } from '@models/status'
import { User, UsersList } from '@models/user'

import DeleteAttachmentConfirm from '@components/recruitments/DeleteAttachmentConfirm'
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
    },
    attachments: {
      type: AttachmentsList,
      required: true,
      default: () => new AttachmentsList()
    },
    evaluators: {
      type: UsersList,
      required: true,
      default: () => new UsersList()
    },
    policy: {
      type: RecruitDocumentPolicy,
      required: true,
      default: () => new RecruitDocumentPolicy()
    }
  },
  data() {
    return {
      localRecruitDocument: new RecruitDocument({ ...this.recruitDocument }),
      localAttachments: []
    }
  },
  methods: {
    assignEvaluator(value = null) {
      this.localRecruitDocument.evaluator_id = value

      this.update(this.localRecruitDocument)
    },
    openDeleteAttachmentConfirm(attachment) {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: DeleteAttachmentConfirm,
        props: { attachment }
      })
    },
    updateGroup(selectedGroup) {
      if (!selectedGroup) {
        return this.flash({ error: this.$i18n.t('messages.recruitments.show.groupError') })
      }

      this.update(this.localRecruitDocument)
    },
    updatePosition(selectedPosition) {
      if (!selectedPosition) {
        return this.flash({ error: this.$i18n.t('messages.recruitments.show.positionError') })
      }

      this.update(this.localRecruitDocument)
    },
    updateStatus(selectedStatus) {
      if (selectedStatus.required_fields.length === 0) {
        return this.update(this.localRecruitDocument)
      }

      DialogsBus.$emit('openFormsDialog', {
        innerComponent: StatusChangeForm,
        maxWidth: 500,
        props: {
          recruitDocument: this.localRecruitDocument,
          prevStatus: new Status(this.recruitDocument.status)
        }
      })
    },
    upload() {
      if (this.localAttachments.length > 0) {
        this.uploadAttachments(this.localAttachments)
          .then(() => this.localAttachments = [])
      }
    },
    ...mapActions({
      update: 'RecruitDocumentsModule/update',
      uploadAttachments: 'RecruitDocumentsModule/uploadAttachments'
    })
  },
  watch: {
    recruitDocument: {
      deep: true,
      handler(newDoc) {
        this.localRecruitDocument = new RecruitDocument({ ...newDoc })
      }
    }
  }
}
</script>
