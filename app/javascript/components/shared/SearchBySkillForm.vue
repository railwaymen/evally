<template>
  <v-form ref="form" @submit.prevent="submit" class="search-form">
    <div class="search-form__skill">
      <v-select
        :value="localQuery.name"
        @change="setSkill"
        :items="skills"
        item-text="name"
        item-value="name"
        :rules="[vRequired]"
        :label="$t('components.shared.searchBySkillForm.label')"
        return-object
        chips
      >
        <template #selection="{ item }">
          <v-chip>
            <v-icon size="14" class="mr-2">
              {{ item.group === 'rating' ? 'mdi-star' : 'mdi-plus-minus' }}
            </v-icon>

            <span class="body-2">{{ item.name }}</span>
          </v-chip>
        </template>

        <template #item="{ item }">
          <v-icon size="14" class="mr-2">
            {{ item.group === 'rating' ? 'mdi-star' : 'mdi-plus-minus' }}
          </v-icon>

          <span class="body-2">{{ item.name }}</span>
        </template>
      </v-select>
    </div>

    <template v-if="localQuery.ratingGroup">
      <div class="search-form__buttons">
        <v-btn-toggle
          v-model="localQuery.operator"
          color="primary"
          group
        >
          <v-btn value="lteq" text>
            <v-icon size="14">mdi-less-than-or-equal</v-icon>
          </v-btn>

          <v-btn value="eq" text>
            <v-icon size="14">mdi-equal</v-icon>
          </v-btn>

          <v-btn value="gteq" text>
            <v-icon size="14">mdi-greater-than-or-equal</v-icon>
          </v-btn>
        </v-btn-toggle>
      </div>

      <div class="search-form__value">
        <v-rating
          v-model="localQuery.value"
          background-color="grey"
          length="3"
          hover
          clearable
        />
      </div>
    </template>

    <div v-if="localQuery.boolGroup" class="search-form__buttons">
      <v-btn-toggle
        v-model="localQuery.value"
        color="primary"
        group
      >
        <v-btn
          :value="false"
          text
        >
          {{ $t('shared.buttons.no') }}
        </v-btn>

        <v-btn
          :value="true"
          text
        >
          {{ $t('shared.buttons.yes') }}
        </v-btn>
      </v-btn-toggle>
    </div>

    <div class="search-form__action">
      <v-btn
        @click="reset"
        color="grey darken-1"
        type="reset"
        text
      >
        {{ $t('shared.buttons.reset') }}
      </v-btn>
      <v-btn
        color="primary"
        type="submit"
        text
      >
        {{ $t('shared.buttons.search') }}
      </v-btn>
    </div>
  </v-form>
</template>

<script>
import { SearchBySkillQuery } from '@models/search_by_skill_query'

export default {
  name: 'SearchBySkillForm',
  props: {
    skills: {
      type: Array,
      required: true,
      default: () => []
    },
    query: {
      type: SearchBySkillQuery,
      required: true,
      default: () => new SearchBySkillQuery()
    }
  },
  data() {
    return {
      localQuery: new SearchBySkillQuery({ ...this.query })
    }
  },
  methods: {
    reset() {
      this.localQuery = new SearchBySkillQuery()
      this.$refs.form.reset()

      this.$emit('reset', this.localQuery)
    },
    setSkill(item) {
      const isBoolItem = item.group === 'bool'

      this.localQuery = new SearchBySkillQuery({
        name: item.name,
        group: item.group,
        value: isBoolItem ? true : 0,
        operator: isBoolItem ? 'eg' : this.localQuery.operator
      })
    },
    submit() {
      if (this.$refs.form.validate()) this.$emit('submit', this.localQuery)
    }
  }
}
</script>
