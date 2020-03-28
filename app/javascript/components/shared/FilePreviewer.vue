<template>
  <v-card class="pa-5 height-100">
    <div class="bg-placeholder height-100">
      <object v-if="url" :data="url" width="100%" height="100%">
        <embed :src="url" />
      </object>
    </div>
  </v-card>
</template>

<script>
export default {
  name: 'FilePreviewer',
  props: {
    url: {
      type: String,
      required: true,
      default: ''
    }
  },
}
</script>
