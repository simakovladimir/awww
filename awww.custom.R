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

library(RCurl)

source("./acqhttp.kernel.R")

acqhttp.arxiv <- function(ddir, plan,
                          recs = "force",
                          max.path = 230L,
                          trials = 2L) {
  
  acqhttp(
    ddir,
    plan,
    "http://arxiv.org",
    paste0(
      "string(//body/div[@id = 'content']",
      "/div[@id = 'abs']/div/div/ul/li/a/@href)"),
    recs,
    "",
    " - ",
    "getURL",
    max.path,
    trials,
    .opts = list(useragent = paste0("curl/", curl_version()$version)))
}

acqhttp.mathnet <- function(ddir, plan,
                            recs = "force",
                            max.path = 230L,
                            trials = 2L) {
  
  acqhttp(
    ddir,
    plan,
    "http://www.mathnet.ru",
    paste0(
      "string(//body/table/tr/td/table[3]/tr/td[2]/",
      "a[substring(@href, 1, 16) = '/php/getFT.phtml']/@href)"),
    recs,
    "",
    " - ",
    "force",
    max.path,
    trials)
}

acqhttp.ufn <- function(ddir, plan,
                        recs = "force",
                        max.path = 230L,
                        trials = 2L) {
  
  acqhttp(
    ddir,
    plan,
    "",
    "string(//head/meta[@name = 'citation_pdf_url']/@content)",
    recs,
    "",
    " - ",
    "force",
    max.path,
    trials)
}