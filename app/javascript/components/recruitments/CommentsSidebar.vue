<template>
  <div class="sidebar sidebar--boxed">
    <div class="sidebar__section">
      <v-expansion-panels v-model="panel">
        <v-expansion-panel>
          <v-expansion-panel-header disable-icon-rotate>
            Add Comment

            <template #actions>
              <v-icon color="green">mdi-plus</v-icon>
            </template>
          </v-expansion-panel-header>

          <v-expansion-panel-content>
            <v-form @submit.prevent="save">
              <comment-editor
                v-model="localComment.body"
                :commentators="commentators"
              />

              <div class="pt-2 text-right">
                <v-btn
                  @click="cancel"
                  color="grey darken-1"
                  text
                >
                  {{ $t('shared.buttons.cancel') }}
                </v-btn>

                <v-btn
                  :disabled="!localComment.body"
                  type="submit"
                  color="green darken-1"
                  text
                >
                  {{ $t('shared.buttons.save') }}
                </v-btn>
              </div>
            </v-form>
          </v-expansion-panel-content>
        </v-expansion-panel>
      </v-expansion-panels>
    </div>

    <div v-if="loading" class="sidebar__loader">
      <v-progress-circular :size="30" :width="3" color="primary" indeterminate />
    </div>

    <div v-else class="sidebar__section">
      <div class="py-3 comments-list">

        <comment-bubble
          v-for="comment in comments.models"
          :key="comment.id"
          :comment="comment"
          :user="user"
          @edit="setComment"
        />
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex'

import { Comment, CommentsList } from '@models/comment'
import { RecruitDocument } from '@models/recruit_document'
import { User, UsersList } from '@models/user'

import CommentBubble from '@components/recruitments/CommentBubble'
import CommentEditor from '@components/recruitments/CommentEditor'

export default {
  name: 'CommentsSidebar',
  components: { CommentBubble, CommentEditor },
  props: {
    comments: {
      type: CommentsList,
      required: true,
      default: () => new CommentsList()
    },
    user: {
      type: User,
      required: true,
      default: () => new User()
    },
    users: {
      type: UsersList,
      required: false,
      default: () => new UsersList()
    },
    recruitDocument: {
      type: RecruitDocument,
      required: true,
      default: () => new RecruitDocument()
    },
    loading: {
      type: Boolean,
      required: true,
      default: true
    }
  },
  data() {
    return {
      panel: null,
      localComment: new Comment()
    }
  },
  methods: {
    ...mapActions('RecruitDocumentsModule', [
      'createComment',
      'updateComment'
    ]),
    save() {
      if (!this.localComment.body) return

      (this.localComment.isPersisted ? this.updateComment : this.createComment)(this.localComment)
        .then(this.cancel)
    },
    cancel() {
      this.localComment = new Comment()
      this.panel = null
    },
    setComment(comment) {
      this.localComment = new Comment({ ...comment })
      this.panel = 0
    }
  },
  computed: {
    commentators() {
      return this.users.models.filter(user => (
        user.isAdmin || user.isRecruiter || user.email_token === this.recruitDocument.evaluator_token
      ))
    }
  }
}
</script>
