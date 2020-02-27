import { shallowMount } from '@vue/test-utils'
import ArchivedTable from './ArchivedTable'
import { EmployeesList } from '@models/employee'

describe('ArchivedTable', () => {
  const props = {loading: false, employees: new EmployeesList(), editable: false }
  const wrapper = shallowMount(ArchivedTable, {propsData: props,
    stubs: [ 'v-layout', 'v-data-table', 'v-flex', 'v-text-field'] })

  it('has a name', () => {
    expect(typeof ArchivedTable.name).toBe('string')
    expect(ArchivedTable.name).toEqual('ArchivedTable')
  })

   it('props', () => {
     expect(wrapper.props().loading).toEqual(false)
     expect(wrapper.props().employees.models.length).toEqual(0)
   })

  it('matches do snapshot', () => {
    expect(wrapper.html()).toMatchSnapshot()
  })
})