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

  get defaultPreviewFile() {
    return this.firstPdfFile || this.firstImageFile
  }

  get firstImageFile() {
    return this.models.find(mod => mod.content_type.indexOf('image') > -1)
  }

  get firstPdfFile() {
    return this.models.find(mod => mod.content_type.indexOf('pdf') > -1)
  }
}

export { Attachment, AttachmentsList }
