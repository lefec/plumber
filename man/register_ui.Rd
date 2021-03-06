% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ui.R
\name{register_ui}
\alias{register_ui}
\alias{registered_uis}
\title{Add UI for plumber to use}
\usage{
register_ui(name, index, static = NULL)

registered_uis()
}
\arguments{
\item{name}{Name of the UI}

\item{index}{A function that returns the HTML content of the landing page of the UI.
Parameters (besides \code{req} and \code{res}) will be supplied as if it is a regular \code{GET} route.
Default parameter values may be used when setting the ui.
Be sure to see the example below.}

\item{static}{A function that returns the path to the static assets (images, javascript, css, fonts) the UI will use.}
}
\description{
\code{\link[=register_ui]{register_ui()}} is used by other packages like \code{swagger}.
When you load these packages, it calls \code{\link[=register_ui]{register_ui()}} to provide a user
interface that can interpret your plumber OpenAPI Specifications.
}
\examples{
\dontrun{
# Example from the `swagger` R package
register_ui(
  name = "swagger",
  index = function(version = "3", ...) {
    swagger::swagger_spec(
      api_path = paste0(
        "window.location.origin + ",
        "window.location.pathname.replace(",
          "/\\\\(__swagger__\\\\\\\\/|__swagger__\\\\\\\\/index.html\\\\)$/, \"\"",
        ") + ",
        "\"openapi.json\""
      ),
      version = version
    )
  },
  static = function(version = "3", ...) {
    swagger::swagger_path(version)
  }
)

# When setting the UI, `index` and `static` function arguments can be supplied
# * via `pr_set_ui()`
# * or through URL query string variables
pr() \%>\%
  # Set default argument `version = 3` for the swagger `index` and `static` functions
  pr_set_ui("swagger", version = 3) \%>\%
  pr_get("/plus/<a:int>/<b:int>", function(a, b) { a + b }) \%>\%
  pr_run()
}
}
