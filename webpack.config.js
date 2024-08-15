const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CssMinimizerPlugin = require('css-minimizer-webpack-plugin');

module.exports = {
  entry: './index.js',
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
  node: {
    dgram: 'empty',  // この行を追加
    fs: 'empty',     // この行を追加
    net: 'empty',    // この行を追加
    tls: 'empty',    // この行を追加
    child_process: 'empty', // この行を追加
  },
};

