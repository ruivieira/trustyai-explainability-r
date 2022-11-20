[![R-CMD-check](https://github.com/ruivieira/trustyai-explainability-r/actions/workflows/checks.yaml/badge.svg)](https://github.com/ruivieira/trustyai-explainability-r/actions/workflows/checks.yaml)

# trustyai-explainability-r

## Setup

### Java library

The [Java library](java/trustyai-explainability-r) must be built using:

```shell
$ cd java/trustyai-explainability-r
$ mvn clean install -Pshaded
```

Note that you must also have the [main TrustyAI library](https://github.com/trustyai-explainability/trustyai-explainability) locally.

### R library

Build the R library using

```shell
$ cd trustyai
$ R CMD INSTALL --preclean --no-multiarch --with-keep.source trustyai
```

If successful, you can now import it using

```r
library(trustyai)
```

## Examples

Examples can be found in [this directory](trustyai/examples).