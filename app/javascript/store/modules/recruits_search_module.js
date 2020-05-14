import { coreApiClient } from '@utils/api_clients'

import { Recruit } from '@models/recruit'
import { SearchBySkillQuery } from '@models/search_by_skill_query'

const initialState = () => ({
  query: new SearchBySkillQuery(),
  skills: [],
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
      coreApiClient
        .get(Recruit.routes.recruitsSkillsPath)
        .then(response => {
          commit('SET_SKILLS', response.data)
        })
        .catch(() => {
          commit(
            'MessagesModule/PUSH_MESSAGE',
            { error: 'Error :(' },
            { root: true }
          )
        })
    },
    searchRecruits({ commit }, query) {
      commit('SET_LOADING', true)

      coreApiClient
        .get(Recruit.routes.recruitsSearchPath, { params: query })
        .then(response => {
          commit('SET_QUERY', query)
          // commit('SET_EMPLOYEES', response.data)
          console.log(response.data)
        })
        .catch(() => {
          commit(
            'MessagesModule/PUSH_MESSAGE',
            { error: 'Error :(' },
            { root: true }
          )
        })
        .finally(() => commit('SET_LOADING', false))
    }
  }
}

export default RecruitsSearchModule
