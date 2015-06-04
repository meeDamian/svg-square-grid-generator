#!/usr/bin/env coffee
'use strict'

fs    = require 'fs'
meow  = require 'meow'
path  = require 'path'
chalk = require 'chalk'



UNIT_PH = new RegExp '%UNIT%', 'g'
SIZE_PH = new RegExp '%GRID_SIZE%', 'g'
LINES_PH = new RegExp '<lines />'

DEFAULT_UNIT = 'cm'
DEFAULT_GRID_SIZE = 30
DEFAULT_CELL_SIZE = 2
OUTPUT_FILE = 'output.svg'

b = chalk.bold

cli = meow
  help: [
    'Usage: grid-gen <flags>'
    ''
    'Where <flags> are:'
    '  ' + b('--unit') + " (defaults to: #{DEFAULT_UNIT})"
    '    Specify grid unit, available units: cm, px, ???'
    '  ' + b('--grid-size') + " (defaults to: #{DEFAULT_GRID_SIZE})"
    '    How big the entire grid shoul be'
    '  ' + b('--cell-size') + " (defaults to: #{DEFAULT_CELL_SIZE})"
    '    The size of individual cell'
    '  ' + b('--file') + " (defaults to: #{OUTPUT_FILE})"
    '    File to save generated grid to'
    ''
    'Example usage:'
    '  grid-gen --file=bananas.svg --unit=cm --grid-size=99999 --cell-size=0.1'
    ''
  ].join '\n'


unit        = cli.flags.unit      ? DEFAULT_UNIT
gridSize    = cli.flags.gridSize  ? DEFAULT_GRID_SIZE
cellSize    = cli.flags.cellSize  ? DEFAULT_CELL_SIZE
outputFile  = cli.flags.file      ? OUTPUT_FILE


templatePath  = path.resolve __dirname, 'template.svg'
outputPath    = path.resolve outputFile

getLine = (unit, x1, x2, y1, y2) ->
  '  <line
    fill="none"
    stroke="#000000"
    x1="' + x1 + unit + '"
    y1="' + y1 + unit + '"
    x2="' + x2 + unit + '"
    y2="' + y2 + unit + '"
    />\n'


columns = '<!-- COLUMNS -->\n'
rows    = '<!-- ROWS -->\n'
for i in [0..gridSize] by cellSize
  columns += getLine unit, i, i, 0, gridSize
  rows    += getLine unit, 0, gridSize, i, i


fs.readFile templatePath, (err, data) ->
  if err
    console.error 'Template be gone. WHAT HAVE YOU DONE?'
    return

  data = data.toString()
    .replace UNIT_PH, unit
    .replace SIZE_PH, gridSize
    .replace LINES_PH, "#{columns}\n\n#{rows}"

  console.log "Saving to #{outputPath}..."
  fs.writeFile outputPath, data, (err) ->
    if err
      console.error err
      return

    console.log 'Success!'