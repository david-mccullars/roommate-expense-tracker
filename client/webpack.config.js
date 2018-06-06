const webpack = require('webpack');
const path = require('path');

const dev = process.env.NODE_ENV !== 'production';

const devPlugins = [
  new webpack.HotModuleReplacementPlugin(),
];

const devServer = {
  colors: true,
  compress: true,
  contentBase: path.resolve('src'),
  historyApiFallback: {
    disableDotRule: true
  },
  port: 3001,
  progress: true,
  stats: {
    cached: false
  },
  watchOptions: {
    ignored: /node_modules/
  },
};

const prodPlugins = [
  new webpack.DefinePlugin({
    'process.env': {
      NODE_ENV: JSON.stringify('production')
    }
  }),
  new webpack.optimize.OccurrenceOrderPlugin(),
  new webpack.optimize.DedupePlugin(),
  new webpack.optimize.UglifyJsPlugin({
    compress: {
      screw_ie8: true
    },
  }),
];

const config = {
  entry: ['./src/index.js'],
  target: 'web',
  devtool: (dev ? 'eval' : undefined),
  output: {
    path: path.join(__dirname, '../public'),
    filename: 'bundle.js',
  },
  module: {
    loaders: [
      { test: /\.jsx?$/, loader: ['babel-loader'], include: path.resolve('src'), exclude: [/node_modules/] },
      { test: /\.css$/, loader: 'style-loader!css-loader' },
      { test: /\.(png|eot|woff2?|ttf|svg)$/, loader: 'file-loader?name=static/media/[name].[hash:8].[ext]' },
    ],
  },
  plugins: (dev ? devPlugins : prodPlugins),
  devServer: (dev ? devServer : undefined),
};

if (dev) {
  config.entry.unshift('webpack/hot/dev-server');
}

module.exports = config;
