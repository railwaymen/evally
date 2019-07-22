import axios from 'axios'

import { Utils } from '@/lib/utils'
import { Employee, EmployeesList } from '@/models/employee'

const initialState = () => ({
  employees: new EmployeesList(),
  employee: new Employee(),
  status: ''
})

const EmployeesStore = {
  namespaced: true,

  state: initialState,

  getters: {
    employees: state => state.employees,
    employee: state => state.employee,
    positions: state => Utils.pluckAttribute(state.employees.models, 'position'), //state.positions,
    groups: state => Utils.pluckAttribute(state.employees.models, 'group'), //state.groups,
    status: state => state.status
  },
  mutations: {
    clear(state) {
      state.employee = new Employee()
      return state
    },
    pick(state, id) {
      state.employee = state.employees.find({ id: id })
      return state
    },
    one(state, data) {
      state.employee = new Employee(data)
      return state
    },
    many(state, data) {
      state.employees.replace(data)
      state.status = 'ok'
      return state
    },
    push(state, data) {
      state.employees.add(data)
      return state
    },
    replace(state, employee) {
      state.employees.remove({ id: employee.id })
      state.employees.add(employee)
      return state
    },
    remove(state, id) {
      state.employees.remove({ id: id })
      state.employee.clear()
      return state
    },
    progress(state, flag) {
      state.status = flag
      return state
    },
    resetState(state) {
      state = Object.assign(state, initialState())
      return state
    }
  },
  actions: {
    index(context, params) {
      return new Promise((resolve, reject) => {
        context.commit('progress', 'loading')

        axios.get(context.state.employees.getFetchURL(), { params: params })
          .then(response => {
            context.commit('many', response.data)
            resolve()
          })
          .catch(error => {
            reject(error)
          })
      })
    },
    show(context, employee_id) {
      return new Promise((resolve, reject) => {
        context.commit('progress', 'loading')

        axios.get(`/v1/employees/${employee_id}`)
          .then(response => {
            context.commit('one', response.data)
            resolve()
          })
          .catch(error => {
            reject(error)
          })
      })
    },
    create(context, data) {
      return new Promise((resolve, reject) => {
        axios.post(context.state.employees.getFetchURL(), data)
          .then(response => {
            context.commit('push', new Employee(response.data))
            resolve()
          })
          .catch(error => {
            reject(error)
          })
      })
    },
    update(context, data) {
      return new Promise((resolve, reject) => {
        axios.put(context.state.employee.getFetchURL(), data)
          .then(response => {
            let employee = new Employee(response.data)

            employee.isHired() ? context.commit('replace', employee) : context.commit('remove', employee.id)

            resolve()
          })
          .catch(error => {
            reject(error)
          })
      })
    },
    destroy(context) {
      return new Promise((resolve, reject) => {
        axios.delete(context.state.employee.getFetchURL())
          .then(() => {
            context.commit('remove', context.state.employee.id)
            resolve()
          })
          .catch(error => {
            reject(error)
          })
      })
    }

  }
}

export default EmployeesStore
