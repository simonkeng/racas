% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/updateExperimentMetadata.R
\name{getAcasFileLink}
\alias{getAcasFileLink}
\title{Get url for ACAS file}
\usage{
getAcasFileLink(fileCode, login = FALSE)
}
\arguments{
\item{fileCode}{A file code of some custom type like \code{"FILE1234"} or a
path link like \code{"experiment/EXPT-3/this.txt"}}

\item{login}{boolean to decide if login is required to reach link. Paths for
  use by R should have this \code{FALSE}, but paths displayed to users should
  be \code{TRUE}.}
}
\value{
a url
}
\description{
Gets a url from an ACAS filecode. This deals with issues of whether the file
is stored internally or on an external file system, so you just get a link to
wherever the file is stored.
}
\details{
The getting equivalent of \code{\link{saveAcasFile}}. In
  updateExperimentMetadata.R
}

