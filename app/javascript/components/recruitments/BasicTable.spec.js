import { shallowMount } from '@vue/test-utils'
import i18n from '@locales/i18n'

import BasicTable from './BasicTable'

import RecruitDocumentPolicy from '@policies/recruit_document_policy'

import { RecruitDocumentsList } from '@models/recruit_document'
import { User } from '@models/user'

describe('BasicTable', () => {
  const admin = new User({role: 'admin'})

  const props = {
    loading: false,
    recruitDocuments: new RecruitDocumentsList(),
    groups: ['ror', 'android'],
    statuses: ['fresh', 'accepted'],
    editable: false,
    recruitDocumentPolicy: new RecruitDocumentPolicy(admin, null)
  }

  const wrapper = shallowMount(
    BasicTable,
    {
      propsData: props,
      stubs: ['v-layout', 'v-data-table', 'v-flex', 'v-text-field', 'v-select'],
      mocks: {
        $t: key => i18n.t(key)
      }
    })

  it('has a name', () => {
    expect(BasicTable.name).toEqual('BasicTable')
  })

  it('props', () => {
    expect(wrapper.props().loading).toEqual(false)
    expect(wrapper.props().recruitDocuments.models).toHaveLength(0)
  })

  it('data.search', () => {
    expect(wrapper.vm.search).toEqual('')
  })

  it('data.headers', () => {
    expect(wrapper.vm.headers).toEqual([{
      sortable: false,
      value: 'action',
    },
    {
      text: i18n.t('components.employees.table.cols.name'),
      value: 'fullname'
    },
    {
      text: i18n.t('components.recruitments.table.cols.email'),
      value: 'email'
    },
    {
      text: i18n.t('components.recruitments.table.cols.group'),
      value: 'group',
      filterable: false
    },
    {
      text: i18n.t('components.recruitments.table.cols.position'),
      value: 'position'
    },
    {
      text: i18n.t('components.recruitments.table.cols.status'),
      value: 'status',
      filterable: false
    },
    {
      text: i18n.t('components.recruitments.table.cols.source'),
      value: 'source'
    },
    {
      text: i18n.t('components.recruitments.table.cols.receivedAt'),
      value: 'received_at'
    },
    {
      text: i18n.t('components.recruitments.table.cols.acceptCurrentProcessing'),
      value: 'accept_current_processing',
    },
    {
      text: i18n.t('components.recruitments.table.cols.acceptFutureProcessing'),
      value: 'accept_future_processing',
    }])
  })

  it('matches do snapshot', () => {
    expect(wrapper.html()).toMatchSnapshot()
  })
})
