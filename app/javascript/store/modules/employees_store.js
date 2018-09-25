import axios from 'axios'

import { Utils } from '../../lib/utils'
import { Employee, EmployeesList } from '../../models/employee'

const EmployeesStore = {
  namespaced: true,
  state: {
    employees: new EmployeesList,
    employee: new Employee,
    status: ''

  },
  getters: {
    employees: state => state.employees,
    employee: state => state.employee,
    status: state => state.status

  },
  mutations: {
    one(state, employee_id) {
      state.employee = state.employees.find({ id: employee_id })
      return state
    },
    many(state, data) {
      state.employees.replace(data)
      state.status = 'ok'
      return state
    },
    progress(state, flag) {
      state.status = flag
      return state
    }
  },
  actions: {
    index(context) {
      return new Promise((resolve, reject) => {
        context.commit('progress', 'loading')

        axios.get(context.state.employees.getFetchURL())
          .then( response => {
            let data = Utils.modelsFromResponse(response.data.data)
            context.commit('many', data)
          })
          .catch( error => {
            reject(error)
          })
      })
    }
  }
}

export default EmployeesStore
