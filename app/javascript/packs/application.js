/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Vue from 'vue'
import App from '@/App'

import router from '@router/router'
import store from '@store/store'

// Axios (custom config)
import http from '@utils/http'
import VueAxios from 'vue-axios'
Vue.use(VueAxios, http)

// Vuex
import Vuex from 'vuex'
Vue.use(Vuex)

// Vuetify
import Vuetify from 'vuetify'

import Ven from 'vuetify/lib/locale/en'
import Vpl from 'vuetify/lib/locale/pl'

Vue.use(Vuetify, {
  lang: {
    locales: { en: Ven, pl: Vpl },
    current: 'en'
  }
})

// Vue2Clipboard
import VueClipboard from 'vue-clipboard2'
Vue.use(VueClipboard)

// VueMoment
import VueMoment from 'vue-moment'
import moment from 'moment'

Vue.use(VueMoment, { moment })

// Mixins
import globalMixin from '@utils/mixins/global'
Vue.mixin(globalMixin)

// Internationalization
import i18n from '@locales/i18n'

// Assets styles
import '@assets/styles/application.styl'

document.addEventListener('DOMContentLoaded', () => {

  const el = document.getElementById('hello')

  if (el != null) {
    const app = new Vue({
      el,
      i18n,
      router,
      store,
      render: h => h(App)
    })

    if (process.env.NODE_ENV !== 'production') console.log(app)
  }
})
