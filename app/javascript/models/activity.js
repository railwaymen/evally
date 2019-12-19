import { Model, List } from './base'

import moment from 'moment'

class Activity extends Model {
  get defaults() {
    return {
      id: null,
      title: '',
      description: '',
      created_at: ''
    }
  }

  get createdAt() {
    return moment(this.created_at).format('DD/MM/YYYY HH:mm')
  }

  get shortCreatedAtFromNow() {
    let interval

    const diff = moment().diff(moment(this.created_at), 'seconds')

    interval = Math.floor(diff / 31536000)
    if (interval >= 1) return `${interval}y`

    interval = Math.floor(diff / 604800)
    if (interval >= 1) return `${interval}w`

    interval = Math.floor(diff / 86400)
    if (interval >= 1) return `${interval}d`

    interval = Math.floor(diff / 86400)
    if (interval >= 1) return `${interval}d`

    interval = Math.floor(diff / 3600)
    if (interval >= 1) return `${interval}h`

    interval = Math.floor(diff / 60)
    if (interval >= 1) return `${interval}m`

    return `${diff}s`
  }
}

class ActivitiesList extends List {
  get model() {
    return Activity
  }
}

export { Activity, ActivitiesList }
