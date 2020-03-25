<template>
  <v-select
    v-bind="$attrs"
    v-on="$listeners"
    item-disabled="disabled"
  >
    <template #selection="{ item, selected }">
      <v-chip
        :input-value="selected"
        :color="item.color"
        dark
        small
        label
      >
        <strong>{{ item.label }}</strong>
      </v-chip>
    </template>

    <template #item="{ index, item }">
      <div class="dotted-list__item">
        <span class="dotted-list__dot" :style="{ background: item.color }" />
        <span class="dotted-list__label">{{ item.label }}</span>
      </div>
    </template>
  </v-select>
</template>

<script>
export default {
  name: 'StatusSelect'
}
</script>
