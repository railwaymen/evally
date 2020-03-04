<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">
        <h2>{{ $t('views.recruitments.show.title') }}</h2>
      </div>

      <recruitments-sidebar
        :recruitment="recruitment"
      />
    </div>
  </section>
</template>

<script>
import { mapGetters } from 'vuex'
import { Recruitment } from '@models/recruitment'
import RecruitmentsSidebar from '@components/recruitments/RecruitmentsSidebar'

export default {
  name: 'RecruitmentsShow',
  components: { RecruitmentsSidebar },
  computed: {
     ...mapGetters({
      recruitment: 'RecruitmentsModule/recruitment'
    })
  },
  created() {
    this.$store.dispatch('RecruitmentsModule/show', this.$route.params.id)
  },
}
</script>
