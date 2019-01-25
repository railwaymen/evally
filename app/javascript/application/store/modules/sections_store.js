import { SectionsList } from '@/models/section'

const initialState = () => ({
  sections: new SectionsList()
})

const SectionsStore = {
  namespaced: true,

  state: initialState(),

  getters: {
    sections: state => state.sections
  },
  mutations: {
    clear(state) {
      state.sections.clear()
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
    updateSkills(state, data) {
      let section = state.sections.find(isNaN(data.id) ? { tempId: data.id } : { id: data.id })
      if (section) section.skills = data.skills
      return state
    },
    resetState(state) {
      state = Object.assign(state, initialState())
      return state
    }
  }
}

export default SectionsStore
