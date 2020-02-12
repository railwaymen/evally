<template>
  <div>
    <v-text-field
      v-if="editable"
      class="form-box__create-field"
      :label="$t(`components.templates.sectionItemsList.label.${groupData.name}`)"
      v-model="skillName"
      @keyup.enter.native="addSkill"
      @click:append="addSkill"
      append-icon="keyboard_return"
      box
    />

    <div class="form-box__items form-box__items--scrollable">
      <div class="skills">
        <draggable
          :list="value"
          draggable='.drag-item'
          handle='.drag-item-btn'
          animation="300"
          @end="updateOrder"
        >
          <div v-for="(skill, index) in value" :key="index" class="skill drag-item">
            <div class="skill__action">
              <v-icon style="padding: 6px;">{{ groupData.icon }}</v-icon>
            </div>

            <div class="skill__name">{{ skill.name }}</div>

            <div class="skill__action">
              <div v-if="editable">
                <v-btn class="drag-item-btn ma-0" icon>
                  <v-icon>drag_indicator</v-icon>
                </v-btn>

                <v-btn @click="removeSkill(index)" class="ma-0" icon>
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

export default {
  name: 'SectionItemsList',
  components: { Draggable },
  props: {
    value: {
      type: Array,
      required: true,
      default: () => []
    },
    groupData: {
      type: Object,
      required: true,
      default: () => ({ name: null, defaultValue: null, icon: null })
    },
    editable: {
      type: Boolean,
      required: true,
      default: false
    }
  },
  data() {
    return {
      skillName: ''
    }
  },
  methods: {
    addSkill() {
      const newSkill = {
        name: this.skillName,
        value: this.groupData.defaultValue,
        needToImprove: false
      }

      this.$emit('input', [...this.value, newSkill])
      this.skillName = ''
    },
    removeSkill(index) {
      this.$emit('input', this.value.filter((_el, i) => i !== index))
    },
    updateOrder() {
      this.$emit('input', this.value)
    }
  }
}
</script>
