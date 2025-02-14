% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bnecfit-methods.R
\name{update.bnecfit}
\alias{update.bnecfit}
\title{Update an object of class \code{\link{bnecfit}} as fitted by function
\code{\link{bnec}}.}
\usage{
\method{update}{bnecfit}(
  object,
  newdata = NULL,
  recompile = NULL,
  x_range = NA,
  precision = 1000,
  sig_val = 0.01,
  loo_controls,
  force_fit = FALSE,
  ...
)
}
\arguments{
\item{object}{An object of class \code{\link{bnecfit}} as fitted by function
\code{\link{bnec}}.}

\item{newdata}{Optional \code{\link[base]{data.frame}} to update the model
with new data. Data-dependent default priors will not be updated
automatically.}

\item{recompile}{A \code{\link[base]{logical}}, indicating whether the Stan
model should be recompiled. If \code{NULL} (the default), \code{update}
tries to figure out internally, if recompilation is necessary. Setting it to
\code{FALSE} will cause all Stan code changing arguments to be ignored.}

\item{x_range}{A range of predictor values over which to consider extracting
ECx.}

\item{precision}{The length of the predictor vector used for posterior
predictions, and over which to extract ECx values. Large values will be
slower but more precise.}

\item{sig_val}{Probability value to use as the lower quantile to test
significance of the predicted posterior values against the lowest observed
concentration (assumed to be the control), to estimate NEC as an
interpolated NOEC value from smooth ECx curves.}

\item{loo_controls}{A named \code{\link[base]{list}} of two elements
("fitting" and/or "weights"), each being a named \code{\link[base]{list}}
containing the desired arguments to be passed on to \code{\link[brms]{loo}}
(via "fitting") or to \code{\link[loo]{loo_model_weights}} (via "weights").
If "fitting" is provided with argument \code{pointwise = TRUE}
(due to memory issues) and \code{family = "beta_binomial2"}, the
\code{\link{bnec}} will fail because that is a custom family. If "weights" is
not provided by the user, \code{\link{bnec}} will set the default
\code{method} argument in \code{\link[loo]{loo_model_weights}} to
"pseudobma". See ?\code{\link[loo]{loo_model_weights}} for further info.}

\item{force_fit}{Should model truly be updated in case either
\code{newdata} of a new family is provided?}

\item{...}{Further arguments to \code{\link[brms]{brm}}.}
}
\value{
An object of class \code{\link{bnecfit}}. If one single model is
returned, then also an object of class \code{\link{bayesnecfit}}; otherwise,
if multiple models are returned, also an object of class
\code{\link{bayesmanecfit}}.
}
\description{
Update an object of class \code{\link{bnecfit}} as fitted by function
\code{\link{bnec}}.
}
\examples{
\donttest{
library(bayesnec)
data(manec_example)
# due to package size issues, `manec_example` does not contain original
# stanfit DSO, so need to recompile here
smaller_manec <- update(manec_example, chains = 1, iter = 50,
                        recompile = TRUE)
# original `manec_example` is fit with a Gaussian
# change to Beta distribution by adding newdata with original `nec_data$y`
# function will throw informative message.
beta_manec <- update(manec_example, newdata = nec_data, recompile = TRUE,
                     chains = 1, iter = 50, family = Beta(link = "identity"),
                     force_fit = TRUE)
}

}
