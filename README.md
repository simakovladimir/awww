# Generic HTTP Acquisition Tool

## Description

This tool enables to parse a set of URLs according to a specified XML query
in order to access and download specific files from each URL. Exported
function supports various options to configure the process

## Syntax

```
awww(ddir, plan, url.prefix, url.query, recs = "force, tail = " - (%d)",
     delim = ", ", filter = "force", max.path = 230L, trials = 2L, ...)

```

where

- `ddir` is a character string containing directory path where to put downloaded files;

- `plan` is either CSV file name, or dataframe/matrix containing the set of URLs
  and naming information for the files too be downloaded. See Details
  section below;

- `url.prefix` is a character string containing the prefix (usually `http://domain/`) for
  extracted URLs;

- `url.query` is a character string with the XPath query to select expected URL;

- `recs` is either a function name for selecting records of plan, or integer vector
  specifying appropriate indices explicitly. See Details section below;

- `tail` is a character string specifying the suffix of the file name (may be empty).
  See Details section below;

- `delim` is a character string with delimiter between different parts of a file name
  specified within plan;

- `filter` is a function name (as a symol or as a character string) to process URL
  before content extraction;

- `max.path` is an integer value with maximally allowed character length for the paths of
  the files to be downloaded (default is 230 characters);

- `trials` is an integer value specifying maximum number of tries if download fails (by
  default a file is being attempted to download twice);

- `...` are additional arguments to be passed to `filter`

## Value

An integer vector containing indices of files that were failed to download.
Output value may be used to redownload failed files by means of substitution
it as `recs` argument

## Details

The function outputs the status of each file into `stdout`. If download is failed
it puts corresponding warning message to `stderr`.
The `plan` argument should refer to the structure (file/dataframe/matrix)
whose each row should be of the followng format:

```
<URL>;<semicolon separated parts of name>;<extention>
```

Each part of this structure (including those within <semicolon separated
parts of name>) should be enclosed into double quotes. Middle part (between
<URL> and <extention>) is concatenated with the use of `delim` and truncated
if resulting path is not fitted into `max.path` value.
`recs` argument, if it is specified as a function reference, is assumed to
take an integer vector as argument and return its appropriate subvector.
`tail` option supplements <semicolon supplemented parts of name> with an
auxiliary suffix. It may contain an integer placeholder for sprintf function
where current processing file number will be substituted. Alternatively, it
may be an empty string

## Examples
  
See `./awww.custom.R` for possible use cases

## License

MIT License
