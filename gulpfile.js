var config = require('./gulp.config');
var gulp = require('gulp');
var shell = require('gulp-shell');


gulp.task('build-html', shell.task('sphinx-build -b html -d build/doctrees source doc'));

gulp.task('build-epub', shell.task('sphinx-build -b epub -d build/doctrees source build/epub'))
gulp.task('default', ['build-html'], function() {
  gulp.watch(['./source/**/*.rst', './source/**/*.md'], ['build-html']);
});
