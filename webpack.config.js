const VueLoaderPlugin = require('vue-loader/lib/plugin');

module.exports = {
  entry: './components/index.js',
  mode: 'development',
  module: {
    rules: [
      // ... other rules
      {
        test: /\.vue$/,
        loader: 'vue-loader'
	},
	{
	  test: /\.css$/,
	  use: [
		'vue-style-loader',
		'css-loader'
	  ]
	},
    ]
  },
  plugins: [
    // make sure to include the plugin!
    new VueLoaderPlugin()
],
	output: {
		path: `${__dirname}/shared/web/resources/js`,
		filename: 'bundle.js'
	}
}
