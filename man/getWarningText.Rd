% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/errorLogging.R
\name{getWarningText}
\alias{getWarningText}
\title{Get warning text for users}
\usage{
getWarningText(warningList)
}
\arguments{
\item{errorList}{a list of items of class "warning"}
}
\description{
From a list of warning objects, get warning messages for users, prefixing
internal errors with a message.
}
\details{
Warning messages with class \code{\link{userWarning}} pass just
  their message, future plans to group warnings by class if there are very
  large numbers.
}

