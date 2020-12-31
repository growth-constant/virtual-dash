const { environment } = require('@rails/webpacker')
const webpack = require('webpack')


/*environment.loaders.append('babel',{
  test: /\.m?js$/,
  exclude: /node_modules/,
  use: {
    loader: "babel-loader",
    options: {
      presets: ['@babel/preset-env']
    }
  }
})*/

environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery'
  })
)

module.exports = environment