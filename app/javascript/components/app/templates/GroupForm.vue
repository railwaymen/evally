<template>
  <div>
    <v-text-field
      v-if="template.editable"
      class="form-box__create-field"
      :label="`New ${group} item`"
      v-model="newSkill"
      @keyup.enter.native="addSkill"
      box
    ></v-text-field>

    <div class="form-box__items form-box__items--scrollable">
      <v-list>
        <v-list-tile v-for="(skill, index) in skills" :key="index">
          <v-list-tile-content>
            <v-list-tile-title>{{ skill.name }}</v-list-tile-title>
          </v-list-tile-content>

          <v-list-tile-action v-if="template.editable">
            <v-btn icon flat @click="removeSkill(index)">
              <v-icon>close</v-icon>
            </v-btn>
          </v-list-tile-action>
        </v-list-tile>
      </v-list>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'GroupForm',
  props: { skills: Array, group: String},
  data() {
    return {
      newSkill: ''
    }
  },
  methods: {
    addSkill() {
      this.skills.push({ name: this.newSkill })
      this.newSkill = ''
    },
    removeSkill(index) {
      this.skills.splice(index, 1)
    }
  },
  computed: {
    ...mapGetters({
      template: 'TemplatesStore/template'
    })
  }
}
</script>