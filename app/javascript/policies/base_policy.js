export class BasePolicy {
  constructor(user, object = null) {
    this.user = user
    this.object = object
  }

  get canList() {
    return true
  }

  get canShow(){
    return true
  }

  get canCreate() {
    return true
  }

  get canEdit() {
    return true
  }

  get canUpdate() {
    return true
  }

  get canDestroy() {
    return true
  }
}
