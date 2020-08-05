<template>
  <v-card class="pa-3" data-cy="delete-modal">
    <v-card-title>
      <span class="headline">{{ $t('components.recruitments.deleteConfirm.title') }}</span>
    </v-card-title>

    <v-card-text>
      <p
        v-html="$t('components.recruitments.deleteConfirm.body', { name: this.recruitDocument.fullname })"
        class="subtitle-1"
      />
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
import { RecruitDocument } from '@models/recruit_document'

export default {
  name: 'DeleteConfirm',
  props: {
    recruitDocument: {
      type: RecruitDocument,
      required: true,
      default: new RecruitDocument()
    }
  },
  methods: {
    closeDialog() {
      this.$emit('closeDialog')
    },
    destroy() {
      this.$store.dispatch('RecruitDocumentsModule/removeRecruitDocument', this.recruitDocument)
        .then(() => this.$router.push({ name: 'recruitments_path' }))
        .finally(this.closeDialog)
    }
  }
}
</script>
