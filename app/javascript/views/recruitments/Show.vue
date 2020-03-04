<template>
  <section class="panel">
    <div class="panel__row">
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
