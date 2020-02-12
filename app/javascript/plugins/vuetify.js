import Vue from 'vue'
import Vuetify from 'vuetify'

Vue.use(Vuetify)

import en from 'vuetify/lib/locale/en'
import pl from 'vuetify/lib/locale/pl'

export default new Vuetify({
  icons: {
    iconfont: 'mdi',
  },
  lang: {
    locales: { en, pl },
    current: 'en'
  }
})
