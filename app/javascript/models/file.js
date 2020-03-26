import { Model, List } from './base'

class File extends Model {
  get defaults() {
    return {
      id: null,
      content_type: '',
      filename: '',
      kilobyte_size: '',
      path: ''
    }
  }

  get icon() {
    switch(this.content_type) {
      case 'application/pdf':
        return 'mdi-file-pdf-outline'
      case 'application/zip':
        return 'mdi-archive-outline'
      case 'image/gif':
      case 'image/png':
      case 'image/jpeg':
        return 'mdi-file-image-outline'
      default:
        return 'mdi-file-outline'
    }
  }
}

class FilesList extends List {
  get model() {
    return File
  }
}

export { File, FilesList }
