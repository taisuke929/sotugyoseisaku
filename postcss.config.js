module.exports = {
  // postcssOptions に変更
  postcssOptions: {
    // 必要なプラグインをここに設定
    plugins: [
      require('autoprefixer')(),
      // その他のプラグインを追加
    ],
  },
};
