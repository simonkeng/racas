% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/JSON_library.R
\name{flattenEntity}
\alias{flattenEntity}
\title{Flattens ACAS Entities}
\usage{
flattenEntity(entity, acasCategory = NULL, includeFromState = c("id",
  "lsType", "lsKind"), includeFromEntity = c("id"))
}
\arguments{
\item{entity}{an ACAS entity such as a protocol or subject}

\item{acasCategory}{one of the following: "protocol", "experiment", "analysisgroup", "treatmentgroup", "subject"}

\item{includeFromState}{a character vector of column names to include from the state}

\item{includeFromEntity}{a character vector of column names to include from the state

\code{flattenEntity} changes the json objects that were good for Java into an
R data frame. This can be used on any ACAS object that has lsStates that have
lsValues. If no information is needed from the state or entity,
\code{includeFromState} and \code{includeFromEntity}, respectively, can be
set to an empty list, \code{c()}. columns in \code{includeFromState} will
have "state" prepended and the first letter capitalized, while  columns in
\code{includeFromEntity} will have \code{acasCategory} prepended and the
first letter capitalized.}
}
\description{
Gets values from a given entity
}

