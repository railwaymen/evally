import { SearchBySkillQuery } from '@models/search_by_skill_query'

const initialState = () => ({
  query: new SearchBySkillQuery(),
  skills: [{ name: 'Abc', group: 'rating' }, { name: 'Git', group: 'bool' }],
  loading: false
})

const RecruitsSearchModule = {
  namespaced: true,

  state: initialState(),

  mutations: {
    SET_LOADING(state, status) {
      state.loading = status
    },
    SET_SKILLS(state, skills) {
      state.skills = skills
    },
    SET_QUERY(state, query) {
      state.query = query
    },
    RESET_STATE(state) {
      Object.assign(state, { ...initialState(), skills: state.skills })
    }
  },

  actions: {
    fetchSkills({ commit }) {
      console.log('Fetch Skills!')
    },
    searchRecruits({ commit }, query) {
      commit('SET_QUERY', query)

      console.log('Search Recruits: ', query)
    }
  }
}

export default RecruitsSearchModule
