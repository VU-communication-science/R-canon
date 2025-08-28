
library(tidyverse)

rescale <- function(x, new_min = 1, new_max = 10) {
  (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE)) * (new_max - new_min) + new_min
}


sim_start <- function(n) {
    tidyr::tibble(.rows=n)
}



sim_normal <- function(d, name, mean, sd, exp=NULL, rescale=NULL, round=0) {
  exp = substitute(exp)
  if (is.null(exp)) {
    y = rnorm(nrow(d), mean = 0, sd = sd)
  } else {
    print(d)
    mu = eval(exp, envir=d)
    y = rnorm(nrow(d), mean = mu, sd = sd)
  }

  y = y - mean(y) + mean
  if (!is.null(rescale)) y = rescale(y, rescale[1], rescale[2])

  d[[name]] = y
  d
}

sim_binomial <- function(d, name, prob, exp=NULL) {
  exp = substitute(exp)
  if (is.null(exp)) {
    y = rbinom(nrow(d), 1, prob)
  } else {
    mu = prob * eval(exp, envir=d)
    mu = 1 / (1 + exp(eval(exp, envir=d)))
    y = rbinom(nrow(d), 1, prob)
  }
}

sim_start(100) |>
   sim_normal("age", mean=40, sd=30, rescale=c(18, 65), round=0)  |>
   sim_normal("trust_t1", mean=5, 1.5, exp=age*0.1) 


