# svg-square-grid-generator
Small CLI utility that generates a grid of squares, for given parameters, in svg format

## Usage

```
$ grid-gen --help

  Small utility that generates a grid of squares, for given parameters, in svg format

  Usage: grid-gen <flags>

  Where <flags> are:
    --unit (defaults to: cm)
      Specify grid unit, available units: cm, px, ???
    --grid-size (defaults to: 30)
      How big the entire grid shoul be
    --cell-size (defaults to: 2)
      The size of individual cell
    --file (defaults to: output.svg)
      File to save generated grid to

  Example usage:
    grid-gen --file=bananas.svg --unit=cm --grid-size=99999 --size=0.1

```
