<template>
  <div class="sidebar sidebar--boxed">
    <div v-if="loading" class="sidebar__loader">
      <v-progress-circular :size="30" :width="3" color="primary" indeterminate />
    </div>

    <div v-else class="vcard">
      <div class="vcard__header">
        <h3 class="vcard__fullname">
          {{ localRecruitDocument.fullname }}

          <span class="ml-2">
            <v-tooltip
              v-if="localRecruitDocument.accept_current_processing"
              bottom
            >
              <template #activator="{ on }">
                <v-chip v-on="on" color="primary" x-small>
                  {{ $t('components.recruitments.sidebar.cp') }}
                </v-chip>
              </template>

              <span>{{ $t('shared.tooltips.acceptCurrentProcessing') }}</span>
            </v-tooltip>

            <v-tooltip
              v-if="localRecruitDocument.accept_future_processing"
              bottom
            >
              <template #activator="{ on }">
                <v-chip v-on="on" color="secondary" x-small>
                  {{ $t('components.recruitments.sidebar.fp') }}
                </v-chip>
              </template>

              <span>{{ $t('shared.tooltips.acceptFutureProcessing') }}</span>
            </v-tooltip>
          </span>
        </h3>

        <div class="vcard__socials">
          <v-tooltip
            v-for="(link, index) in localRecruitDocument.social_links"
            :key="index"
            bottom
          >
            <template #activator="{ on }">
              <v-btn
                v-on="on"
                :href="link"
                target="_blank"
                icon
              >
                <v-icon>{{ icons[index] }}</v-icon>
              </v-btn>
            </template>

            <span>{{ link }}</span>
          </v-tooltip>
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
              :disabled="!recruitDocumentPolicy.canEdit"
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
              :disabled="!recruitDocumentPolicy.canEdit"
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
              :value="localRecruitDocument.evaluator_token"
              @input="assignEvaluator"
              item-value="email_token"
              item-text="fullname"
              clearable
              filled
              dense
            />
          </div>
        </div>

        <template v-if="recruitDocumentPolicy.canEdit">
          <div class="vcard__info">
            <div class="vcard__label">{{ $t('components.recruitments.sidebar.salary') }}</div>
            <div class="vcard__value">{{ localRecruitDocument.salary || '---' }}</div>
          </div>

          <div class="vcard__info">
            <div class="vcard__label">{{ $t('components.recruitments.sidebar.contractType') }}</div>
            <div class="vcard__value">{{ localRecruitDocument.contract_type || '---' }}</div>
          </div>
        </template>

        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.availability') }}</div>
          <div class="vcard__value">{{ localRecruitDocument.availability || '---' }}</div>
        </div>

        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.availableSince') }}</div>
          <div class="vcard__value">{{ localRecruitDocument.availableSince || '---' }}</div>
        </div>

        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.location') }}</div>
          <div class="vcard__value">{{ localRecruitDocument.location || '---' }}</div>
        </div>

        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.workType') }}</div>
          <div class="vcard__value">{{ localRecruitDocument.work_type || '---' }}</div>
        </div>

        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.source') }}</div>
          <div class="vcard__value">{{ localRecruitDocument.source }}</div>
        </div>

        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.receivedDate') }}</div>
          <div class="vcard__value">{{ localRecruitDocument.receivedAt }}</div>
        </div>

        <template v-if="localRecruitDocument.message">
          <h4 class="vcard__subheader">{{ $t('components.recruitments.sidebar.message') }}</h4>

          <div class="vcard__info">
            <div class="vcard__text">{{ localRecruitDocument.message }}</div>
          </div>
        </template>

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

            <v-list-item-action v-if="recruitDocumentPolicy.canEdit">
              <v-btn
                @click.stop="openDeleteAttachmentConfirm(attachment)"
                color="red lighten-3"
                icon
              >
                <v-icon>mdi-delete-outline</v-icon>
              </v-btn>
            </v-list-item-action>
          </v-list-item>

          <v-list-item v-if="recruitDocumentPolicy.canEdit">
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
import { mapActions, mapGetters } from 'vuex'
import { DialogsBus } from '@utils/dialogs_bus'

import { AttachmentsList } from '@models/attachment'
import { RecruitDocument } from '@models/recruit_document'
import { Status } from '@models/status'
import { User, UsersList } from '@models/user'

import DeleteAttachmentConfirm from '@components/recruitments/DeleteAttachmentConfirm'
import StatusChangeForm from '@components/recruitments/StatusChangeForm'
import StatusSelect from '@components/recruitments/StatusSelect'

import { linksToIcons } from '@utils/helpers'

export default {
  name: 'RecruitDocumentSidebar',
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
    loading: {
      type: Boolean,
      required: true,
      default: true
    }
  },
  data() {
    return {
      localRecruitDocument: new RecruitDocument({ ...this.recruitDocument }),
      localAttachments: []
    }
  },
  methods: {
    ...mapActions('RecruitDocumentsModule', [
      'updateRecruitDocument',
      'uploadAttachments'
    ]),
    assignEvaluator(value) {
      this.localRecruitDocument.evaluator_token = value

      this.updateRecruitDocument({ recruitDocument: this.localRecruitDocument })
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

      this.updateRecruitDocument({ recruitDocument: this.localRecruitDocument })
    },
    updatePosition(selectedPosition) {
      if (!selectedPosition) {
        return this.flash({ error: this.$i18n.t('messages.recruitments.show.positionError') })
      }

      this.updateRecruitDocument({ recruitDocument: this.localRecruitDocument })
    },
    updateStatus(selectedStatus) {
      if (selectedStatus.required_fields.length === 0) {
        return this.updateRecruitDocument({ recruitDocument: this.localRecruitDocument })
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
    }
  },
  computed: {
    ...mapGetters('RecruitDocumentsModule', [
      'recruitDocumentPolicy'
    ]),
    icons() {
      return linksToIcons(this.localRecruitDocument.social_links)
    }
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
