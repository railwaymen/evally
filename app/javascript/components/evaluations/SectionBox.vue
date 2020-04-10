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
          @dblclick="needToImprove(skill, index)"
        >
          <div class="skill__name">{{ skill.name }}</div>

          <div class="skill__action">
            <v-rating
              v-model="skill.value"
              :readonly="!editable"
              background-color="grey"
              length="3"
              hover
              clearable
            />
          </div>
        </div>
      </div>

      <div v-if="section.isBool" class="section__items">
        <div
          v-for="(skill, index) in section.skills"
          :key="index"
          :class="['skill', { 'need-to-improve': skill.needToImprove }]"
          @dblclick="needToImprove(skill, index)"
        >
          <div class="skill__name">{{ skill.name }}</div>

          <div class="skill__action">
            <v-chip-group v-model="skill.value" color="primary" mandatory>
              <v-chip :value="false" filter-icon="mdi-close" label filter>
                {{ $t('components.evaluations.section.no') }}
              </v-chip>

              <v-chip :value="true" filter-icon="mdi-check" label filter>
                {{ $t('components.evaluations.section.yes') }}
              </v-chip>
            </v-chip-group>
          </div>
        </div>
      </div>

      <div v-if="section.isText" class="section__text">
        <div v-for="(skill, index) in section.skills" :key="index">
          <v-textarea
            v-if="editable"
            :label="skill.name"
            v-model="skill.value"
            :name="`input-${section.id}-${index}`"
            rows="1"
            auto-grow
          />

          <div v-else>
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
  name: 'SectionBox',
  props: {
    section: {
      type: Section,
      required: true,
      default: () => new Section()
    },
    editable: {
      type: Boolean,
      required: true,
      default: true
    }
  },
  methods: {
    needToImprove(skill, idx) {
      const updatedSkill = { ...skill, needToImprove: !skill.needToImprove }

      this.section.skills.splice(idx, 1, updatedSkill)
    }
  },
  watch: {
    section: {
      deep: true,
      handler(fresh, _old) {
        this.$store.commit('EvaluationEmployablesModule/refreshSection', fresh)
      }
    }
  }
}
</script>
