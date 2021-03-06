% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/relative_association_functions.R
\name{simulate_sticky_association_network}
\alias{simulate_sticky_association_network}
\title{Simulate a sticky association network}
\usage{
simulate_sticky_association_network(
  n_variables = 50,
  n_clusters = 4,
  cluster_coherence = 2,
  stickiness_dist = function(n) {     stats::rbeta(n, shape1 = 1, shape2 = 4) },
  association_dist = function(n) {     stats::rbeta(n, shape1 = 0.5, shape2 = 10) }
)
}
\arguments{
\item{n_variables}{How many variables will be simulated}

\item{n_clusters}{Controls how many clusters are randomly assigned to nodes}

\item{cluster_coherence}{Scalar that multiplies random association value for
nodes in the same clusters. E.g. A value of \code{2} means variables in same
cluster have on average twice the association strength. Most likely above
1.}

\item{stickiness_dist}{Function that takes a single input: \code{n} that will then
generate \code{n} values from a distribution used to assign stickiness level for
each variable. These values will be scaled to an average of 1 so stickiness
doesn't change association distribution too much.}

\item{association_dist}{Function of same format as \code{stickiness_dist} that
instead is used to generate raw associations between pairs of nodes. The
values will then be scaled by \code{cluster_coherence} and each variable's
stickiness.}
}
\value{
List with \code{variables} with info about each variable (\code{id},
\code{stickiness} scalar, and \code{cluster} id) and \code{associations} which contains
the simulated associations in the format that works for all the functions
that take \code{association_pairs} as an input.
}
\description{
Used for testing properties of algorithms. Will create an association network
that is constructed where some nodes are more "sticky" than others. Or they
are in general more associated than others.
}
\examples{

# Simulate an association network with flat stickiness profile
simulate_sticky_association_network(
  n_variables = 10,
  n_clusters = 3,
  cluster_coherence = 2,
  stickiness_dist = function(n) {runif(n)},
  association_dist = function(n) {rbeta(n, shape1 = 1, shape2 = 10)}
)

}
