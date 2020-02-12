const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)

const aliases = require('./paths')
environment.config.merge(aliases)

environment.loaders.append('stylus', {
  test: /\.styl$/,
  use: ['style-loader', 'css-loader', 'stylus-loader']
})

environment.loaders.append('sass', {
  test: /\.s[ac]ss$/i,
  use: [
    'style-loader',
    'css-loader',
    {
      loader: 'sass-loader',
      options: {
        implementation: require('sass'),
        sassOptions: {
          fiber: require('fibers'),
        },
      },
    },
  ],
})

module.exports = environment
