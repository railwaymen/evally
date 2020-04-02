<template>
  <v-card class="height-100">
    <div class="file-previewer">
      <object :data="attachment.url" :key="attachment.size">
        <embed :src="attachment.url" />
      </object>
    </div>
  </v-card>
</template>

<script>
import { Attachment } from '@models/attachment'

export default {
  name: 'FilePreviewer',
  props: {
    attachment: {
      type: Attachment,
      required: true,
      default: () => new Attachment()
    }
  }
}
</script>
