var config = require('./gulp.config');
var gulp = require('gulp');
var del = require('del');
var shell = require('gulp-shell');


gulp.task('build-html', shell.task('sphinx-build -b html -d build/doctrees source doc'));

gulp.task('clean', function () {
    return del(['/doc/*']);
});

gulp.task('build-epub', shell.task('sphinx-build -b epub -d build/doctrees source build/epub'));

gulp.task('default', ['clean', 'build-html'], function() {
  gulp.watch(['./source/**/*.rst', './source/**/*.md', './source/conf.py'], ['clean', 'build-html']);
});
