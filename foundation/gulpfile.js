var gulp = require('gulp'),
	browserSync = require('browser-sync').create(),
	$ = require('gulp-load-plugins')(),
	autoprefixer = require('autoprefixer'),
	sourcemaps = require('gulp-sourcemaps'),
	jsImport = require('gulp-js-import'),
	uglify = require('gulp-uglify'),
	rigger = require('gulp-rigger');

const minify = require('gulp-minify');

var sassPaths = [
	'node_modules/foundation-sites/scss',
	'node_modules/motion-ui/src',
];

function devSass() {
	return gulp
		.src([
			'../www/css/scss/main.scss',
			'../www/css/scss-v2/style-v2.scss',
			'node_modules/foundation-sites/scss',
		])
		.pipe(sourcemaps.init())
		.pipe(
			$.sass({
				// includePaths: sassPaths,
				outputStyle: 'compressed', // if css compressed **file size**
			}).on('error', $.sass.logError),
		)
		.pipe(
			$.postcss([
				autoprefixer({ browsers: ['last 2 versions', 'ie >= 9'] }),
			]),
		)
		.pipe(sourcemaps.write('.'))
		.pipe(gulp.dest('../www/css'))
		.pipe(browserSync.stream());
}

function sass() {
	return gulp
		.src(['scss/app.scss', 'scss/admin_app.scss'])
		.pipe(sourcemaps.init())
		.pipe(
			$.sass({
				includePaths: sassPaths,
				outputStyle: 'compressed', // if css compressed **file size**
			}).on('error', $.sass.logError),
		)
		.pipe(
			$.postcss([
				autoprefixer({ browsers: ['last 2 versions', 'ie >= 9'] }),
			]),
		)
		.pipe(sourcemaps.write('.'))
		.pipe(gulp.dest('../www/css'))
		.pipe(browserSync.stream());
}

function minifyJs() {
	return gulp
		.src('../www/js/common.js', { allowEmpty: true })
		.pipe(minify({ noSource: true }))
		.pipe(gulp.dest('../www/js'));
}

function serve() {
	browserSync.init({
		proxy: 'http://slava.skynar.co',
		port: 3000,
	});

	gulp.watch('../www/css/scss-v2/components/*.scss', devSass);
	gulp.watch('../www/css/scss-v2/utils/*.scss', devSass);
	gulp.watch('../www/css/scss-v2/sections/*.scss', devSass);
	gulp.watch('../www/css/scss-v2/*.scss', devSass);

	gulp.watch('../www/js/common.js', minifyJs);

	// gulp.watch('../www/css/scss/*.scss', devSass);
	// gulp.watch('../www/css/scss/partials/*.scss', devSass);
	// gulp.watch('../www/css/scss/partials/*.css', devSass);
	gulp.watch('scss/**/*.scss', sass);
	gulp.watch('js/**/*.js', js);
	gulp.watch('../template/**/*.tpl').on('change', browserSync.reload);
	gulp.watch('../www/assets/webpack/*.*').on('change', browserSync.reload);
}

function js() {
	return gulp
		.src(['js/app.js', 'js/admin_app.js'])
		.pipe(sourcemaps.init())
		.on('error', swallowError)
		.pipe(rigger())
		.pipe(gulp.dest('../www/js/'))
		.pipe(browserSync.stream());
}

gulp.task('sass', sass);
gulp.task('js', js);
gulp.task('serve', gulp.series('sass', serve));
gulp.task('default', gulp.series('sass', serve));

gulp.task('compress', function() {
	gulp.src('../www/js/common.js')
		.pipe(minify({ noSource: true }))
		.pipe(gulp.dest('../www/js'));
});

function swallowError(error) {
	// If you want details of the error in the console
	console.log(error.toString());
	this.emit('end');
}
