<template>
  <div class="sidebar sidebar--boxed">
    <div class="vcard">
      <h3 class="vcard__fullname">{{ recruitDocument.fullname }}</h3>

      <div class="vcard__content">
        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.gender') }}</div>
          <div class="vcard__value">{{ recruitDocument.gender }}</div>
        </div>
        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.email') }}</div>
          <div class="vcard__value">{{ recruitDocument.email }}</div>
        </div>
        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.phoneNumber') }}</div>
          <div class="vcard__value">{{ recruitDocument.phone }}</div>
        </div>
        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.group') }}</div>
          <div class="vcard__value">{{ recruitDocument.group }}</div>
        </div>
        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.position') }}</div>
          <div class="vcard__value">{{ recruitDocument.position }}</div>
        </div>
        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.received_at') }}</div>
          <div class="vcard__value">{{ recruitDocument.receivedAt }}</div>
        </div>
      </div>
    </div>

  </div>
</template>

<script>
import { RecruitDocument } from '@models/recruit_document'

export default {
  name: 'RecruitmentsSidebar',
  props: {
    recruitDocument: {
      type: RecruitDocument,
      required: true,
      default: () => new RecruitDocument()
    }
  }
}
</script>
