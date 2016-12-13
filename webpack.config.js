var path = require('path');

module.exports = {
  context: __dirname,
  entry: {
    client_only: './webpack/client_only.js',
    client_and_server: './webpack/client_and_server.js'
  },
  output: {
    path: '/tmp/weltzeit/assets/webpack',
    filename: '[name].js',
    publicPath: '/webpack/'
  },
  module: {
    loaders: [
      // add any loaders here
    ]
  },
  resolve: {
    root: [
      '/tmp/weltzeit/node_modules',
      path.join(__dirname, '..', 'webpack')
    ]
  }
};
