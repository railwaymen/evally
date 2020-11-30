<template>
  <v-layout row wrap>
    <slot name="search" :options="options" :searchBy="searchBy" />

    <slot name="filters" :options="options" />

    <v-flex xs12>
      <v-data-table
        v-bind="tableAttrs"
        v-on="$listeners"
        :options.sync="options"
      >
        <template v-for="(_, slot) in tableBodySlots" #[slot]="props">
          <slot :name="slot" v-bind="props" />
        </template>
      </v-data-table>
    </v-flex>
  </v-layout>
</template>

<script>
import BaseComposer from '@utils/data_tables/base_composer'

export default {
  name: 'ServerSideTable',
  inheritAttrs: false,
  props: {
    composerClass: {
      type: Function,
      required: true,
      default: BaseComposer
    }
  },
  data() {
    return {
      options: {},
      timeout: null
    }
  },
  methods: {
    searchBy(val) {
      if (this.timeout) clearTimeout(this.timeout)

      this.timeout = setTimeout(() => this.options.search = val, 500)
    }
  },
  computed: {
    tableAttrs() {
      const { composerClass, ...attrs } = this.$attrs

      return attrs
    },
    tableBodySlots() {
      const { search, filters, ...slots } = this.$scopedSlots

      return slots
    }
  },
  watch: {
    options: {
      deep: true,
      handler(options) {
        this.$router.push({
          path: this.$route.path,
          query: this.composerClass.requestQuery(options)
        })

        this.$emit('change:options', this.composerClass.requestQuery(options))
      }
    }
  },
  created() {
    this.options = this.composerClass.tableOptions(this.$route.query)
  }
}
</script>
