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
              <vue-editor
                v-model="localComment.body"
                :editor-toolbar="toolbar"
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

    <div class="sidebar__section">
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
import { mapActions, mapState } from 'vuex'
import { VueEditor } from 'vue2-editor';

import { Comment, CommentsList } from '@models/comment'

import CommentBubble from '@components/recruitments/CommentBubble'

export default {
  name: 'CommentsSidebar',
  components: { CommentBubble, VueEditor },
  data() {
    return {
      panel: null,
      localComment: new Comment(),
      toolbar: [
        [
          { 'header': [false, 1, 2, 3, 4, 5, 6] }
        ],
        [
          'bold',
          'italic',
          'underline',
          'strike'
        ],
        [
          'blockquote',
          'code-block'
        ],
        [
          { 'list': 'ordered'},
          { 'list': 'bullet' }
        ],
        [
          { 'color': [] },
        ]
      ]
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
    ...mapState('RecruitDocumentsModule', [
      'comments'
    ]),
    ...mapState('AuthenticationModule', [
      'user'
    ])
  }
}
</script>
