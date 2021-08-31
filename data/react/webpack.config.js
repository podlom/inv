const path = require('path');
const webpack = require('webpack');
// const CleanWebpackPlugin = require('clean-webpack-plugin');
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
var OptimizeCssAssetsPlugin = require('optimize-css-assets-webpack-plugin');
const CleanWebpackPlugin = require('clean-webpack-plugin')

const PATHS = {
  root: path.resolve(__dirname, './'),
  nodeModules: path.resolve(__dirname, './node_modules'),
  src: path.resolve(__dirname, './src'),
  sass: path.resolve(__dirname, './sass'),
  dist: path.resolve(__dirname, './dist'),
}
const mods = require('./mods');
module.exports = (env = {}) => {
  env.build = true;
  const isBuild = !!env.build
  const isDev = !env.build
  const isSourceMap = !!env.sourceMap || isDev
  let entry = mods.reduce(function(c,v){c[v]='./src/'+v; return c;}, {
    react_loader: './src/ReactLoader',
    async_loader: './src/AsyncLoader',
  });
  let cache_groupds = mods.reduce(function(c,v){c[v]={test: new RegExp('(./)?src[\\/]'+v+'[\\/]'), name: v}; return c;}, {
    vendors: {
      test: /[\\/]node_modules[\\/]/,
      name: "vendors",
      chunks: "all",
    }
  });
  console.log({cache_groupds});


  return {
    cache: true,
    devtool: isDev ? 'eval-source-map' : false,

    context: PATHS.root,

    entry: entry,
    output: {
      path: PATHS.dist,
      publicPath: '/assets/skynar/',
      filename:  isDev ? '[name].[hash].js' : '[name].js',
      chunkFilename: '[name].[hash].chunk.js',
    },
    mode: process.env.NODE_ENV === 'production' ? 'production' : 'development',

    // Currently we need to add '.ts' to the resolve.extensions array.
    resolve: {
      extensions: ['.ts', '.tsx', '.js', '.jsx', '.json', '.sass', '.scss', '.css'],
      modules: ['src', 'node_modules'],
    },

    // Add the loader for .ts files.
    module: {
      rules: [
        {
          test: /\.tsx?$/,
          include: PATHS.src,
          use: [
            {
              loader: 'ts-loader',
              options: {
                transpileOnly: true,
                compilerOptions: {
                  'sourceMap': isSourceMap,
                  'target': isDev ? 'es2015' : 'es5',
                  'isolatedModules': true,
                  'noEmitOnError': false,
                  'removeComments': false
                },
              },
            },
          ]
        },
        {
            test: /\.js$/,
            loader: "source-map-loader",
            enforce: "pre"
        },
        {
          test: /\.css$/,
          use: [ MiniCssExtractPlugin.loader, 'css-loader']
        },
        {
          test: /\.s[ca]ss$/,
          use: [
            MiniCssExtractPlugin.loader,
            "css-loader",
            "sass-loader"
          ]
        }
      ]
    },
    externals: {
        "react": "React",
        "react-dom": "ReactDOM",
        "google.maps": "google.maps",
    },
    optimization: {
      splitChunks: {
        cacheGroups: cache_groupds
      },
      namedModules: true,
      minimize: isBuild
    },
    plugins: [
      new webpack.DefinePlugin({
        'process.env': {
          NODE_ENV: JSON.stringify(isDev ? 'development' : 'production'),
        },
      }),
      new CleanWebpackPlugin(['dist']),
      ...(isDev ? [
        new webpack.HotModuleReplacementPlugin({
          // multiStep: true, // better performance with many files
        }),
      ] : []),
      ...(isBuild ? [
        new webpack.LoaderOptionsPlugin({
          minimize: true,
          debug: false
        }),
      ] : []),
    ]
  }
}

