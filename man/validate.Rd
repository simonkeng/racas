\name{validateDate}
\alias{validate}
\alias{validateCharacter}
\alias{validateDate}
\title{Check that strings can be coerced to others}
\usage{
  validateDate(inputValue, expectedFormat = "\%Y-\%m-\%d",
    secondaryFormat = "\%m/\%d/\%Y", errorEnv = NULL)

  validateCharacter(inputValue, errorEnv = NULL)

  validateNumeric(inputValue, errorEnv = NULL)
}
\arguments{
  \item{expectedFormat}{a \link{format.POSIXct} that dates
  should be formatted as}

  \item{secondaryFormat}{a \link{format.POSIXct} that will
  not throw warnings, and is tested second}

  \item{inputValue}{value that should able to become the
  type, usually a string}

  \item{errorEnv}{environment where errorList is stored}
}
\value{
  \code{validateDate} a string date in the format
  expectedFormat

  \code{validateCharacter} a string

  \code{validateNumeric} a numeric
}
\description{
  Tests whether a string can be interpreted as given type
}
