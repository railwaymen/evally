<template>
  <v-layout row wrap>
    <v-flex
      v-for="(link, index) in value"
      :key="index"
      xs12
      lg6
    >
      <v-text-field
        :key="index"
        :value="link"
        :label="`Link #${index + 1}`"
        :prepend-inner-icon="icons[index]"
        append-icon="mdi-close"
        @blur="changeLink($event.target.value, index)"
        @click:append="removeLink(index)"
      />
    </v-flex>

    <v-flex xs12 lg6>
      <v-btn
        @click="$emit('input', [...value, ''])"
        color="primary"
        class="mt-2"
        outlined
        block
      >
        New Link
      </v-btn>
    </v-flex>
  </v-layout>
</template>

<script>
import { linksToIcons } from '@utils/helpers'

export default {
  name: 'SocialLinkField',
  props: {
    value: Array,
    required: true,
    default: () => []
  },
  methods: {
    changeLink(link, index) {
      this.$emit('input', this.value.map((el, idx) => idx === index ? link : el))
    },
    removeLink(index) {
      this.$emit('input', this.value.filter((_el, idx) => idx !== index))
    }
  },
  computed: {
    icons() {
      return linksToIcons(this.value)
    }
  }
}
</script>
