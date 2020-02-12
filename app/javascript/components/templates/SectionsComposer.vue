<template>
  <draggable
    class="layout row wrap"
    :list="value"
    handle=".drag-section-btn"
    draggable=".drag-section"
    animation="300"
    @end="updateOrder"
  >
    <v-flex
      v-for="(section, index) in value"
      v-show="!section._destroy"
      :md12="section.isFull"
      :md6="section.isHalf"
      :key="index"
      class="drag-section"
      xs12
    >
      <div class="section">
        <h5 class="section__header">
          <span v-if="editable">
            <v-text-field
              v-model="section.name"
              :label="$t('components.templates.sectionComposer.title')"
              :rules="[vRequired]"
            />
          </span>

          <span v-else>{{ section.name }}</span>
        </h5>

        <div class="section__actions" v-if="editable">
          <v-tooltip bottom>
            <template #activator="{ on }">
              <v-btn
                @click="resize(section.id, index)"
                v-on="on"
                icon
              >
                <v-icon class="rotateZ90">{{ section.isHalf ? `mdi-unfold-more-vertical` : `mdi-unfold-less-vertical` }}</v-icon>
              </v-btn>
            </template>

            <span>
              {{ section.isHalf ? $t('shared.tooltips.fullWidth') : $t('shared.tooltips.halfWidth') }}
            </span>
          </v-tooltip>

          <v-btn class="drag-section-btn" icon>
            <v-icon>mdi-drag</v-icon>
          </v-btn>

          <v-tooltip bottom>
            <template #activator="{ on }">
              <v-btn
                @click="remove(section.id, index)"
                v-on="on"
                icon
              >
                <v-icon>mdi-delete-outline</v-icon>
              </v-btn>
            </template>

            <span>{{ $t('shared.tooltips.delete') }}</span>
          </v-tooltip>
        </div>

        <section-items-list
          v-model="section.skills"
          :group-data="section.groupData"
          :editable="editable"
        />
      </div>
    </v-flex>
  </draggable>
</template>

<script>
import Draggable from 'vuedraggable'

import SectionItemsList from '@components/templates/SectionItemsList'

export default {
  name: 'SectionsComposer',
  components: { Draggable, SectionItemsList },
  props: {
    value: {
      type: Array,
      required: true,
      default: () => []
    },
    editable: {
      type: Boolean,
      required: true,
      default: false
    }
  },
  methods: {
    resize(sectionId, index) {
      this.$emit('input', this.value.map(section => {
        if (section.id !== sectionId) return section

        section.set('width', section.isHalf ? 'full' : 'half')
        return section
      }))
    },
    remove(sectionId, index) {
      this.$emit('input', this.value.map(section => {
        if (section.id !== sectionId) return section

        section.set('_destroy', 1)
        return section
      }))
    },
    updateOrder() {
      this.$emit('input', this.value.map((section, index) => {
        section.set('position', index)

        return section
      }))
    }
  }
}
</script>
