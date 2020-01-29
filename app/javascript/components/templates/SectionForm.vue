<template>
  <div class="section-form">
    <h5 class="section-form__header">
      <span>{{ $t('templates.forms.new_section.title') }}</span>
    </h5>

    <v-form @submit.prevent="addSection" class="pa-3">
      <span class="section-form__label">{{ $t('templates.forms.new_section.width.subheader') }}</span>
      <v-radio-group v-model="section.width" row>
        <v-radio :label="$t('templates.forms.new_section.width.half')" value="half"></v-radio>
        <v-radio :label="$t('templates.forms.new_section.width.full')" value="full"></v-radio>
      </v-radio-group>

      <span class="section-form__label">{{ $t('templates.forms.new_section.type.subheader') }}</span>
      <v-radio-group v-model="section.group" row>
        <v-radio :label="$t('templates.forms.new_section.type.rating')" value="rating"></v-radio>
        <v-radio :label="$t('templates.forms.new_section.type.boolean')" value="bool"></v-radio>
        <v-radio :label="$t('templates.forms.new_section.type.text')" value="text"></v-radio>
      </v-radio-group>

      <v-btn
        type="submit"
        color="primary"
        block
        large
        dark
        outline
      >
        <v-icon>add</v-icon>  {{ $t('templates.forms.new_section.button') }}
      </v-btn>
    </v-form>
  </div>
</template>

<script>
import { Section } from '@models/section'

export default {
  name: 'SectionForm',
  props: {
    value: {
      type: Array,
      required: true,
      default: () => []
    }
  },
  data() {
    return {
      section: new Section({
        width: 'half',
        group: 'rating',
        position: this.value.length
      })
    }
  },
  methods: {
    addSection() {
      this.$emit('input', [...this.value, this.section])
    }
  }
}
</script>
