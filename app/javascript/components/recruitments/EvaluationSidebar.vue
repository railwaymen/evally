<template>
  <div class="sidebar sidebar--boxed">
    <div class="sidebar__section">
      <v-select
        v-model="evaluationId"
        :items="evaluations"
        label="Evaluation"
        item-value="value"
        item-text="text"
        outlined
      />
    </div>

    <v-form ref="form" @submit.prevent="submit">
      <div class="sidebar__section">
        <v-expansion-panels v-model="panel" multiple accordion>
          <v-expansion-panel
            v-for="section in sections.models"
            :key="section.id"
          >
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
                        {{ $t('components.drafts.section.no') }}
                      </v-chip>

                      <v-chip :value="true" filter-icon="mdi-check" label filter>
                        {{ $t('components.drafts.section.yes') }}
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
                    rows="1"
                    auto-grow
                  />
                </div>
              </div>
            </v-expansion-panel-content>
          </v-expansion-panel>
        </v-expansion-panels>

        <div class="sidebar__actions text-right">
          <v-btn
            color="grey darken-1"
            text
          >
            {{ $t('shared.buttons.reset') }}
          </v-btn>

          <v-btn
            type="submit"
            color="green darken-1"
            text
          >
            {{ $t('shared.buttons.save') }}
          </v-btn>
        </div>
      </div>
    </v-form>
  </div>
</template>

<script>
import { SectionsList } from '@models/section'

export default {
  name: 'EvaluationSidebar',
  data() {
    return {
      panel: [0, 1, 2],
      evaluationId: null,
      evaluations: [
        { value: 1, text: 'RoR Dev - Mar 24, 2020' },
        { value: 2, text: 'Junior RoR Dev - Oct 12, 2019' }
      ],
      sections: new SectionsList([
        {
          id: 91,
          name: "Tech",
          group: "rating",
          width: "full",
          position: 0,
          skills: [
            { name: "PHP", value: 0, needToImprove: false },
            { name: "Python", value: 0, needToImprove: false },
            { name: "Java", value: 0, needToImprove: false },
            { name: "Go", value: 0, needToImprove: false}
          ]
        },
        {
          id: 92,
          name: "Soft",
          group: "bool",
          width: "full",
          position: 0,
          skills: [
            { name: "Work with clients", value: false, needToImprove: false },
            { name: "Work under pressure", value: false, needToImprove: false },
            { name: "Team mentoring", value: false, needToImprove: false}
          ]
        },
        {
          id: 93,
          name: "Other",
          group: "text",
          width: "full",
          position: 1,
          skills: [
            { name: "Prefered contract type", value: "", needToImprove: false },
            { name: "Expected salary", value: "", needToImprove: false }
          ],
        }
      ])
    }
  },
  methods: {
    submit() {
      console.log('Submitted!')
    }
  }
}
</script>
