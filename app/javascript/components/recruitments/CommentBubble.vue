<template>
  <div
    :id="`comment-${comment.id}`"
    :class="['comment', `comment--${creator}`]"
  >
    <div class="comment__header">
      <div class="comment__author">{{ comment.title }}</div>

      <div v-if="actionsVisible && comment.editable" class="comment__actions">
        <v-tooltip bottom>
          <template #activator="{ on }">
            <v-icon
              @click="$emit('edit', comment)"
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
              @click="openDeleteCommentConfirm(comment)"
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
import { DialogsBus } from '@utils/dialogs_bus'

import { Comment } from '@models/comment'
import { User } from '@models/user'

import DeleteCommentConfirm from '@components/recruitments/DeleteCommentConfirm'

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
  methods: {
    openDeleteCommentConfirm(comment) {
      DialogsBus.$emit('openFormsDialog', {
        innerComponent: DeleteCommentConfirm,
        props: { comment }
      })
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
