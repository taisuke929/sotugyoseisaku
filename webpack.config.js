import MiniCssExtractPlugin from 'mini-css-extract-plugin';
import CssMinimizerPlugin from 'css-minimizer-webpack-plugin';

module.exports = {
  entry: './index.js',
  module: {
    rules: [
      {
        test: /\.css$/,
        use: [
          MiniCssExtractPlugin.loader,
          'css-loader'
        ]
      },
    ],
  },
  plugins: [
    new MiniCssExtractPlugin({
      filename: 'file.css',
    }),
  ],
  optimization: {
    minimize: true,
    minimizer: [
      new CssMinimizerPlugin({
        test: /optimize-me\.css/g,
      }),
    ],
  },
  node: {
    // 無効なプロパティを削除
    __dirname: true, // 必要に応じて有効化
    __filename: true // 必要に応じて有効化
    // 'dgram', 'fs', 'net', 'tls', 'child_process' などは削除
  },
};
