<template>
  <div :class="['comment', `comment--${creator}`]">
    <div class="comment__header">
      <div class="comment__author">{{ comment.created_by }}</div>

      <div v-if="actionsVisible" class="comment__actions">
        <v-tooltip bottom>
          <template #activator="{ on }">
            <v-icon
              v-on="on"
              class="mx-2"
              small
            >
              mdi-pencil
            </v-icon>
          </template>

          <span>{{ $t('shared.tooltips.edit') }}</span>
        </v-tooltip>

        <v-tooltip bottom>
          <template #activator="{ on }">
            <v-icon
              v-on="on"
              class="mx-2"
              small
            >
              mdi-delete
            </v-icon>
          </template>

          <span>{{ $t('shared.tooltips.delete') }}</span>
        </v-tooltip>
      </div>

      <div class="comment__date">
        <v-tooltip bottom>
          <template #activator="{ on }">
            <span v-on="on">{{ comment.createdFromNow }}</span>
          </template>

          <span>{{ comment.createdAt }}</span>
        </v-tooltip>
      </div>
    </div>

    <div class="comment__body" v-html="comment.body" />
  </div>
</template>

<script>
import { Comment } from '@models/comment'
import { User } from '@models/user'

export default {
  name: 'CommentBubble',
  props: {
    comment: {
      type: Comment,
      required: true,
      default: () => new Comment()
    },
    user: {
      type: User,
      required: true,
      default: () => new User()
    }
  },
  data() {
    return {
      actionsVisible: this.comment.editable,
    }
  },
  computed: {
    creator() {
      switch (true) {
        case this.comment.user_id === null:
          return 'bot'
        case this.comment.user_id === this.user.id:
          return 'me'
        default:
          return 'foreign'
      }
    }
  },
  created() {
    if (this.actionsVisible && this.comment.editableTime > 0) {
      setTimeout(() => this.actionsVisible = false, this.comment.editableTime)
    }
  }
}
</script>
