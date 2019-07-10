<template>
  <div>
    <v-text-field
      v-if="template.editable"
      class="form-box__create-field"
      :label="$t(`templates.forms.inputs.${section.group}`)"
      v-model="newSkill"
      @keyup.enter.native="addSkill"
      @click:append="addSkill"
      append-icon="keyboard_return"
      box
    ></v-text-field>

    <div class="form-box__items form-box__items--scrollable">
      <div class="skills">
        <draggable
          v-model="section.skills"
          draggable='.drag-item'
          handle='.drag-item-btn'
          animation="300"
        >
          <div v-for="(skill, index) in section.skills" :key="index" class="skill drag-item">
            <div class="skill__action">
              <v-icon style="padding: 6px;">{{ groupSets[section.group].icon }}</v-icon>
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
  props: { section: Object },
  data() {
    return {
      newSkill: '',
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
        this.section.skills.push({ name: this.newSkill, value: this.groupSets[this.section.group].value, needToImprove: false })
        this.newSkill = ''
      }
    },

    removeSkill(index) {
      this.section.skills.splice(index, 1)
    }
  },
  computed: {
    ...mapGetters({
      template: 'TemplatesStore/template'
    })
  }
}
</script>