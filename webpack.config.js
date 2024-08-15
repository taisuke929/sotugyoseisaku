const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CssMinimizerPlugin = require('css-minimizer-webpack-plugin');

module.exports = {
  mode: 'development',
  entry: './src/index.js',
  module: {
    rules: [
      {
        test: /\.css$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader',
        ],
      },
    ],
  },
  optimization: {
    minimizer: [
      '...',
      new CssMinimizerPlugin({
        test: /optimize-me\.css$/i,
      }),
    ],
  },
  plugins: [
    new MiniCssExtractPlugin({
      filename: 'file.css',
    }),
  ],

};

