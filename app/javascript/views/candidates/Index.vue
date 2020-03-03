<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">

        <h2 v-if="$route.name === 'candidates_path'">{{ $t('views.candidates.index.title') }}</h2>
        <router-view v-else />
      </div>
    </div>


  </section>
</template>

<script>
export default {
  name: 'CandidatesIndex'
}
</script>
