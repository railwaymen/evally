<template>
  <div class="section-form">
    <h5 class="section-form__header">
      <span>{{ $t('components.templates.sectionForm.title') }}</span>
    </h5>

    <v-form @submit.prevent="addSection" class="pa-3">
      <v-layout row wrap>
        <v-flex xs6>
          <span class="section-form__label">
            {{ $t('components.templates.sectionForm.width.title') }}
          </span>
          <v-radio-group v-model="section.width" row>
            <v-radio
              :label="$t('components.templates.sectionForm.width.full')"
              value="full"
            />

            <v-radio
              :label="$t('components.templates.sectionForm.width.half')"
              :disabled="recruitable"
              value="half"
            />
          </v-radio-group>
        </v-flex>

        <v-flex xs6>
          <span class="section-form__label">
            {{ $t('components.templates.sectionForm.sensitive.title') }}
          </span>
          <v-checkbox
            v-model="section.sensitive"
            :label="section.sensitive ? $t('components.templates.sectionForm.sensitive.yes') : $t('components.templates.sectionForm.sensitive.no')"
            :disabled="!recruitable"
          />
        </v-flex>

        <v-flex xs12>
          <span class="section-form__label">{{ $t('components.templates.sectionForm.group.title') }}</span>
          <v-radio-group v-model="section.group" row>
            <v-radio :label="$t('components.templates.sectionForm.group.rating')" value="rating" />
            <v-radio :label="$t('components.templates.sectionForm.group.bool')" value="bool" />
            <v-radio :label="$t('components.templates.sectionForm.group.text')" value="text" />
          </v-radio-group>
        </v-flex>
      </v-layout>

      <v-btn
        type="submit"
        color="primary"
        block
        large
        outlined
      >
        <v-icon>mdi-plus</v-icon>  {{ $t('components.templates.sectionForm.button') }}
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
    },
    recruitable: {
      type: Boolean,
      required: true,
      default: false
    }
  },
  data() {
    return {
      section: new Section({
        width: 'full',
        group: 'rating',
        position: this.value.length,
        sensitive: false
      })
    }
  },
  methods: {
    addSection() {
      this.$emit('input', [...this.value, this.section])

      this.section = new Section({
        width: 'full',
        group: 'rating',
        position: this.value.length + 1,
        sensitive: false
      })
    }
  }
}
</script>
