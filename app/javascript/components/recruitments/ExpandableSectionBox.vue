<template>
  <v-expansion-panel>
    <v-expansion-panel-header>
      <h5 class="body-2">
        <v-icon
          :color="section.sensitive ? 'red' : 'green'"
          class="mr-1"
        >
          {{ section.sensitive ? `mdi-lock-outline` : `mdi-lock-open-variant-outline`  }}
        </v-icon>
        {{ section.name }}
      </h5>
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
              :value="skill.value"
              @input="changeValue($event, skill, index)"
              :readonly="!editable"
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
            <v-chip
              v-if="!editable"
              :color="skill.value ? 'primary' : ''"
              label
            >
              {{ skill.value ? $t('components.evaluations.staticSection.yes') : $t('components.evaluations.staticSection.no') }}
            </v-chip>

            <v-chip-group
              v-else
              :value="skill.value"
              @change="changeValue($event, skill, index)"
              color="primary"
              mandatory
            >
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
          <div v-if="!editable">
            <h4>{{ skill.name }}</h4>
            <p> {{ skill.value }}</p>
          </div>

          <v-textarea
            v-else
            :label="skill.name"
            :value="skill.value"
            @input="changeValue($event, skill, index)"
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
    },
    editable: {
      type: Boolean,
      required: true,
      default: true
    }
  },
  methods: {
    changeValue(value, skill, idx) {
      const updatedSkill = { ...skill, value }

      this.section.skills.splice(idx, 1, updatedSkill)
      this.$store.commit('RecruitDocumentsModule/refreshSection', this.section)
    }
  }
}
</script>
