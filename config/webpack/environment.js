const { environment } = require('@rails/webpacker')

const vue =  require('./loaders/vue')
environment.loaders.append('vue', vue)

const aliases = require('./paths')
environment.config.merge(aliases)

environment.loaders.append('stylus', {
  test: /\.styl$/,
  use: ['style-loader', 'css-loader', 'stylus-loader']
})

module.exports = environment
