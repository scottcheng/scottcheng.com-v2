module.exports = (grunt) ->

  require('load-grunt-tasks') grunt

  paths =
    src: 'src'
    dist: 'dist'
    tmp: '.tmp'

  grunt.initConfig

    paths: paths

    watch:
      jade:
        files: ['<%= paths.src %>/views/*.jade']
        tasks: ['jade']
      stylus:
        files: ['<%= paths.src %>/styles/*.styl']
        tasks: ['stylus']
      coffee:
        files: ['<%= paths.src %>/scripts/*.coffee']
        tasks: ['coffee', 'uglify:compile']
      copyFont:
        files: ['<%= paths.src %>/styles/fonts/*']
        tasks: ['copy:font']
      copyStatic:
        files: [
          '<%= paths.src %>/**/*'
          '!<%= paths.src %>/views{,/**/*}'
          '!<%= paths.src %>/styles{,/**/*}'
          '!<%= paths.src %>/scripts{,/**/*}'
        ]
        tasks: ['copy:static']

    jade:
      compile:
        files:
          '<%= paths.dist %>/index.html': '<%= paths.src %>/views/index.jade'

    stylus:
      compile:
        options:
          'include css': true
          paths: ['bower_components']
          import: [
            'nib'
            'scoticon.css'
            'normalize.css/normalize.css'
          ]
        files:
          '<%= paths.dist %>/styles/index.css': '<%= paths.src %>/styles/index.styl'

    coffee:
      compile:
        files:
          '<%= paths.tmp %>/scripts/index.js': '<%= paths.src %>/scripts/index.coffee'

    uglify:
      vendor:
        src: [
          'bower_components/jquery/dist/jquery.js'
        ]
        dest: '<%= paths.dist %>/scripts/vendor.js'
      compile:
        options:
          mangle: true
          compress: true
        src: [
          '<%= paths.tmp %>/scripts/index.js'
        ]
        dest: '<%= paths.dist %>/scripts/index.js'

    coffeelint:
      all: [
        'Gruntfile.coffee'
        '<%= paths.src %>/scripts/*.coffee'
      ]
      options:
        max_line_length: level: 'ignore'
        indentation: level: 'ignore'

    copy:
      font:
        files: [
          expand: true
          cwd: '<%= paths.src %>/styles/fonts'
          src: ['*']
          dest: '<%= paths.dist %>/styles/fonts'
        ]
      static:
        files: [
          expand: true
          cwd: '<%= paths.src %>/'
          src: [
            '**/*'
            '!views{,/**/*}'
            '!styles{,/**/*}'
            '!scripts{,/**/*}'
          ]
          dest: '<%= paths.dist %>'
        ]


    clean:
      tmp: '<%= paths.tmp %>'

  grunt.registerTask 'build', [
    'coffeelint'
    'jade'
    'stylus'
    'coffee'
    'uglify'
    'copy'
    'clean'
  ]

  grunt.registerTask 'default', [
    'build'
  ]
