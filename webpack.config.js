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
      new CssMinimizerPlugin({
        // ここで正規表現を使って特定のファイルを最適化できます
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
