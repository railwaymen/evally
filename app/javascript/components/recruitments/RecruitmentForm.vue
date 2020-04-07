<template>
  <v-card class="pa-3 height-100">
    <v-card-title>
      <span class="headline">{{ $t(`components.recruitments.recruitmentForm.${formAction}Title`) }}</span>
    </v-card-title>

    <v-form ref="form" @submit.prevent="save">
      <v-card-text>
        <v-layout row wrap>
          <v-flex class="px-2" xs12 lg6>
            <status-select
              v-model="localRecruitment.status"
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
              v-model="localRecruitment.evaluator_id"
              :label="$t('shared.general.fields.evaluator')"
              item-value="id"
              item-text="fullname"
              clearable
              small
            />
          </v-flex>

          <v-flex
            v-for="field in localRecruitment.status.required_fields"
            :key="field.value"
            class="px-2"
            xs12
          >
            <datetime-field
              v-if="field.type === 'datetime'"
              v-model="localRecruitment[field.value]"
              :label="field.label"
            />

            <v-textarea
              v-if="field.type === 'text'"
              v-model="localRecruitment[field.value]"
              :label="field.label"
              :rules="[vRequired]"
              rows="2"
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
            <v-radio-group v-model="localRecruitment.gender" row>
              <v-radio :label="$t('components.recruitments.recruitmentForm.male')" value="male" />
              <v-radio :label="$t('components.recruitments.recruitmentForm.female')" value="female" />
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
              prepend-inner-icon="mdi-at"
              :disabled="localRecruitment.isPersisted"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-text-field
              v-model="localRecruitment.phone"
              :label="$t('shared.general.fields.phoneNumber')"
              prepend-inner-icon="mdi-phone"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-combobox
              v-model="localRecruitment.group"
              :items="groups"
              :rules="[vRequired]"
              prepend-inner-icon="mdi-account-multiple-outline"
              chips
              :label="$t('shared.general.fields.group')"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-combobox
              v-model="localRecruitment.position"
              :items="positions"
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
              :label="$t('shared.general.fields.source')"
              prepend-inner-icon="mdi-email-receive-outline"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-menu
              :close-on-content-click="true"
              transition="scale-transition"
              :nudge-right="40"
              offset-y
              min-width="290px"
            >
              <template #activator="{ on }">
                <v-text-field
                  :value="localRecruitment.received_at"
                  :label="$t('components.recruitments.recruitmentForm.receivedDate')"
                  prepend-inner-icon="mdi-calendar"
                  :rules="[vRequired]"
                  readonly
                  v-on="on"
                />
              </template>

              <v-date-picker
                v-model="localRecruitment.received_at"
                :locale="$i18n.locale"
                no-title
                scrollable
              />
            </v-menu>
          </v-flex>

          <v-flex class="pa-2" xs12 >
            <h3 class="subtitle-1">{{ $t('components.recruitments.recruitmentForm.attachments') }}</h3>
          </v-flex>

          <v-flex class="px-2" xs12>
            <v-file-input
              :label="$t('components.recruitments.recruitmentForm.addFiles')"
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
                  @click="openDeleteAttachmentConfirm(attachment)"
                  color="red lighten-3"
                  icon
                >
                  <v-icon>mdi-delete-outline</v-icon>
                </v-btn>
              </v-list-item-action>
            </v-list-item>
          </v-flex>

          <v-flex class="pa-2" xs12 >
            <h3 class="subtitle-1">{{ $t('components.recruitments.recruitmentForm.socials') }}</h3>
          </v-flex>

          <v-flex xs12>
            <social-links-field v-model="localRecruitment.social_links"/>
          </v-flex>

          <v-flex class="pa-2" xs12 >
            <h3 class="subtitle-1">{{ $t('components.recruitments.recruitmentForm.agreements') }}</h3>
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-checkbox
              :label="$t('components.recruitments.recruitmentForm.acceptCurrentProcessing')"
              v-model="localRecruitment.accept_current_processing"
              :rules="[vRequired]"
            />
          </v-flex>

          <v-flex class="px-2" xs12 lg6>
            <v-checkbox
              :label="$t('components.recruitments.recruitmentForm.acceptFutureProcessing')"
              v-model="localRecruitment.accept_future_processing"
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
import SocialLinksField from '@components/shared/SocialLinksField'
import DeleteAttachmentConfirm from '@components/recruitments/DeleteAttachmentConfirm'
import StatusSelect from '@components/recruitments/StatusSelect'

export default {
  name: 'RecruitmentForm',
  components: { DatetimeField, SocialLinksField, StatusSelect },
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
      localRecruitment: new RecruitDocument({ ...this.recruitment }),
      selectedFile: new Attachment(),
      localFiles: []
    }
  },
  methods: {
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
    openDeleteAttachmentConfirm(attachment) {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: DeleteAttachmentConfirm,
        props: { attachment }
      })
    },
    reset() {
      this.localRecruitment = new RecruitDocument({ ...this.recruitment })
      this.localFiles = []
    },
    save() {
      if (!this.$refs.form.validate()) return

      (this.localRecruitment.isPersisted ? this.update : this.create)({
        recruitDocument: this.localRecruitment,
        attachments: this.localFiles
      })
        .then(data => {
          this.$router.push({
            name: 'recruitment_path',
            params: { publicRecruitId: data.public_recruit_id, id: data.id }
          })
        })
    },
    ...mapActions({
      create: 'RecruitDocumentsModule/create',
      update: 'RecruitDocumentsModule/update'
    })
  },
  computed: {
    formAction() {
      return this.localRecruitment.isPersisted ? 'update' : 'create'
    }
  },
  watch: {
    localFiles: {
      deep: true,
      handler(newFiles) {
        const file = newFiles.find(f => f.type === 'application/pdf') || newFiles[0]

        this.selectFile(file ? file : new Attachment())
      }
    }
  }
}
</script>
