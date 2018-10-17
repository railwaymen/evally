<template>
  <div class="box box--with-content">
    <v-layout v-if="template.isExisting() || status == 'new_record'" row wrap>
      <v-flex xs12>
        <div class="template-header">
          <v-text-field
            label="Template name"
            v-model="template.name"
            :disabled="!template.editable"
            :error-messages="template.errors.name"
          ></v-text-field>
        </div>
      </v-flex>
      <v-flex xs6>
        <div class="employee-header">
          <h3 class="employee-header__fullname">&lsaquo; employee name &rsaquo;</h3>
          <h4 class="employee-header__position">&lsaquo; employee position &rsaquo;</h4>
        </div>

      </v-flex>

      <v-flex xs2>
        <div class="date-box">
          <h5 class="date-box__date">&lsaquo; date &rsaquo;</h5>
          <h6 class="date-box__description">on board since</h6>
        </div>
      </v-flex>
      <v-flex xs2>
        <div class="date-box">
          <h5 class="date-box__date">&lsaquo; date &rsaquo;</h5>
          <h6 class="date-box__description">previous evaluation</h6>
        </div>
      </v-flex>
      <v-flex xs2>
        <div class="date-box">
          <h5 class="date-box__date">&lsaquo; date &rsaquo;</h5>
          <h6 class="date-box__description">next evaluation</h6>
        </div>
      </v-flex>

      <v-flex xs12>
        <v-layout row wrap>
          <section-box
            v-for="(section, index) in sections.models"
            v-if="!section._destroy"
            :key="index"
            :section.sync="section"
          ></section-box>
        </v-layout>
      </v-flex>

      <new-section-form v-if="template.editable"></new-section-form>
    </v-layout>

    <v-layout row v-else>
      <v-flex xs12>
        <h4 class="no-content__header no-content__header--large">Select template from the list on the left or create a new one</h4>
      </v-flex>
    </v-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

import NewSectionForm from '../../forms/NewSectionForm'
import SectionBox from './SectionBox'

export default {
  name: 'EmployeeCard',
  components: { NewSectionForm, SectionBox },
  computed: {
    ...mapGetters({
      template: 'TemplatesStore/template',
      sections: 'SectionsStore/sections',
      status: 'TemplatesStore/status'
    })
  }
}
</script>
