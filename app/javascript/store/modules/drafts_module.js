import http from '@/lib/http_config'

import { Evaluation, EvaluationsList } from '@models/evaluation'
import { SectionsList } from '@models/section'

const initialState = () => ({
  drafts: new EvaluationsList(),
  draft: new Evaluation(),
  sections: new SectionsList(),
  loading: true
})

const DraftsModule = {
  namespaced: true,

  state: initialState(),

  getters: {
    drafts: state => state.drafts,
    draft: state => state.draft,
    sections: state => state.sections,
    loading: state => state.loading
  },
  mutations: {
    clear(state) {
      state.draft = new Evaluation()
      state.sections = new SectionsList()
      return state
    },
    list(state, data) {
      state.drafts = new EvaluationsList(data)
      state.loading = false
      return state
    },
    item(state, { draft, sections }) {
      state.draft = new Evaluation(draft)
      state.sections = new SectionsList(sections)
      return state
    },
    inProgress(state, status) {
      state.loading = status
      return state
    },
    replace(state, section) {
      state.sections.replace(section)
      return state
    },
    remove(state, id) {
      state.draft = new Evaluation()
      state.sections = new SectionsList()
      state.drafts.remove(id)
      return state
    },
    resetState(state) {
      state = Object.assign(state, initialState())
      return state
    }
  },
  actions: {
    index(context) {
      context.commit('inProgress', true)

      http.get(Evaluation.routes.draftsPath)
        .then(response => {
          context.commit('list', response.data)
        })
        .catch(() => {
          context.commit('FlashStore/push', { error: 'Error :(' }, { root: true })
        })
    },
    show(context, id) {
      http.get(Evaluation.routes.draftPath(id))
        .then(response => {
          context.commit('item', response.data)
        })
        .catch(() => {
          context.commit('FlashStore/push', { error: 'Error :(' }, { root: true })
        })
    },
    update(context) {
      const { draft, sections } = context.state;

      const params = {
        draft: {
          sections: sections.models
        }
      }

      http.put(Evaluation.routes.draftPath(draft.id), params)
        .then(response => {
          context.commit('item', response.data)

          context.commit('FlashStore/push', { success: 'Updated :)' }, { root: true })
        })
        .catch(() => {
          context.commit('FlashStore/push', { error: 'Error :(' }, { root: true })
        })
    },
    complete(context, { nextEvaluationDate }) {
      const { draft, sections } = context.state;

      const params = {
        draft: {
          state: 'completed',
          next_evaluation_at: nextEvaluationDate,
          sections: sections.models
        }
      }

      http.put(Evaluation.routes.draftPath(draft.id), params)
        .then(() => {
          context.commit('remove', draft.id)

          context.commit('FlashStore/push', { success: 'Completed :)' }, { root: true })
        })
        .catch(() => {
          context.commit('FlashStore/push', { error: 'Error :(' }, { root: true })
        })
    },
    destroy(context) {
      const { draft } = context.state;

      http.delete(Evaluation.routes.draftPath(draft.id))
        .then(() => {
          context.commit('remove', draft.id)

          context.commit('FlashStore/push', { success: 'Destroyed :)' }, { root: true })
        })
        .catch(() => {
          context.commit('FlashStore/push', { error: 'Error :(' }, { root: true })
        })
    }
  }
}

export default DraftsModule
