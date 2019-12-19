const path = require('path')

module.exports = {
  resolve: {
    alias: {
      '@': path.resolve(__dirname, '..', '..', 'app/javascript/application'),
      '@assets': path.resolve(__dirname, '..', '..', 'app/javascript/assets'),
      '@components': path.resolve(__dirname, '..', '..', 'app/javascript/components'),
      '@models': path.resolve(__dirname, '..', '..', 'app/javascript/models'),
      '@views': path.resolve(__dirname, '..', '..', 'app/javascript/views'),
      '@utils': path.resolve(__dirname, '..', '..', 'app/javascript/utils')
    }
  }
}
