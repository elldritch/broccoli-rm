path = require 'path'

Plugin = require 'broccoli-plugin'
walk = require 'walk-sync'
mkdirp = require 'mkdirp'
{sync: isDir} = require 'is-directory'
{sync: symlink} = require 'symlink-or-copy'
minimatch = require 'minimatch'

class BroccoliRm extends Plugin
  constructor: (inputNodes, options) ->
    unless @ instanceof BroccoliRm
      return new BroccoliRm inputNodes, options
    @paths = options?.paths or []
    super inputNodes, options

  build: ->
    for inputPath in @inputPaths
      # This way, we exclude everything _within_ an excluded folder.
      excludes = @paths.map (exclude) ->
        if isDir path.join inputPath, exclude
          path.join exclude, '**', '*'
        else exclude

      files = walk.entries inputPath

      for file in files
        continue if file.isDirectory()
        {basePath, relativePath} = file

        shouldExclude = false
        for exclude in excludes
          # Curiously, this line doesn't parse if we get rid of the parentheses.
          # CoffeeScript bug?
          if minimatch relativePath, exclude, {dot: true}
            shouldExclude = true
            break
        continue if shouldExclude

        outputPath = path.join @outputPath, rel
        mkdirp.sync path.dirname outputPath

        fullPath = path.join basePath, relativePath
        symlink fullPath, outputPath

module.exports = BroccoliRm
