// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// Turboのインポート
import Rails from "@rails/ujs"
Rails.start()

// ActiveStorageのインポート
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()

// 追加のJSファイルをインポートする場合はここに追加
import "channels"

// Bootstrapなどの他のライブラリもここでインポート可能
import "bootstrap"
import "../stylesheets/application"
import "stylesheets/application"