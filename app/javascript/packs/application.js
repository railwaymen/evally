/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

console.log('Hello World from Webpacker')

import Vue from 'vue'
import App from '../app.vue'

import router from '../router'
import store from '../store'

// Axios
import axios from '../lib/http_config'
import VueAxios from 'vue-axios'
Vue.use(VueAxios, axios)

// Vuex
import Vuex from 'vuex'
Vue.use(Vuex)

// Vuetify
import Vuetify from 'vuetify'
Vue.use(Vuetify)

// Mixins
import flash_mixin from '../lib/flash_mixin'
Vue.mixin(flash_mixin)

import '../assets/stylesheets/application.styl'

document.addEventListener('DOMContentLoaded', () => {
  // Vue.axios.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

  // const el = document.body.appendChild(document.createElement('hello'))
  const el = document.getElementById('hello')

  if (el != null) {
    const app = new Vue({
      el,
      router,
      store,
      render: h => h(App)
    })

    console.log(app)
  }
})
