<p align="center">
  <img width="125" height="254" src="https://raw.githubusercontent.com/geoRG77/blueberry_gulp/master/blueberry-gulp-2x.png">
</p>

Blueberry gulp
==============

## Features
- SLIM
- SASS
- CoffeeScript
- Browser Sync

## Bower components
- bootstrap-sass
- jquery (bootstrap dependency)

## File structure
```
bower_components      # generated automatically
node_modules          # generated automatically
public/               # generated automatically
  css/
  js/
  index.html
source/               # put your files here
  css/
  js/
  index.slim
```

## Usage
Download repo
```shell
$ git clone git@github.com:laxplaer/blueberry_gulp.git
```

Install Node.js dependencies
```shell
$ npm install
```

Install Bower packages
```shell
$ bower install
```

Current bug with bootstrap and jquery 3.0.0
```shell
$ bower uninstall jquery
```
```shell
$ bower install jquery#2.2.4
```


Run Gulp
```shell
$ gulp
```
