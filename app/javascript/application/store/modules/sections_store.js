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
    markAsRemoved(state, id) {
      if (isNaN(id)) {
        state.sections.remove({ tempId: id })
      } else {
        state.sections.map(section => {
          if (section.id === id) section._destroy = 1
          return section
        })
      }
      return state
    },
    resize(state, data) {
      let section = state.sections.find(isNaN(data.id) ? { tempId: data.id } : { id: data.id })
      if (section) section.width = data.width
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
