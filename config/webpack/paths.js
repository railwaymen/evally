const path = require('path')

module.exports = {
  resolve: {
    alias: {
      '@': path.resolve(__dirname, '..', '..', 'app/javascript/application'),
      '@assets': path.resolve(__dirname, '..', '..', 'app/javascript/assets'),
      '@components': path.resolve(__dirname, '..', '..', 'app/javascript/components'),
      '@locales': path.resolve(__dirname, '..', '..', 'app/javascript/locales'),
      '@models': path.resolve(__dirname, '..', '..', 'app/javascript/models'),
      '@store': path.resolve(__dirname, '..', '..', 'app/javascript/store'),
      '@views': path.resolve(__dirname, '..', '..', 'app/javascript/views'),
      '@utils': path.resolve(__dirname, '..', '..', 'app/javascript/utils')
    }
  }
}
