import { shallowMount } from '@vue/test-utils'
import i18n from '@locales/i18n'

import RecruitmentsSidebar from './RecruitmentsSidebar'

import { RecruitDocument } from '@models/recruit_document'

describe('RecruitmentsSidebar', () => {
  const props = {
    recruitDocument: new RecruitDocument({
      email: 'e@domain.org',
      received_at: '2020-02-10'
    }),
  }

  const wrapper = shallowMount(
    RecruitmentsSidebar,
    {
      propsData: props,
      stubs: ['v-layout', 'v-flex', 'v-text-field'],
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
