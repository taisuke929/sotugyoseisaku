process.env.NODE_ENV = process.env.NODE_ENV || 'production'

const { environment } = require('@rails/webpacker');
const webpack = require('webpack');

// Custom configuration
environment.config.merge({
  node: {
    // Comment out or remove these properties if not needed
    // dgram: 'empty',
    // fs: 'empty',
    // net: 'empty',
    // tls: 'empty',
    // child_process: 'empty',
  },
});

module.exports = environment.toWebpackConfig();