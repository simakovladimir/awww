# Generic HTTP Acquisition Tool
# *****************************
# Description
#   This tool allows to parse a set of URLs according to the specified XML query
#   in order to access and download specific files from each URL. Exported
#   function supports various options to configure the process
# Dependencies
#   r-base, curl, XML
# Signature
#   awww(ddir, plan, url.prefix, url.query, recs = "force, tail = " - (%d)",
#        delim = ", ", filter = "force", max.path = 230L, trials = 2L, ...)
#     ddir
#       character string containing directory path where to put downloaded files
#     plan
#       either CSV file name, or data.frame/matrix containing the set of URLs
#       and naming information for the files too be downloaded. See Details
#       section below
#     url.prefix
#       character string containing the prefix (usually http://domain/) for
#       extracted URLs
#     url.query
#       character string with the XPath query to select expected URL
#     recs
#       either a function name for selecting records of plan, or integer vector
#       specifying appropriate indices explicitly. See Details section below
#     tail
#       character string specifying the suffix of the file name (may be empty).
#       See Details section below
#     delim
#       character string with delimiter between different parts of a file name
#       specified within plan
#     filter
#       a function name (as a symol or as a character string) to process URL
#       before content extraction
#     max.path
#       integer value with maximally allowed character length for the paths of
#       the files to be downloaded (default is 230 characters)
#     trials
#       integer value specifying maximal number of tries if download fails (by
#       default a file is being attempted to download twice)
#     ...
#       additional arguments to be passed to filter
# Value
#   an integer vector containing indices of files that were failed to download.
#   Output value may be used to redownload failed files by means of substitution
#   it as recs argument
# Details
#   function outputs the status of each file into STDOUT. If download is failed
#   it puts corresponding warning message to STDERR.
#   The plan argument should refer to the structure (file/data.frame/matrix)
#   whose each row should be of the followng format:
#     <URL>;<semicolon separated parts of name>;<extention>
#   Each part of this structure (including those within <semicolon separated
#   parts of name>) should be enclosed into double quotes. Middle part (between
#   <URL> and <extention>) is concatenated with the use of delim and truncated
#   if resulting path is not fitted into max.path value.
#   recs argument, if it is specified as a function reference, is assumed to
#   take an integer vector as argument and return its appropriate subvector.
#   tail option supplements <semicolon supplemented parts of name> with an
#   auxiliary suffix. It may contain an integer placeholder for sprintf function
#   where current processing file number will be substituted. Alternatively, it
#   may be an empty string
# Examples
#   see ./awww.custom.R
# Author
#   Vladimir Simakov
# License
#   MIT License

# Copyright 2017 Vladimir Simakov
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.

library(curl)
library(XML)

awww <- function(ddir, plan, url.prefix, url.xquery,
                 recs = "force",
                 tail = " - (%d)",
                 delim = ", ",
                 filter = "force",
                 max.path = 230L,
                 trials = 2L,
                 ...) {
  
  invisible(
    forceAndCall(
      5L,
      as.function(
        alist(
          csv = ,
          mkdir = ,
          clock = ,
          notify = ,
          display = ,
          forceAndCall(
            6L,
            as.function(
              alist(
                self.numeric = ,
                self.default = ,
                self = ,
                hook.trials0 = ,
                hook.default = ,
                hook = ,
                forceAndCall(
                  4L,
                  as.function(
                    alist(
                      nrecs = ,
                      arecs = ,
                      fmtlen = ,
                      epoch = ,
                      action = ,
                      `[`(
                        arecs,
                        which(
                          `[[`(
                            Reduce(
                              as.function(
                                alist(
                                  stamp = ,
                                  k = ,
                                  display(
                                    k, nrecs, fmtlen, arecs, action,
                                    epoch, stamp, clock(),
                                    structure(
                                      NULL,
                                      class = paste0("trials", trials - 1L))))),
                              seq_len(nrecs),
                              list(epoch, logical())),
                            2L))))),
                  length(self(recs)),
                  self(recs),
                  1L + trunc(log10(length(self(recs)))),
                  clock(),
                  as.function(
                    alist(
                      k = ,
                      flag = ,
                      tryCatch(
                        forceAndCall(
                          1L,
                          as.function(
                            alist(
                              doc = ,
                              forceAndCall(
                                2L,
                                as.function(
                                  alist(
                                    job = ,
                                    dispose = ,
                                    job)),
                                forceAndCall(
                                  1L,
                                  as.function(
                                    alist(
                                      expr = ,
                                      FALSE)),
                                  curl_download(
                                    paste0(
                                      url.prefix,
                                      getNodeSet(doc, url.xquery)),
                                    forceAndCall(
                                      1L,
                                      as.function(
                                        alist(
                                          fn = ,
                                          file.path(
                                            fn$path,
                                            paste(
                                              gsub(
                                                "[<>:\"/\\|?*]", "_",
                                                paste0(
                                                  strtrim(
                                                    fn$root,
                                                    Reduce(
                                                      `-`,
                                                      c(
                                                        lapply(fn[-2L], nchar),
                                                        2L),
                                                      max.path)),
                                                  fn$tail)),
                                              fn$extn,
                                              sep = ".")))),
                                      forceAndCall(
                                        1L,
                                        as.function(
                                          alist(
                                            buf = ,
                                            structure(
                                              list(
                                                ddir,
                                                paste(
                                                  `[`(
                                                    csv, k,
                                                    `-`(c(1L, ncol(csv)))),
                                                  collapse = delim),
                                                sprintf(tail, k),
                                                `[`(csv, k, ncol(csv))),
                                              names = buf))),
                                        c("path", "root", "tail", "extn"))))),
                                free(doc)))),
                          htmlTreeParse(
                            do.call(
                              filter,
                              c(
                                list(csv[k, 1L]),
                                list(...))),
                            useInternalNodes = TRUE)),
                        error = hook(flag))))))),
            force,
            as.function(
              alist(
                foo = ,
                do.call(foo, list(seq_len(nrow(csv)))))),
            as.function(
              alist(
                foo = ,
                UseMethod("self"))),
            as.function(
              alist(
                foo = ,
                as.function(
                  alist(
                    e = ,
                    forceAndCall(
                      1L,
                      as.function(
                        alist(
                          warn = ,
                          TRUE)),
                      notify("Skipped")))))),
            as.function(
              alist(
                foo = ,
                as.function(
                  alist(
                    e = ,
                    forceAndCall(
                      1L,
                      as.function(
                        alist(
                          warn = ,
                          forceAndCall(
                            2L,
                            sys.function(-5L),
                            get("k", sys.frame(-5L)),
                            do.call(
                              structure,
                              structure(
                                list(
                                  NULL,
                                  paste0(
                                    "trials",
                                    `-`(
                                      as.integer(
                                        gsub(
                                          "trials", "",
                                          class(get("flag", sys.frame(-5L))))),
                                      1L))),
                                names = c("", "class")))))),
                      notify("Retried")))))),
            as.function(
              alist(
                foo = ,
                UseMethod("hook")))))),
      forceAndCall(
        3L,
        as.function(
          alist(
            extrude.data.frame = ,
            extrude.matrix = ,
            extrude.default = ,
            extrude = ,
            extrude(plan))),
        force,
        as.function(
          alist(
            foo = ,
            as.data.frame(foo, stringsAsFactors = FALSE))),
        as.function(
          alist(
            foo = ,
            read.csv2(
              foo, FALSE,
              stringsAsFactors = FALSE))),
        as.function(
          alist(
            foo = ,
            UseMethod("extrude")))),
      dir.create(ddir, FALSE),
      as.function(
        alist(
          as.integer(
            round(
              `[[`(
                proc.time(),
                "elapsed"))))),
      as.function(
        alist(
          activity = ,
          warning(
            sprintf(
              "Could not download file #%d. %s.",
              get("k", sys.frame(-5L)),
              activity),
            call. = FALSE))),
      as.function(
        alist(
          stage = ,
          total = ,
          fmtlen = ,
          indices = ,
          action = ,
          epoch = ,
          stamp = ,
          recent = ,
          ... = ,
          forceAndCall(
            2L,
            as.function(
              alist(
                msg = ,
                statstr = ,
                forceAndCall(
                  3L,
                  as.function(
                    alist(
                      intro = ,
                      compute = ,
                      refresh = ,
                      list(recent, c(stamp[[2L]], compute)))),
                  cat(msg),
                  forceAndCall(
                    3L,
                    as.function(
                      alist(
                        status = ,
                        dt = ,
                        Dt = ,
                        forceAndCall(
                          1L,
                          as.function(
                            alist(
                              foo = ,
                              status)),
                          cat(
                            paste0(
                              rep(".", 45L - nchar(msg)),
                              collapse = ""),
                            sprintf(
                              "%s (%02d:%02d:%02d/%02d:%02d:%02d)\n",
                              statstr[[status + 1L]],
                              dt %/% 3600L, (dt %/% 60L) %% 60L, dt %% 60L,
                              Dt %/% 3600L, (Dt %/% 60L) %% 60L, Dt %% 60L))))),
                    action(indices[[stage]], ...),
                    recent - stamp[[1L]],
                    recent - epoch),
                  flush.console()))),
            sprintf(
              "Retrieving file %0*d/%0*d ",
              fmtlen, stage, fmtlen, total),
            c("complete", "failed"))))))
}