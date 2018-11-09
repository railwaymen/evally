import axios from 'axios'

import { Utils } from '../../lib/utils'
import { ActivitiesList } from '../../models/activity'

const ActivitiesStore = {
  namespaced: true,
  state: {
    activities: new ActivitiesList(),
    currentDate: null,
    status: ''

  },
  getters: {
    activities: state => state.activities,
    currentDate: state => state.currentDate,
    status: state => state.status
  },
  mutations: {
    setCurrentDate(state, date) {
      state.currentDate = date
      return state
    },
    many(state, data) {
      state.activities.replace(data)
      state.status = 'ok'
      return state
    },
    progress(state, flag) {
      state.status = flag
      return state
    }
  },
  actions: {
    index(context, date) {
      context.commit('setCurrentDate', date)
      
      return new Promise((resolve, reject) => {
        context.commit('progress', 'loading')

        axios.get(context.state.activities.getFetchURL(), { params: { date: date.format('DD-MM-YYYY') } })
          .then(response => {
            let data = Utils.modelsFromResponse(response.data.data)
            context.commit('many', data)
          })
          .catch(error => {
            reject(error)
          })
      })
    }
  }
}

export default ActivitiesStore
