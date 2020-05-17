import { coreApiClient, recruitableApiClient } from '@utils/api_clients'

import { Recruit, RecruitsList } from '@models/recruit'
import { RecruitDocument } from '@models/recruit_document'
import { SearchBySkillQuery } from '@models/search_by_skill_query'

const initialState = () => ({
  query: new SearchBySkillQuery(),
  recruits: new RecruitsList(),
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
    SET_RECRUITS(state, recruits) {
      state.recruits = new RecruitsList(recruits)
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

      let unnamedRecruits

      coreApiClient
        .get(Recruit.routes.recruitsSearchPath, { params: query })
        .then(response => {
          commit('SET_QUERY', query)

          unnamedRecruits = response.data
          const public_recruit_ids = unnamedRecruits.map(item => item.public_recruit_id)

          return (
            recruitableApiClient
              .get(RecruitDocument.routes.recruitDocumentsSearchPath, { params: { public_recruit_ids }})
          )
        })
        .then(response => {
          const recruits = response.data.map(item => {
            const unnamed = unnamedRecruits.find(r => r.public_recruit_id === item.public_recruit_id)

            return { ...unnamed, ...item }
          })

          commit('SET_RECRUITS', recruits)
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
