import { Model } from './base'

import moment from 'moment'

class Autosave extends Model {
  get defaults() {
    return {
      id: null,
      mDatetime: null,
      touched: false,
      error: false
    }
  }

  get enabled() {
    return this.id && this.mDatetime
  }

  get success() {
    return this.enabled && this.touched && !this.error
  }

  get failed() {
    return this.enabled && this.touched && this.error
  }

  get performedAt() {
    return this.touched ? moment(this.mDatetime).format('HH:mm:ss, DD MMM YYYY') : null
  }

  enable(fn) {
    this.id = setInterval(fn, 3 * 60 * 1000)
  }

  disable() {
    clearInterval(this.id)

    Object.assign(this, {
      id: null,
      mDatetime: null,
      touched: false
    })
  }

  touch() {
    Object.assign(this, {
      mDatetime: moment(),
      touched: true,
      error: false
    })
  }

  fail() {
    Object.assign(this, {
      mDatetime: moment(),
      touched: true,
      error: true
    })
  }
}

export { Autosave }
