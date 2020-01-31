<template>
  <div class="section-form">
    <h5 class="section-form__header">
      <span>{{ $t('components.templates.sectionForm.title') }}</span>
    </h5>

    <v-form @submit.prevent="addSection" class="pa-3">
      <span class="section-form__label">
        {{ $t('components.templates.sectionForm.width.title') }}
      </span>
      <v-radio-group v-model="section.width" row>
        <v-radio :label="$t('components.templates.sectionForm.width.half')" value="half" />
        <v-radio :label="$t('components.templates.sectionForm.width.full')" value="full" />
      </v-radio-group>

      <span class="section-form__label">{{ $t('components.templates.sectionForm.group.title') }}</span>
      <v-radio-group v-model="section.group" row>
        <v-radio :label="$t('components.templates.sectionForm.group.rating')" value="rating" />
        <v-radio :label="$t('components.templates.sectionForm.group.bool')" value="bool" />
        <v-radio :label="$t('components.templates.sectionForm.group.text')" value="text" />
      </v-radio-group>

      <v-btn
        type="submit"
        color="primary"
        block
        large
        dark
        outline
      >
        <v-icon>add</v-icon>  {{ $t('components.templates.sectionForm.button') }}
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
