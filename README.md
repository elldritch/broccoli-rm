# broccoli-rm

`broccoli-rm` removes files.

Unlike other Broccoli file removing plugins, `broccoli-rm` works with folders.

# Usage
```
var rm = require('broccoli-rm');
var html = rm([inputTree1, inputTree2], {
  paths: ['excluded-file', 'path/to/excluded-file', 'excluded-folder/']
});
```

## `rm(inputs, options)`
`inputs` is an array of input Broccoli nodes.

`options` is an optional object specifying plugin options.

`options.paths` is an array of glob strings specifying the names of files to
exclude.

# License
Copyright 2016 Lehao Zhang. Released to the general public under the terms of
the ISC license.
