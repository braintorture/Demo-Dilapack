# Demo-Dilapack
The Dilapack package provides easy-to-use functions for basic statistical calculations. `mean_calc` computes the arithmetic mean of a numeric vector, while `median_calc` determines the median, providing essential tools for quick and accurate statistical analysis.
# Instalation
You can install the development version of regexcite from GitHub with:
``` r
#install.packages("remotes")
remotes::install_github("braintorture/Demo-Dilapack")
```

## Usage

```{r setup}
library(DilaPack)
hello()
mean_calc(c(1,2,3,4,5))
median_calc(c(1,2,3,4,5))
```

```{r setup}
> library(DilaPack)
> hello()
[1] "Hello, world!"
> mean_calc(c(1,2,3,4,5))
[1] 3
> median_calc(c(1,2,3,4,5))
[1] 3
>
```
