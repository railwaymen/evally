import { shallowMount } from '@vue/test-utils'
import i18n from '@locales/i18n'

import RecruitmentsSidebar from './RecruitmentsSidebar'

import { RecruitDocumentPolicy } from '@policies/recruit_document_policy'

import { AttachmentsList } from '@models/attachment'
import { RecruitDocument } from '@models/recruit_document'
import { User, UsersList } from '@models/user'

describe('RecruitmentsSidebar', () => {
  const admin = new User({role: 'admin'})

  const props = {
    recruitDocument: new RecruitDocument({
      email: 'e@domain.org',
      received_at: '2020-02-10'
    }),
    attachments: new AttachmentsList(),
    statuses: ['accepted', 'rejected'],
    groups: ['Ruby', 'Android'],
    positions: ['Junior', 'Senior'],
    evaluators: new UsersList(),
    policy: new RecruitDocumentPolicy(admin)
  }

  const wrapper = shallowMount(
    RecruitmentsSidebar,
    {
      propsData: props,
      stubs: [
        'v-layout', 'v-flex', 'v-text-field', 'v-btn', 'v-icon', 'v-combobox', 'v-list',
        'v-list-item', 'v-list-item-action', 'v-list-item-content', 'v-list-item-title',
        'v-list-item-subtitle', 'v-file-input', 'v-select'
      ],
      mocks: {
        $t: key => i18n.t(key)
      }
    })

  it('has a name', () => {
    expect(RecruitmentsSidebar.name).toEqual('RecruitmentsSidebar')
  })

  it('props', () => {
     expect(wrapper.props().recruitDocument.email).toEqual('e@domain.org')
   })

  it('matches do snapshot', () => {
    expect(wrapper.html()).toMatchSnapshot()
  })
})
