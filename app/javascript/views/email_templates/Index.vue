<template>
  <section class="panel">
    <div class="panel__row">
      <div class="panel__name">
        <h2>{{ $t('views.templates.index.title') }}</h2>
      </div>

      <div class="panel__nav">
        <v-btn
          color="primary"
          :to="{ name: 'evaluation_templates_path' }"
          text
        >
          Evaluation
        </v-btn>

        <v-btn
          color="primary"
          :to="{ name: 'email_templates_path' }"
          text
        >
          Email
        </v-btn>
      </div>

      <div class="panel__actions">

      </div>
    </div>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout wrap row>

        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
export default {
  name: 'EmailTemplates'
}
</script>
