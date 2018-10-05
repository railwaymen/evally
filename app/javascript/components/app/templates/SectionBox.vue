<template>
  <v-flex :xs6="section.width === 'half'" :xs12="section.width === 'full'">
    <div class="form-box">
      <h5 class="form-box__heading">
        <span class="form-box__heading-content">
          <v-text-field
            v-if="template.editable"
            :value="section.name"
            label="Section title"
            outline
          ></v-text-field>

          <span v-else>{{ section.name }}</span>
        </span>
      </h5>

      <group-form :skills="section.skills" :group="section.group"></group-form>

    </div>
  </v-flex>
</template>

<script>
import { mapGetters } from 'vuex'

import GroupForm from './GroupForm'

export default {
  name: 'SectionBox',
  components: { GroupForm },
  props: ['section'],
  computed: {
    ...mapGetters({
      template: 'TemplatesStore/template'
    })
  }
}
</script>