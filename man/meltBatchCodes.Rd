% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/longFormatSave.R
\name{meltBatchCodes}
\alias{meltBatchCodes}
\title{Turns a batchCode column into rows in a long format}
\usage{
meltBatchCodes(entityData, batchCodeStateIndices,
  replacedFakeBatchCode = NULL, optionalColumns = c("treatmentGroupID",
  "analysisGroupID", "stateVersion"))
}
\arguments{
\item{entityData}{a data frame with data}

\item{batchCodeStateIndices}{a numeric vector of indices in the stateGroupIndexColumn which should have batchCodes melted}

\item{replacedFakeBatchCode}{deprecated: a character vector of fake batch id's that were replaced, marking invalid batch codes}

\item{optionalColumns}{Columns to include in output (if available). Often the entityID is needed for saving later}
}
\value{
A data frame with rows for all code values
}
\description{
Turns a batchCode column into rows in a long format
}
\details{
Does not work with data.table.
entityData must have columns "batchCode", "stateID", "stateGroupIndex".
If "batchCode" is missing, will return an empty data.frame.
publicData is always set to TRUE.
In longFormatSave.R
}

