% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/nist.R
\name{nist_ri}
\alias{nist_ri}
\title{Retrieve retention indices from NIST}
\usage{
nist_ri(
  query,
  from = c("cas", "inchi", "inchikey", "name"),
  type = c("kovats", "linear", "alkane", "lee"),
  polarity = c("polar", "non-polar"),
  temp_prog = c("isothermal", "ramp", "custom"),
  cas = NULL,
  verbose = TRUE
)
}
\arguments{
\item{query}{character; the search term}

\item{from}{character; type of search term. can be one of \code{"name"},
\code{"inchi"}, \code{"inchikey"}, or \code{"cas"}. Using an identifier is
preferred to \code{"name"} since \code{NA} is returned in the event of
multiple matches to a query. Using an identifier other than a CAS number
will cause this function to run slower as CAS numbers are used as internal
identifiers by NIST.}

\item{type}{Retention index type. One of \code{"kovats"}, \code{"linear"},
\code{"alkane"}, or \code{"lee"}. See details for more.}

\item{polarity}{Column polarity. One of \code{"polar"} or \code{"non-polar"}
to get RIs calculated for polar or non-polar columns.}

\item{temp_prog}{Temperature program. One of \code{"isothermal"},
\code{"ramp"}, or \code{"custom"}.}

\item{cas}{deprecated.  Use \code{query} instead.}

\item{verbose}{logical; should a verbose output be printed on the console?}
}
\value{
returns a tibble of literature RIs with the following columns:
\itemize{
\item{\code{CAS} is the CAS number}
\item{\code{type} is the column type, e.g. "capillary"}
\item{\code{phase} is the stationary phase (column phase)}
\item{\code{RI} is retention index}
\item{\code{length} is column length in meters}
\item{\code{gas} is the carrier gas used}
\item{\code{substrate}}
\item{\code{diameter} is the column diameter in mm}
\item{\code{thickness} is the phase thickness in µm}
\item{\code{program}. various columns depending on the value of
\code{temp_prog}}
\item{\code{reference} is where this retention index was published}
\item{\code{comment}. I believe this denotes the database these data
      were aggregated from}
}
}
\description{
This function scrapes NIST for literature retention indices
  given CAS numbers as an input.
}
\details{
The types of retention indices included in NIST include Kovats
  (\code{"kovats"}), Van den Dool and Kratz (\code{"linear"}), normal alkane
  (\code{"alkane"}), and Lee (\code{"lee"}). Details about how these are
  calculated are available on the NIST website:
  \url{https://webbook.nist.gov/chemistry/gc-ri/}
}
\note{
Copyright for NIST Standard Reference Data is governed by the Standard
Reference Data Act, \url{https://www.nist.gov/srd/public-law}.
}
\examples{
\dontrun{
myRIs <- nist_ri(c("78-70-6", "13474-59-4"), from = "cas", "linear",
"non-polar", "ramp")
}
}
\seealso{
\code{\link{is.cas}} \code{\link{as.cas}}
}
