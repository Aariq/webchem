#' Retrieve flavor percepts from www.flavornet.org
#'
#' Retreive flavor percepts from \url{http://www.flavornet.org}.  Flavornet is a database of 738 compounds with odors
#' perceptible to humans detected using gas chromatography ofactometry (GCO).
#'
#' @import xml2
#' @importFrom stats rgamma
#' @param query character; CAS number to search by. See \code{\link{is.cas}} for correct formatting
#' @param from character; currently only CAS numbers are accepted.
#' @param verbose logical; should a verbose output be printed on the console?
#' @param CAS deprecated
#' @param ... currently unused
#'
#' @return A named character vector containing flavor percepts or NA's in the case of CAS numbers that are not found
#'
#' @author Eric Scott, \email{eric.scott@@tufts.edu}
#'
#' @examples
#' \dontrun{
#' # might fail if website is not available
#' fn_percept("123-32-0")
#'
#' CASs <- c("75-07-0",  "64-17-5",  "109-66-0", "78-94-4",  "78-93-3")
#' fn_percept(CASs)
#' }
#' @export

fn_percept <- function(query, from = "cas", verbose = TRUE, CAS, ...)
{

  if (ping_service("fn") == FALSE) stop(webchem_message("service_down"))

  if (!missing(CAS)) {
    message('"CAS" is now deprecated. Please use "query" instead. ')
    query <- CAS
  }
  match.arg(from)
  foo <- function (query, verbose){
    if (is.na(query)) {
      if (verbose) webchem_message("na")
      return(NA)
    }
    qurl <- paste0("http://www.flavornet.org/info/",query,".html")
    if(verbose) webchem_message("query", query, appendLF = FALSE)
    Sys.sleep(stats::rgamma(1, shape = 10, scale = 1/10))
    res <- try(httr::RETRY("GET",
                           qurl,
                           httr::user_agent(webchem_url()),
                           terminate_on = 404,
                           quiet = TRUE), silent = TRUE)
    if (inherits(res, "try-error")) {
      if (verbose) webchem_message("service_down")
      return(NA)
    }
    if (verbose) message(httr::message_for_status(res))
    if (res$status_code == 200){
      h <- read_html(res)
      doc.text = xml_text(xml_find_all(h, "/html/body/p[3]"))
      pattern = "Percepts: "
      percept <- gsub(pattern, "", doc.text)
      return(percept)
    }
    else {
      return(NA)
    }
  }
  percepts <- sapply(query, foo, verbose = verbose)
  percepts <- setNames(percepts, query)
  return(percepts)
}
