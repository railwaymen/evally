import axios from 'axios'

import { Utils } from '@/lib/utils'
import { ActivitiesList } from '@/models/activity'

const initialState = () => ({
  allActivities: new ActivitiesList(),
  todayActivities: new ActivitiesList(),
  datesRange: { from: null, to: null },
  status: ''
})

const ActivitiesStore = {
  namespaced: true,

  state: initialState(),

  getters: {
    allActivities: state => state.allActivities,
    todayActivities: state => state.todayActivities,
    datesRange: state => state.datesRange,
    status: state => state.status
  },
  mutations: {
    manyAll(state, data) {
      state.allActivities.replace(data)
      state.status = 'ok'
      return state
    },
    manyToday(state, data) {
      state.todayActivities.replace(data)
      state.status = 'ok'
      return state
    },
    progress(state, flag) {
      state.status = flag
      return state
    },
    setDatesRange(state, data) {
      state.datesRange = data
      return state
    },
    resetState(state) {
      state = Object.assign(state, initialState())
      return state
    }
  },
  actions: {
    index(context) {
      return new Promise((resolve, reject) => {
        context.commit('progress', 'loading')

        axios.get('v1/activities', { params: context.state.datesRange })
          .then(response => {
            context.commit('manyAll', response.data)
            resolve()
          })
          .catch(error => {
            reject(error)
          })
      })
    },

    today(context) {
      return new Promise((resolve, reject) => {
        context.commit('progress', 'loading')

        axios.get('v1/activities/today')
          .then(response => {
            context.commit('manyToday', response.data)
            resolve()
          })
          .catch(error => {
            reject(error)
          })
      })
    }
  }
}

export default ActivitiesStore
