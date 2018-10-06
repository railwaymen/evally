import axios from 'axios'

import { Utils } from '../../lib/utils'
import { Section, SectionsList } from '../../models/section'

const SectionsStore = {
  namespaced: true,
  state: {
    sections: new SectionsList()
  },
  getters: {
    sections: state => state.sections
  },
  mutations: {
    clear(state) {
      state.sections = new SectionsList()
      return state
    },
    many(state, data) {
      state.sections.replace(data)
      return state
    },
    push(state, data) {
      state.sections.add(data)
      return state
    },
  },
  actions: {

  }
}

export default SectionsStore
