# Gulp file compiled by Jiri Orsag / Blueberry Apps

# Dependencies
gulp        = require 'gulp'
gutil       = require 'gulp-util'
concat      = require 'gulp-concat'
include     = require 'gulp-include'
notify      = require 'gulp-notify'
slim        = require 'gulp-slim'
sass        = require 'gulp-ruby-sass'
coffee      = require 'gulp-coffee'
bowerFiles  = require 'main-bower-files'
browserSync = require 'browser-sync'

# Source files
source =
  slim:     'source/**/*.slim'
  sass:     'source/css/**/*.sass'
  coffee:   'source/js/**/*.coffee'
  bower:    './bower_components'

# Generated output
output =
  html:     'public/'
  css:      'public/css/'
  js:       'public/js'

# Include files & compile Slim
gulp.task 'slim', ->
  gulp.src [source.slim, '!**/_*.slim'] # Exclude files starting w/ underscore
  .pipe include()
  .pipe slim pretty: true
  .pipe gulp.dest output.html

# Compile Sass
gulp.task 'sass', ->
  sass('source/css/app.sass', {
      loadPath: source.bower + '/bootstrap-sass/assets/stylesheets'
    }, style: 'expanded')
  .on('error', notify.onError((error) ->
    'Error: ' + error.message
  ))
  .pipe gulp.dest output.css

# Include Bower packages
gulp.task 'bower-files', ->
  gulp.src bowerFiles()
    .pipe concat 'bower-components.js'
    .pipe gulp.dest output.js

# Compile CoffeeScript
gulp.task 'coffee', ->
  gulp.src source.coffee
    .pipe concat 'user.js'
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

# Reload all browsers
gulp.task 'browser-reload', ->
  browserSync.reload()

# Watch files for changes
gulp.task 'watch', ->
  gulp.watch source.slim, ['slim']
  gulp.watch source.sass, ['sass']
  gulp.watch source.coffee, ['coffee']
  gulp.watch 'public/**/*', ['browser-reload']

# Gulp tasks
gulp.task 'default', ['slim', 'sass', 'bower-files', 'coffee', 'server', 'watch']
