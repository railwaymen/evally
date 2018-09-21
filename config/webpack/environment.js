const { environment } = require('@rails/webpacker')
const vue =  require('./loaders/vue')

environment.loaders.append('vue', vue)

environment.loaders.append('stylus', {
  test: /\.styl$/,
  use: ['style-loader', 'css-loader', 'stylus-loader']
})

module.exports = environment
