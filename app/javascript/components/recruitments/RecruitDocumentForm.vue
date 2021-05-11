<template>
  <v-card class="pa-3 height-100">
    <v-card-title>
      <span class="headline">{{ $t(`components.recruitments.recruitDocumentForm.${formAction}Title`) }}</span>
    </v-card-title>

    <v-form ref="form" @submit.prevent="save">
      <v-card-text>Project
        <v-layout row wrap>
          <v-flex class="px-2" xs12 lg6>
            <status-select
              :value="localRecruitDocument.status"
              @input="changeStatus"
              :items="statuses"
              :rules="[vRequired]"
              append-icon="mdi-chevron-down"
              prepend-inner-icon="mdi-label-outline"
              :label="$t('shared.general.fields.status')"
              return-object
              small
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-select
              :items="evaluators.models"
              v-model="localRecruitDocument.evaluator_token"
              :label="$t('shared.general.fields.evaluator')"
              item-value="email_token"
              item-text="fullname"
              clearable
              small
            />
          </v-flex>

          <v-flex
            v-for="field in localRecruitDocument.status.required_fields"
            :key="field.value"
            class="px-2"
            xs12
          >
            <datetime-field
              v-if="field.type === 'datetime'"
              v-model="localRecruitDocument[field.value]"
              :label="field.label"
              :rules="[vRequired]"
            />

            <v-textarea
              v-if="field.type === 'text'"
              v-model="localRecruitDocument[field.value]"
              :label="field.label"
              :rules="[vRequired]"
              rows="2"
            />
          </v-flex>

          <v-flex class="pa-2" xs12>
            <h3 class="subtitle-1">{{ $t('components.recruitments.recruitDocumentForm.general') }}</h3>
          </v-flex>

          <v-flex class="px-2" xs12 lg4>
            <v-text-field
              v-model="localRecruitDocument.first_name"
              :rules="[vRequired]"
              :label="$t('shared.general.fields.firstName')"
              prepend-inner-icon="mdi-account-outline"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg4>
            <v-text-field
              v-model="localRecruitDocument.last_name"
              :rules="[vRequired]"
              :label="$t('shared.general.fields.lastName')"
              prepend-inner-icon="mdi-account-outline"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg4>
            <v-radio-group v-model="localRecruitDocument.gender" row>
              <v-radio :label="$t('components.recruitments.recruitDocumentForm.male')" value="male" />
              <v-radio :label="$t('components.recruitments.recruitDocumentForm.female')" value="female" />
            </v-radio-group>
          </v-flex>

          <v-flex class="pa-2" xs12 >
            <h3 class="subtitle-1">{{ $t('components.recruitments.recruitDocumentForm.contact') }}</h3>
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-text-field
              v-model="localRecruitDocument.email"
              :rules="[vRequired]"
              :label="$t('shared.general.fields.email')"
              prepend-inner-icon="mdi-at"
              :disabled="localRecruitDocument.isPersisted"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <phone-number-field
              v-model="localRecruitDocument.phone"
              :label="$t('shared.general.fields.phoneNumber')"
              prepend-inner-icon="mdi-phone"
            />
          </v-flex>

          <v-flex class="pa-2" xs12>
            <h3 class="subtitle-1">{{ $t('components.recruitments.recruitDocumentForm.applicationDetails') }}</h3>
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-combobox
              v-model="localRecruitDocument.group"
              :items="groups"
              :rules="[vRequired]"
              prepend-inner-icon="mdi-account-multiple-outline"
              chips
              :label="$t('shared.general.fields.group')"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-combobox
              v-model="localRecruitDocument.position"
              :items="positions"
              :rules="[vRequired]"
              append-icon="mdi-chevron-down"
              prepend-inner-icon="mdi-briefcase-outline"
              chips
              :label="$t('components.recruitments.recruitDocumentForm.position')"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-text-field
              v-model="localRecruitDocument.salary"
              :label="$t('shared.general.fields.salary')"
              prepend-inner-icon="mdi-cash"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-combobox
              v-model="localRecruitDocument.contract_type"
              :items="['Employment Contact', 'B2B', 'Civil Law Contract']"
              :label="$t('shared.general.fields.contractType')"
              prepend-inner-icon="mdi-briefcase-edit-outline"
              clearable
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-text-field
              v-model="localRecruitDocument.availability"
              :label="$t('shared.general.fields.availability')"
              prepend-inner-icon="mdi-account-clock-outline"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-menu
              ref="availableSincePicker"
              v-model="availableSincePicker"
              :close-on-content-click="false"
              :nudge-right="40"
              transition="scale-transition"
              offset-y
              min-width="290px"
            >
              <template #activator="{ on }">
                <v-text-field
                  :value="localRecruitDocument.availableSince"
                  @change="localRecruitDocument.set('available_since', null)"
                  :label="$t('shared.general.fields.availableSince')"
                  prepend-inner-icon="mdi-calendar"
                  clearable
                  readonly
                  v-on="on"
                />
              </template>
              <v-date-picker
                v-model="localRecruitDocument.availableSinceDate"
                @input="availableSincePicker = false"
                :locale="$i18n.locale"
                no-title
                scrollable
              />
            </v-menu>
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-text-field
              v-model="localRecruitDocument.location"
              :label="$t('shared.general.fields.location')"
              prepend-inner-icon="mdi-map-marker-outline"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-combobox
              v-model="localRecruitDocument.work_type"
              :items="['Stationary', 'Remotely', 'Mixed']"
              :label="$t('shared.general.fields.workType')"
              prepend-inner-icon="mdi-remote-desktop"
            />
          </v-flex>

          <v-flex class="px-2" xs12>
            <v-textarea
              v-model="localRecruitDocument.message"
              :label="$t('shared.general.fields.message')"
              prepend-inner-icon="mdi-file-document-outline"
              rows="3"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-combobox
              v-model="localRecruitDocument.source"
              :items="sources"
              prepend-inner-icon="mdi-email-receive-outline"
              :label="$t('shared.general.fields.source')"
              chips
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <datetime-field
              v-model="localRecruitDocument.received_at"
              :label="$t('components.recruitments.recruitDocumentForm.receivedDate')"
              :rules="[vRequired]"
            />
          </v-flex>

          <v-flex class="pa-2" xs12 >
            <h3 class="subtitle-1">{{ $t('components.recruitments.recruitDocumentForm.attachments') }}</h3>
          </v-flex>

          <v-flex class="px-2" xs12>
            <v-file-input
              :label="$t('components.recruitments.recruitDocumentForm.addFiles')"
              v-model="localFiles"
              multiple
              chips
            />
          </v-flex>

          <v-flex
            v-for="(file, index) in localFiles"
            :key="index"
            class="px-2"
            xs12
            lg6
          >
            <v-list-item
              @click="selectFile(file)"
              :input-value="selectedFile.id === `local-${index}`"
              color="primary"
              two-line
            >
              <v-list-item-action>
                <v-icon>{{ file.type | contentType2Icon }}</v-icon>
              </v-list-item-action>

              <v-list-item-content>
                <v-list-item-title>{{ file.name }}</v-list-item-title>
                <v-list-item-subtitle>{{ (file.size / 1024).toFixed(2) }}kB</v-list-item-subtitle>
              </v-list-item-content>

              <v-list-item-action>
                <v-btn
                  @click="localFiles.splice(index, 1)"
                  color="red lighten-3"
                  icon
                >
                  <v-icon>mdi-delete-outline</v-icon>
                </v-btn>
              </v-list-item-action>
            </v-list-item>
          </v-flex>

          <v-flex
            v-for="attachment in attachments.models"
            :key="attachment.id"
            class="px-2"
            xs12
            lg6
          >
            <v-list-item
              @click="selectFile(attachment)"
              :input-value="selectedFile.id === attachment.id"
              color="primary"
              two-line
            >
              <v-list-item-action>
                <v-icon>{{ attachment.content_type | contentType2Icon }}</v-icon>
              </v-list-item-action>

              <v-list-item-content>
                <v-list-item-title>{{ attachment.name }}</v-list-item-title>
                <v-list-item-subtitle>{{ attachment.size }}</v-list-item-subtitle>
              </v-list-item-content>

              <v-list-item-action>
                <v-btn
                  @click.stop="openDeleteAttachmentConfirm(attachment)"
                  color="red lighten-3"
                  icon
                >
                  <v-icon>mdi-delete-outline</v-icon>
                </v-btn>
              </v-list-item-action>
            </v-list-item>
          </v-flex>

          <v-flex class="pa-2" xs12 >
            <h3 class="subtitle-1">{{ $t('components.recruitments.recruitDocumentForm.socials') }}</h3>
          </v-flex>

          <v-flex xs12>
            <social-links-field v-model="localRecruitDocument.social_links"/>
          </v-flex>

          <v-flex class="pa-2" xs12 >
            <h3 class="subtitle-1">{{ $t('components.recruitments.recruitDocumentForm.agreements') }}</h3>
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-checkbox
              :label="$t('components.recruitments.recruitDocumentForm.acceptCurrentProcessing')"
              v-model="localRecruitDocument.accept_current_processing"
              :rules="[vRequired]"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-checkbox
              :label="$t('components.recruitments.recruitDocumentForm.acceptFutureProcessing')"
              v-model="localRecruitDocument.accept_future_processing"
            />
          </v-flex>
        </v-layout>
      </v-card-text>

      <v-card-actions>
        <v-spacer />

        <v-btn
          @click="reset"
          color="grey darken-1"
          text
        >
          {{ $t('shared.buttons.reset') }}
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
import { DialogsBus } from '@utils/dialogs_bus'

import { Attachment, AttachmentsList } from '@models/attachment'
import { RecruitDocument } from '@models/recruit_document'
import { UsersList } from '@models/user'

import DatetimeField from '@components/shared/DatetimeField'
import PhoneNumberField from '@components/shared/PhoneNumberField'
import SocialLinksField from '@components/shared/SocialLinksField'
import DeleteAttachmentConfirm from '@components/recruitments/DeleteAttachmentConfirm'
import StatusSelect from '@components/recruitments/StatusSelect'

export default {
  name: 'RecruitDocumentForm',
  components: {
    DatetimeField,
    PhoneNumberField,
    SocialLinksField,
    StatusSelect
  },
  props: {
    groups: {
      type: Array,
      required: false,
      default: () => []
    },
    positions: {
      type: Array,
      required: false,
      default: () => []
    },
    statuses: {
      type: Array,
      required: false,
      default: () => []
    },
    sources: {
      type: Array,
      required: false,
      default: () => []
    },
    recruitDocument: {
      type: RecruitDocument,
      required: false,
      default: () => new RecruitDocument()
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
    }
  },
  data() {
    return {
      localRecruitDocument: new RecruitDocument({ ...this.recruitDocument }),
      selectedFile: new Attachment(),
      localFiles: [],
      availableSincePicker: false
    }
  },
  methods: {
    ...mapActions('RecruitDocumentsModule', [
      'createRecruitDocument',
      'updateRecruitDocument'
    ]),
    selectFile(file) {
      if (file instanceof Attachment) {
        this.selectedFile = file

        return this.$emit('selectFile', file)
      }

      const reader = new FileReader()
      reader.readAsDataURL(file)

      reader.onload = () => {
        const selectedFile = new Attachment({
          id: `local-${this.localFiles.indexOf(file)}`,
          name: file.name,
          url: reader.result,
          content_type: file.type,
          size: `${(file.size / 1024).toFixed(2)}kB`
        })

        this.selectedFile = selectedFile
        this.$emit('selectFile', selectedFile)
      }
    },
    changeStatus(status) {
      const {
        incomplete_details,
        task_sent_at,
        call_scheduled_at,
        interview_scheduled_at,
        rejection_reason
      } = this.recruitDocument

      this.localRecruitDocument.assign({
        status, incomplete_details, task_sent_at, call_scheduled_at, interview_scheduled_at,
        rejection_reason
      })
    },
    openDeleteAttachmentConfirm(attachment) {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: DeleteAttachmentConfirm,
        props: { attachment }
      })
    },
    reset() {
      this.localRecruitDocument = new RecruitDocument({ ...this.recruitDocument })
      this.localFiles = []
    },
    save() {
      if (!this.$refs.form.validate()) return

      (this.localRecruitDocument.isPersisted ? this.updateRecruitDocument : this.createRecruitDocument)({
        recruitDocument: this.localRecruitDocument,
        attachments: this.localFiles
      })
        .then(data => {
          this.$router.push({
            name: 'candidate_document_path',
            params: { publicRecruitId: data.public_recruit_id, id: data.id }
          })
        })
    }
  },
  computed: {
    formAction() {
      return this.localRecruitDocument.isPersisted ? 'update' : 'create'
    }
  },
  watch: {
    localFiles: {
      deep: true,
      handler(newFiles) {
        const file = newFiles.find(f => f.type === 'application/pdf') || newFiles[0]

        this.selectFile(file || new Attachment())
      }
    }
  }
}
</script>
