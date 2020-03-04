import { shallowMount } from '@vue/test-utils'
import i18n from '@locales/i18n'

import RecruitmentsSidebar from './RecruitmentsSidebar'

import { Recruitment } from '@models/recruitment'

describe('RecruitmentsSidebar', () => {
  const props = {
    recruitment: new Recruitment({email: 'e@domain.org'}),
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
     expect(wrapper.props().recruitment.email).toEqual('e@domain.org')
   })

  it('matches do snapshot', () => {
    expect(wrapper.html()).toMatchSnapshot()
  })
})
