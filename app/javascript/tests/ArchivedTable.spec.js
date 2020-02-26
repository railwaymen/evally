import { shallowMount } from '@vue/test-utils'
import ArchivedTable from '@components/employees/ArchivedTable.vue'

// const wrapper = shallowMount(ArchivedTable)

describe('ArchivedTable', () => {
  // Inspect the raw component options
  it('has a created hook', () => {
    expect(typeof ArchivedTable.name).toBe('string')
  })

  it('data', () => {
    expect(typeof ArchivedTable.data).toBe('function')

    const data = ArchivedTable.data()
    expect(data['headers'].length).toEqual(6)
  })
})