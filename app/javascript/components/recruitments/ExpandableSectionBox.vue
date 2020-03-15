<template>
  <v-expansion-panel>
    <v-expansion-panel-header>
      <h5 class="body-2">{{ section.name }}</h5>
    </v-expansion-panel-header>

    <v-expansion-panel-content v-if="section.isRating">
      <div class="section__items">
        <div
          v-for="(skill, index) in section.skills"
          :key="index"
          class="skill"
        >
          <div class="skill__name">{{ skill.name }}</div>

          <div class="skill__action">
            <v-rating
              v-model="skill.value"
              background-color="grey"
              length="3"
              hover
              clearable
            />
          </div>
        </div>
      </div>
    </v-expansion-panel-content>

    <v-expansion-panel-content v-if="section.isBool">
      <div class="section__items">
        <div
          v-for="(skill, index) in section.skills"
          :key="index"
          class="skill"
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
    </v-expansion-panel-content>

    <v-expansion-panel-content v-if="section.isText">
      <div class="section__text">
        <div v-for="(skill, index) in section.skills" :key="index">
          <v-textarea
            :label="skill.name"
            v-model="skill.value"
            :name="`input-${section.id}-${index}`"
            rows="2"
            auto-grow
            outlined
          />
        </div>
      </div>
    </v-expansion-panel-content>
  </v-expansion-panel>
</template>

<script>
import { Section } from '@models/section'

export default {
  name: 'ExpandableSectionBox',
  props: {
    section: {
      type: Section,
      required: true,
      default: () => new Section()
    }
  },
  watch: {
    section: {
      deep: true,
      handler(fresh, _old) {
        this.$store.commit('RecruitDocumentsModule/replaceSection', fresh)
      }
    }
  }
}
</script>
