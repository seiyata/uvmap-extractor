# uvmap-extractor
Perl script to extract UV map from .obj file

## Usage

```
$ perl uvmap-extractor.pl <InputFile> <OutputFile>
```
## Input (.obj file)

https://en.wikipedia.org/wiki/Wavefront_.obj_file

## Output (JSON file)

Something like..
```
[
  [[0, 0], [0, 0.1], [0.1, 0]],
  [[0, 0.1], [0.1, 0.1], [0.1, 0]],
  ...
]
```
