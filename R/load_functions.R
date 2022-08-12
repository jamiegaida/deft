#' Load all function definitions without creating a project
#'
#' \code{devtools::load_all()} only works inside a package. \code{source()} does
#' the job so long as your source file only includes function definition. This
#' filters out anything that doesn't match the pattern \code{name <- function()}
#'
#' @param files (character vector) Files from which to load function definitions
#' @param clean_up (boolean; default = TRUE) Should global function definitions
#'   be removed before loading?
#' @return Nothing, called for side effect
#' @export
#'
#' @examples \dontrun{
#' load_functions()
#' }
load_functions <- function(files = list.files(
                             path = "R",
                             pattern = "\\.R$",
                             full.names = TRUE,
                             recursive = TRUE
                           ),
                           clean_up = TRUE) {

  # clean up functions defined in global scope
  if (clean_up) {
    rm(
      list = utils::ls.str(
        mode = "function",
        envir = sys.frame(which = 0)
      ),
      envir = sys.frame(which = 0)
    )
  }

  # parse, filter, eval
  files %>%
    purrr::map(parse) %>%
    purrr::map(
      purrr::keep,
      function(x) !is.null(x)
    ) %>%
    purrr::map(
      purrr::keep,
      function(x) x[[1]] == "<-" && x[[3]][[1]] == "function"
    ) %>%
    purrr::walk(eval,
      envir = sys.frame(which = 0)
    )

  return(invisible(NULL))
}
