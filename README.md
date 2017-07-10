[![Travis-CI Build Status](https://travis-ci.org/julian-urbano/ircor.svg?branch=master)](https://travis-ci.org/julian-urbano/ircor)
[![CRAN version](http://www.r-pkg.org/badges/version/ircor)](https://cran.r-project.org/package=ircor) 
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

# ircor

Provides implementation of various correlation coefficients of common use in Information Retrieval, such as Kendall and AP correlation coefficients, with and without ties.

For a full background please refer to *Julián Urbano and Mónica Marrero, "[The Treatment of Ties in AP Correlation](http://julian-urbano.info/publications/072-treatment-ties-AP-correlation.html)", ACM ICTIR, 2017*.

## Installation

You may install the stable release from CRAN

```{r}
install.packages("ircor")
```

or the latest development version from GitHub

``` r
devtools::install_github("julian-urbano/ircor")
```

## Usage

A full user manual in available in the [package vignette](https://cran.r-project.org/web/packages/ircor/vignettes/ircor.html).

## License

`ircor` is released under the terms of the [MIT License](https://opensource.org/licenses/MIT).
