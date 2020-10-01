export default class PlaceholdersCounter {
  constructor() {
    this.quillContainer = document.getElementById('quill-container')
  }

  call() {
    return {
      total: this.allPlaceholders.length,
      completed: this.completedPlaceholders.length
    }
  }

  get allPlaceholders() {
    return this.quillContainer.querySelectorAll('.ql-placeholder-tag')
  }

  get completedPlaceholders() {
    return this.quillContainer.querySelectorAll('.ql-placeholder-tag[data-autocompleted=true]')
  }
}
