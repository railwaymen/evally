<template>
  <div class="sidebar sidebar--boxed">
    <div class="vcard">
      <h3 class="vcard__fullname">{{ recruitment.fullname }}</h3>

      <div class="vcard__content">
        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.gender') }}</div>
          <div class="vcard__value">{{ recruitment.gender }}</div>
        </div>
        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.email') }}</div>
          <div class="vcard__value">{{ recruitment.email }}</div>
        </div>
        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.phoneNumber') }}</div>
          <div class="vcard__value">{{ recruitment.phone }}</div>
        </div>
        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.group') }}</div>
          <div class="vcard__value">{{ recruitment.group }}</div>
        </div>
        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.position') }}</div>
          <div class="vcard__value">{{ recruitment.position }}</div>
        </div>
        <div class="vcard__info">
          <div class="vcard__label">{{ $t('components.recruitments.sidebar.received_at') }}</div>
          <div class="vcard__value">{{ recruitment.received_attion }}</div>
        </div>
      </div>
    </div>

  </div>
</template>

<script>
import { Recruitment } from '@models/recruitment'

export default {
  name: 'RecruitmentsSidebar',
  props: {
    recruitment: {
      type: Recruitment,
      required: true,
      default: () => new Recruitment()
    }
  }
}
</script>
