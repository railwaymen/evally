<template>
  <v-flex xs12 :lg6="section.isHalf" :lg12="section.isFull">
    <div class="section">
      <h5 class="section__header">
        <span>{{ section.name }}</span>
      </h5>

      <div v-if="section.isRating" class="section__items">
        <div
          v-for="(skill, index) in section.skills"
          :key="index"
          :class="['skill', { 'need-to-improve': skill.needToImprove }]"
        >
          <div class="skill__name">{{ skill.name }}</div>

          <div class="skill__action">
            <v-rating
              v-model="skill.value"
              length="3"
              hover
              clearable
              readonly
            />
          </div>
        </div>
      </div>

      <div v-if="section.isBool" class="section__items">
        <div
          v-for="(skill, index) in section.skills"
          :key="index"
          :class="['skill', { 'need-to-improve': skill.needToImprove }]"
        >
          <div class="skill__name">{{ skill.name }}</div>

          <div class="skill__action">
            <span >{{ skill.value ? $t('evaluations.forms.bool_yes') : $t('evaluations.forms.bool_no') }}</span>
          </div>
        </div>
      </div>

      <div v-if="section.isText" class="section__text">
        <div v-for="(skill, index) in section.skills" :key="index">
          <div>
            <h4>{{ skill.name }}</h4>
            <p> {{ skill.value }}</p>
          </div>
        </div>
      </div>
    </div>
  </v-flex>
</template>

<script>
import { Section } from '@models/section'

export default {
  name: 'StaticSectionBox',
  props: {
    section: {
      type: Section,
      required: true,
      default: () => new Section()
    }
  }
}
</script>
