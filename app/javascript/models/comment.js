import { Model, List } from './base'

import moment from 'moment'

class Comment extends Model {
  get defaults() {
    return {
      id: null,
      body: '',
      user_id: null,
      created_by: '',
      created_at: null,
      editable: true
    }
  }

  get editableTime() {
    const diff = this.created_at ? moment().diff(this.created_at) : 0

    return Math.max(900000 - diff, 0)
  }

  get createdAt() {
    if (!this.created_at) return '---'

    return moment(this.created_at).format('DD MMM YYYY, HH:mm')
  }

  get createdFromNow() {
    if (!this.created_at) return '---'

    return moment(this.created_at).fromNow()
  }

  static get routes() {
    return {
      commentsPath: publicRecruitId => `/v2/recruits/${publicRecruitId}/comments`,
      commentPath: (publicRecruitId, id) => `/v2/recruits/${publicRecruitId}/comments/${id}`
    }
  }
}

class CommentsList extends List {
  get model() {
    return Comment
  }
}

export { Comment, CommentsList }
