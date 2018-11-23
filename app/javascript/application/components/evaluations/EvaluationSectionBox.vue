<template>
  <v-flex :xs6="section.width === 'half'" :xs12="section.width === 'full'">
    <div class="section-box">
      <h5 class="section-box__heading">
        <span>{{ section.name }}</span>
      </h5>

      <!-- Rating section -->
      <div v-if="isRatingSection()" class="section-box__items">
        <v-list>
          <v-list-tile v-for="(skill, index) in section.skills" :key="index" :class="{ 'need-to-improve': false }">
            <v-list-tile-content>
              <v-list-tile-title v-text="skill.name"></v-list-tile-title>
            </v-list-tile-content>

            <v-list-tile-action>
              <v-rating v-model="skill.value" @input="updateSkills" :readonly="!editable" hover clearable></v-rating>
            </v-list-tile-action>
          </v-list-tile>
        </v-list>
      </div>

      <div v-if="isBoolSection()" class="section-box__items">
        <v-list>
          <v-list-tile v-for="(skill, index) in section.skills" :key="index" :class="{ 'need-to-improve': false }">
            <v-list-tile-content>
              <v-list-tile-title v-text="skill.name"></v-list-tile-title>
            </v-list-tile-content>

            <v-list-tile-action>
              <v-switch
                v-if="editable"
                :label="skill.value ? 'Yes' : 'No'"
                v-model="skill.value"
                @change="updateSkills"
                color="success"
              ></v-switch>
              <span v-else>{{ skill.value ? 'Yes' : 'No' }}</span>
            </v-list-tile-action>
          </v-list-tile>
        </v-list>
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
    }
  }
}
</script>
