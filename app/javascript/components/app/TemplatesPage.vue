<template>
  <section class="panel">
    <v-layout row>
      <v-flex xs6>
        <h2 class="panel__heading">Templates</h2>
      </v-flex>

      <v-flex>
        <div class="panel__action-bar">
          <v-btn color="green" flat>
            <v-icon>add</v-icon> New template
          </v-btn>
          <v-btn flat>
            <v-icon>edit</v-icon> Edit
          </v-btn>
          <v-btn color="red" flat>
            <v-icon>delete</v-icon> Delete
          </v-btn>
        </div>
      </v-flex>
    </v-layout>

    <div class="panel__content">
      <v-container grid-list-lg fluid>
        <v-layout row>
          <v-flex xs3>
            <templates-list></templates-list>
          </v-flex>

          <v-flex xs9>
            <template-form></template-form>
          </v-flex>
        </v-layout>
      </v-container>
    </div>
  </section>
</template>

<script>
import TemplateForm from './templates/TemplateForm'
import TemplatesList from './templates/TemplatesList'

export default {
  name: 'TemplatesPage',
  components: { TemplateForm, TemplatesList }
}
</script>