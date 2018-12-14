<template>
  <v-flex xs12 lg6>
    <div class="new-section">
      <h5 class="new-section__heading">
        <span>{{ $t('templates.forms.new_section.title') }}</span>
      </h5>

      <v-form class="pa-3">
        <span class="new-section__label">{{ $t('templates.forms.new_section.width.subheader') }}</span>
        <v-radio-group v-model="width" row>
          <v-radio :label="$t('templates.forms.new_section.width.half')" value="half"></v-radio>
          <v-radio :label="$t('templates.forms.new_section.width.full')" value="full"></v-radio>
        </v-radio-group>

        <span class="new-section__label">{{ $t('templates.forms.new_section.type.subheader') }}</span>
        <v-radio-group v-model="group" row>
          <v-radio :label="$t('templates.forms.new_section.type.rating')" value="rating"></v-radio>
          <v-radio :label="$t('templates.forms.new_section.type.boolean')" value="bool"></v-radio>
          <v-radio :label="$t('templates.forms.new_section.type.text')" value="text"></v-radio>
        </v-radio-group>

        <v-btn color="primary" @click="addSection" block large dark outline>
          <v-icon>add</v-icon>  {{ $t('templates.forms.new_section.button') }}
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
