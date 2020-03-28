<template>
  <v-card class="pa-3" data-cy="delete-modal">
    <v-card-title>
      <span class="headline">{{ $t('components.recruitments.deleteAttachmentConfirm.title') }}</span>
    </v-card-title>

    <v-card-text>
      <p class="subtitle-1">{{ $t('components.recruitments.deleteAttachmentConfirm.body') }}</p>
      <p class=" body-1 mt-2 text-center">{{ attachment.name }} ({{ attachment.size }})</p>
    </v-card-text>

    <v-card-actions>
      <v-spacer />

      <v-btn
        @click="closeDialog"
        color="grey darken-1"
        data-cy="btn-cancel"
        text
      >
        {{ $t('shared.buttons.cancel') }}
      </v-btn>

      <v-btn
        @click="destroy"
        color="red darken-1"
        data-cy="btn-delete"
        text
      >
        {{ $t('shared.buttons.delete') }}
      </v-btn>
    </v-card-actions>

  </v-card>
</template>

<script>
import { Attachment } from '@models/attachment'

export default {
  name: 'DeleteAttachmentConfirm',
  props: {
    attachment: {
      type: Attachment,
      required: true,
      default: () => new Attachment()
    }
  },
  methods: {
    closeDialog() {
      this.$emit('closeDialog')
    },
    destroy() {
      this.$store.dispatch('RecruitDocumentsModule/destroyAttachment', this.attachment.id)
        .then(this.closeDialog)
    }
  }
}
</script>
