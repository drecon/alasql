//
// gulpfile.js
// Gulp for Alasql
// Дата: 06.08.2014
// (c) 2014, Andrey Gershun
//

var gulp = require('gulp');
module.exports = gulp;
//var connect = require('gulp-connect');
//var livereload = require('gulp-livereload');
//var changed = require('gulp-changed');
//var jison = require('gulp-jison');
var concat = require('gulp-concat-sourcemap');
//var uglify = require('gulp-uglify');
//var jisonLex = require('gulp-jison-lex');
var shell = require('gulp-shell');


gulp.task('js-merge', function () {
  return gulp.src([
  	'./src/10start.js', 
  	'./src/alasqlparser.js', 
    './src/12pretty.js', 
  	'./src/15utility.js', 
    './src/17alasql.js', 
    './src/20database.js',
    './src/21transaction.js',
//    './src/22store.js',
    './src/23table.js',
    './src/24view.js',
  	'./src/25queryclass.js',
    './src/28yy.js',
  	'./src/30statements.js',
    './src/38query.js',
    './src/39dojoin.js',
  	'./src/40select.js',
    './src/41exists.js',
    './src/420from.js',
    './src/421join.js',
    './src/422where.js',
    './src/423groupby.js',
    './src/424select.js',
    './src/425having.js',
    './src/426orderby.js',
    './src/43rollup.js',    
    './src/44defcols.js',
    './src/45union.js',
  	'./src/50expression.js',
    './src/52linq.js',
    './src/55functions.js',
    './src/56datetime.js',
    './src/57case.js',
    './src/58json.js',
    './src/59convert.js',
  	'./src/60createtable.js',
    './src/61date.js',
    './src/62droptable.js',
    './src/64altertable.js',
    './src/65createindex.js',
    './src/66dropindex.js',
    './src/67createview.js',
    './src/68if.js',
    './src/69while.js',
  	'./src/70insert.js',
    './src/72delete.js',
    './src/74update.js',
    './src/74update.js',
    './src/76usedatabase.js',
    './src/77declare.js',
    './src/78show.js',
    './src/79set.js',
    './src/80console.js',
    './src/81commit.js',
    './src/83into.js',
    './src/84from.js',
    './src/85help.js',
    './src/86print.js',
    './src/87source.js',
    './src/88require.js',
    './src/89assert.js',
    './src/90websql.js',
    './src/91indexeddb.js',
    './src/92localstorage.js',
    './src/93sqlite.js',
    './src/97saveas.js',
    './src/FileSaver.js',
   	'./src/98finish.js',
    './src/99worker.js'
    ])
//    .pipe(changed('./dist/'))
    .pipe(concat('alasql.js'))
//    .pipe(uglify())
    .pipe(gulp.dest('./'))
});


gulp.task('jison-compile', function () {
  return gulp.src('./src/*.jison', {read: false})
    .pipe(shell([
      'jison ./src/alasqlparser.jison -o ./src/alasqlparser.js',
    ]));
});


gulp.task('uglify', function () {
  return gulp.src('./alasql.js', {read: false})
    .pipe(shell([
      'uglifyjs alasql.js -o alasql.min.js',
    ]));
});

gulp.task('copy-dist', function(){
  gulp.src(['./alasql.js','./alasql.min.js','./alasql.js.map','./alasql-worker.js'])
    .pipe(gulp.dest('dist'));
});

gulp.task('copy-dist-org', function(){
  gulp.src(['./alasql.min.js','./alasql-worker.js'])
    .pipe(gulp.dest('./console/'));
});

gulp.task('copy-console-org', function(){
  gulp.src(['./console/*'])
    .pipe(gulp.dest('../alasql-org/console/'));
});

//    , {
//      templateData: {
//        f: function (s) {
//          return s.replace(/$/, '.bak')
//        }
//      }
//    }))

// gulp.task('jison-compile', function () {
//   return gulp.src('./src/*.jison')
 //    .pipe(changed('./dist/'))
//     .pipe(jison({ moduleType: 'commonjs' }))
//     .pipe(gulp.dest('./src/'))
// //    .pipe(livereload());
// });

// gulp.task('jison-lex-compile', function () {
//   return gulp.src('./src/*.jisonlex')
// //    .pipe(changed('./dist/'))
//     .pipe(jisonLex())
//     .pipe(gulp.dest('./src2/'))
// //    .pipe(livereload());
// });


// Главная задача
gulp.task('default', ['js-merge' /*, 'jison-compile', 'jison-lex-compile' */], function(){
  gulp.watch('./src/*.js',function(){ gulp.run('js-merge'); });
  gulp.watch('./src/*.jison',function(){ gulp.run('jison-compile'); });
  gulp.watch('./alasql.js',function(){ gulp.run('uglify'); });
  gulp.watch('./alasql.min.js',function(){ 
    gulp.run('copy-dist'); 
    gulp.run('copy-dist-org');
  });
  gulp.watch('./alasql-worker.js',function(){ 
    gulp.run('copy-dist'); 
    gulp.run('copy-dist-org');
  });
  gulp.watch('./console/*',function(){ gulp.run('copy-console-org'); });
  // gulp.watch('./src/*.jison',function(){ gulp.run('jison-compile'); gulp.run('js-merge');});
  // gulp.watch('./src/*.jisonlex',function(){ gulp.run('jison-lex-compile'); gulp.run('js-merge');});
});
