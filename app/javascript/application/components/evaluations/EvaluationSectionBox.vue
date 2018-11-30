<template>
  <v-flex xs12 :lg6="section.width === 'half'" :lg12="section.width === 'full'">
    <div class="section-box">
      <h5 class="section-box__heading">
        <span>{{ section.name }}</span>
      </h5>

      <!-- Rating section -->
      <div v-if="isRatingSection()" class="section-box__items">
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
                @input="updateSkills"
                :readonly="!editable"
                length="3"
                hover
                clearable
              ></v-rating>
            </div>
          </div>
        </div>
      </div>

      <div v-if="isBoolSection()" class="section-box__items">
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
                :label="skill.value ? 'Yes' : 'No'"
                v-model="skill.value"
                @change="updateSkills"
                color="success"
                class="mt-1"
              ></v-switch>
              <span v-else>{{ skill.value ? 'Yes' : 'No' }}</span>
            </div>
          </div>
        </div>
      </div>

      <div v-if="isTextSection()" class="section-box__text">
        <div v-for="(skill, index) in section.skills" :key="index">
          <v-textarea
            v-if="editable"
            :label="skill.name"
            v-model="skill.value"
            :name="`input-${section.id}-${index}`"
            @blur="updateSkills"
            rows="1"
            auto-grow
          ></v-textarea>

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
import { mapGetters } from 'vuex'

export default {
  name: 'EvaluationSectionBox',
  props: { section: Object, editable: Boolean },
  methods: {
    isBoolSection() {
      return this.section.group === 'bool'
    },

    isRatingSection() {
      return this.section.group === 'rating'
    },

    isTextSection() {
      return this.section.group === 'text'
    },

    updateSkills() {
      this.$store.commit('EvaluationsStore/updateSkills', { sectionId: this.section.id, skills: this.section.skills })
    },

    needToImprove(skill) {
      if (this.editable) {
        skill.needToImprove = !skill.needToImprove
        this.updateSkills()
      }
    },
  }
}
</script>
