% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/helpers.R
\name{join_pair_lists}
\alias{join_pair_lists}
\title{Join two association pairs lists by their ids}
\usage{
join_pair_lists(pairs_a, pairs_b)
}
\arguments{
\item{pairs_a, pairs_b}{association pairs list with columns \code{a} and \code{b}
encoding ids}
}
\value{
Joined version of the two association pairs with any missing pairs
from \code{pairs_b} set as \code{NA} for non-id columns.
}
\description{
Left join two pairs lists together.  Pairs not included in \code{pairs_b} will be
added as \code{NAs} to returned list and any pairs not in \code{pairs_a} will simply be
ignored.
}
