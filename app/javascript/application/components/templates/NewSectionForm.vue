<template>
  <v-flex xs6>
    <div class="new-section">
      <h5 class="new-section__heading">
        <span>New section</span>
      </h5>

      <v-form class="pa-3">
        <span class="new-section__label">Width:</span>
        <v-radio-group v-model="width" row>
          <v-radio label="Half" value="half"></v-radio>
          <v-radio label="Full" value="full"></v-radio>
        </v-radio-group>

        <span class="new-section__label">Type:</span>
        <v-radio-group v-model="group" row>
          <v-radio label="Rating" value="rating"></v-radio>
          <v-radio label="Yes/No" value="bool"></v-radio>
          <v-radio label="Text" value="text"></v-radio>
        </v-radio-group>

        <v-btn color="primary" @click="addSection" block large dark outline>
          <v-icon>add</v-icon>  Add section
        </v-btn>
      </v-form>
    </div>
  </v-flex>
</template>

<script>
import { mapGetters } from 'vuex'

import { Utils } from '@/lib/utils'
import { Section } from '@/models/section'

export default {
  name: 'NewSectionForm',
  data() {
    return {
      width: 'half',
      group: 'rating'
    }
  },
  methods: {
    addSection() {
      let section = new Section({
        width: this.width,
        group: this.group,
        position: this.sections.models.length,
        tempId: Utils.randomId(6)
      })
      this.$store.commit('SectionsStore/push', section)
    }
  },
  computed: {
    ...mapGetters({
      sections: 'SectionsStore/sections'
    })
  }
}
</script>
