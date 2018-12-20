<template>
  <div>
    <v-text-field
      v-if="template.editable"
      class="form-box__create-field"
      :label="$t(`templates.forms.inputs.${group}`)"
      v-model="newSkill"
      @keyup.enter.native="addSkill"
      @click:append="addSkill"
      append-icon="keyboard_return"
      box
    ></v-text-field>

    <div class="form-box__items form-box__items--scrollable">
      <div class="skills">
        <draggable v-model="mutableSkills" :options="draggableOptions">
          <div v-for="(skill, index) in mutableSkills" :key="index" class="skill drag-item">
            <div class="skill__action">
              <v-icon style="padding: 6px;">{{ groupSets[group].icon }}</v-icon>
            </div>

            <div class="skill__name">{{ skill.name }}</div>

            <div class="skill__action">
              <div v-if="template.editable">
                <v-btn class="drag-item-btn ma-0" icon flat>
                  <v-icon>drag_indicator</v-icon>
                </v-btn>
                <v-btn class="ma-0" icon flat @click="removeSkill(index)">
                  <v-icon>close</v-icon>
                </v-btn>
              </div>
            </div>
          </div>
        </draggable>
      </div>
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
        handle: '.drag-item-btn',
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