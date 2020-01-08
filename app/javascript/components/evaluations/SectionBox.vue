<template>
  <v-flex xs12 :lg6="section.isHalf" :lg12="section.isFull">
    <div class="section-box">
      <h5 class="section-box__heading">
        <span>{{ section.name }}</span>
      </h5>

      <div v-if="section.isRating" class="section-box__items">
        <div class="skills">
          <div
            v-for="(skill, index) in section.skills"
            :key="index"
            :class="['skill', { 'need-to-improve': skill.needToImprove }]"
            @dblclick="needToImprove(skill)"
          >
            <div class="skill__name">{{ skill.name }}</div>

            <div class="skill__action">
              <v-rating
                v-model="skill.value"
                :readonly="!editable"
                length="3"
                hover
                clearable
              />
            </div>
          </div>
        </div>
      </div>

      <div v-if="section.isBool" class="section-box__items">
        <div class="skills">
          <div
            v-for="(skill, index) in section.skills"
            :key="index"
            :class="['skill', { 'need-to-improve': skill.needToImprove }]"
            @dblclick="needToImprove(skill)"
          >
            <div class="skill__name">{{ skill.name }}</div>

            <div class="skill__action">
              <v-switch
                v-if="editable"
                :label="skill.value ? $t('evaluations.forms.bool_yes') : $t('evaluations.forms.bool_no')"
                v-model="skill.value"
                color="success"
                class="mt-1"
              />

              <span v-else>{{ skill.value ? $t('evaluations.forms.bool_yes') : $t('evaluations.forms.bool_no') }}</span>
            </div>
          </div>
        </div>
      </div>

      <div v-if="section.isText" class="section-box__text">
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
    needToImprove(skill) {
      skill.needToImprove = !skill.needToImprove
    }
  },
  watch: {
    section: {
      deep: true,
      handler(fresh, _old) {
        this.$store.commit('DraftsModule/replace', fresh)
      }
    }
  }
}
</script>
