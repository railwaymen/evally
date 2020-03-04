<template>
  <div class="sidebar sidebar--boxed">
    <div class="vcard">
      <h3 class="vcard__fullname">{{ recruitment.fullname }}</h3>
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
  },
  data() {
    return {
      panel: [0, 1]
    }
  }
}
</script>
