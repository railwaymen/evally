import { Model, List } from './base'

class Attachment extends Model {
  get defaults() {
    return {
      id: null,
      content_type: '',
      name: '',
      size: '',
      url: ''
    }
  }
}

class AttachmentsList extends List {
  get model() {
    return Attachment
  }
}

export { Attachment, AttachmentsList }
