# Gulp file compiled by Jiri Orsag / Blueberry Apps

# Dependencies
gulp        = require 'gulp'
gutil       = require 'gulp-util'
concat      = require 'gulp-concat'
notify      = require 'gulp-notify'
slim        = require 'gulp-slim'
sass        = require 'gulp-ruby-sass'
coffee      = require 'gulp-coffee'
browserSync = require 'browser-sync'

# Source files
sources =
  slim: 'source/**/*.slim'
  sass: 'source/css/**/*.sass'
  coffee: 'source/js/**/*.coffee'

# Generated output
output =
  html: 'public/'
  css: 'public/css/'
  js: 'public/js'

# Compile Slim
gulp.task 'slim', ->
  gulp.src sources.slim
  .pipe slim pretty: true
  .pipe gulp.dest output.html

# Compile Sass
gulp.task 'sass', ->
  sass('source/css/app.sass', style: 'expanded')
  .on('error', notify.onError((error) ->
    'Error: ' + error.message
  )).pipe gulp.dest(output.css)

# Compile CoffeeScript
gulp.task 'coffee', ->
  gulp.src(sources.coffee)
    .pipe concat 'app.js'
    .pipe(coffee(bare: true).on('error', gutil.log))
    .pipe gulp.dest output.js

# Run server
gulp.task 'server', ->
  browserSync
    open: true
    server:
      baseDir: output.html
    reloadDelay: 2000
    watchOptions:
      debounceDelay: 1000

# Reload all Browsers
gulp.task 'browser-reload', ->
  browserSync.reload()

# Watch files for changes
gulp.task 'watch', ->
  gulp.watch sources.slim, ['slim']
  gulp.watch sources.sass, ['sass']
  gulp.watch sources.coffee, ['coffee']
  gulp.watch 'public/**/*', ['browser-reload']

# Gulp tasks
gulp.task 'default', ['slim', 'sass', 'coffee', 'server', 'watch']
