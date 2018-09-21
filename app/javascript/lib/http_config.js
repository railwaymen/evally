import axios from 'axios'

axios.defaults.baseURL = window.location.host //'http://localhost:3000/v1'
axios.defaults.headers.common['Content-Type'] = 'application/json'

const token = localStorage.getItem('user_token')
if (token) axios.defaults.headers.common['Authorization'] = 'Bearer ' + token

export default axios
