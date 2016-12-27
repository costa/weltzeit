const ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
  context: __dirname,
  entry: {
    client_only: './webpack/client_only.js',
    client_and_server: './webpack/client_and_server.js'
  },
  output: {
    path: (process.env.RAILS_ASSETS_PATH ? process.env.RAILS_ASSETS_PATH : './public') + '/webpack',
    filename: '[name].js',
    publicPath: '/webpack/'
  },
  module: {
    loaders: [
      {
        test: /\.css$/,
        loader: ExtractTextPlugin.extract('style-loader', 'css-loader')
      },
      {
        test: /\.(woff|woff2)(\?v=\d+\.\d+\.\d+)?$/,
        loader: 'url?limit=10000&mimetype=application/font-woff'
      },
      {
        test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/,
        loader: 'url?limit=10000&mimetype=application/octet-stream'
      },
      {
        test: /\.eot(\?v=\d+\.\d+\.\d+)?$/,
        loader: 'file'
      },
      {
        test: /\.svg(\?v=\d+\.\d+\.\d+)?$/,
        loader: 'url?limit=10000&mimetype=image/svg+xml'
      }
    ]
  },
  resolve: {
    root: process.env.NODE_PATH  // NOTE does not respect $NODE_PATH
  },
  resolveLoader: {
    root: process.env.NODE_PATH  // NOTE does not respect $NODE_PATH
  },
  plugins: [
    new ExtractTextPlugin('[name].css')
 ]
};
