<template>
  <div>
    <v-text-field
      v-if="template.editable"
      class="form-box__create-field"
      :label="`New ${group} item`"
      v-model="newSkill"
      @keyup.enter.native="addSkill"
      @click:append="addSkill"
      append-icon="keyboard_return"
      box
    ></v-text-field>

    <div class="form-box__items form-box__items--scrollable">
      <v-list>
        <draggable v-model="mutableSkills" :options="draggableOptions">
          <v-list-tile v-for="(skill, index) in mutableSkills" :key="index" class="drag-item">
            <v-list-tile-action >
              <v-icon>{{ groupSets[group].icon }}</v-icon>
            </v-list-tile-action>

            <v-list-tile-content>
              <v-list-tile-title>{{ skill.name }}</v-list-tile-title>
            </v-list-tile-content>

            <v-list-tile-action >
              <div v-if="template.editable">
                <v-btn class="drag-btn" icon flat>
                  <v-icon>drag_indicator</v-icon>
                </v-btn>
                <span class="separator"></span>
                <v-btn icon flat @click="removeSkill(index)">
                  <v-icon>close</v-icon>
                </v-btn>
              </div>
            </v-list-tile-action>
          </v-list-tile>
        </draggable>
      </v-list>
    </div>
  </div>
</template>

<script>
import Draggable from 'vuedraggable'

import { mapGetters } from 'vuex'

export default {
  name: 'GroupForm',
  components: { Draggable },
  props: { skills: Array, group: String, sectionId: [String, Number] },
  data() {
    return {
      newSkill: '',
      draggableOptions: {
        draggable: '.drag-item',
        handle: '.drag-btn',
        animation: 300
      },
      groupSets: {
        'rating': {
          value: 0,
          icon: 'star'
        },
        'bool': {
          value: false,
          icon: 'exposure'
        },
        'text': {
          value: '',
          icon: 'title'
        }
      }
    }
  },
  methods: {

    addSkill() {
      if (this.newSkill.length > 0) {
        this.skills.push({ name: this.newSkill, value: this.groupSets[this.group].value, needToImprove: false })
        this.newSkill = ''
      }
    },

    removeSkill(index) {
      this.skills.splice(index, 1)
    }
  },
  computed: {

    ...mapGetters({
      template: 'TemplatesStore/template'
    }),

    mutableSkills: {
      get() {
        return this.skills
      },

      set(skills) {
        this.$store.commit('SectionsStore/updateSkills', { id: this.sectionId, skills: skills })
      }
    }
  }
}
</script>