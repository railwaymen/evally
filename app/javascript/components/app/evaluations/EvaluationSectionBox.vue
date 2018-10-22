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
              <v-rating :value="skill.value"></v-rating>
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
              <v-switch :label="skill.value ? 'Yes' : 'No'" v-model="skill.value" color="success"></v-switch>
            </v-list-tile-action>
          </v-list-tile>
        </v-list>
      </div>

      <div v-if="isTextSection()" class="section-box__text">
        <div v-for="(skill, index) in section.skills" :key="index">
          <v-textarea
            :label="skill.name"
            :value="skill.value"
            name="input-7-1"
            rows="1"
            @blur="print"
            auto-grow
          ></v-textarea>
        </div>
      </div>
    </div>
  </v-flex>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'EvaluationSectionBox',
  props: ['section'],
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
    
    print() {
      console.log('Hello on blur')
    }
  }
}
</script>
