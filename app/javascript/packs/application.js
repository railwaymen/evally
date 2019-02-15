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

import router from '@/router'
import store from '@/store'

// Axios
import axios from '@/lib/http_config'
import VueAxios from 'vue-axios'
Vue.use(VueAxios, axios)

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

// Vue2Filters
import Vue2Filters from 'vue2-filters'
Vue.use(Vue2Filters)

// Mixins
import base_mixin from '@/lib/base_mixin'
Vue.mixin(base_mixin)

// Internationalization
import VueI18n from 'vue-i18n'
Vue.use(VueI18n)

import english from '@/locale/en'
import polish from '@/locale/pl'

const i18n = new VueI18n({
  locale: 'en',
  fallbackLocale: 'en',
  messages: { en: english, pl: polish }
})

// Highcharts
import HighchartsVue from 'highcharts-vue'
Vue.use(HighchartsVue)

// Properties
import _ from 'lodash'
Vue.prototype.$_ = _

import '@/assets/styles/application.styl'

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
