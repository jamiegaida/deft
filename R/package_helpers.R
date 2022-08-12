#' Switch \code{.data$colname} to \code{.data[["col_name"]]}
#'
#' When creating a package the preferred extraction operator is
#' \code{.data[["col_name"]]}. What to do if you have the form
#' \code{.data$col_name} littered throughout your package? Can you be bothered
#' finding and correcting them all?
#'
#' This function will modify files in your package. It is strongly recommended
#' to save a copy of your files or use git before diving in and using this
#' function.
#'
#' @param files (character vector) Full path to the files to be changed
#'
#' @return Nothing, called for side effect
#' @export
#'
#' @examples \dontrun{
#' double_bracket_operator_for_dot_data(files = "./R/get_data.R")
#' }
double_bracket_for_dot_data <- function(files = list.files(
                                          path = ".",
                                          pattern = ".R$",
                                          recursive = TRUE,
                                          full.names = TRUE
                                        )) {
  purrr::walk(
    .x = files,
    .f = usethis::ui_info
  )

  if (usethis::ui_yeah("You're about to edit files \nDo you want to proceed?")) {
    files %>%
      purrr::map(.f = readLines) %>%
      purrr::map(
        .f = stringr::str_replace_all,
        pattern = "\\.data\\$(\\w+)\\b",
        replacement = "\\.data\\[\\[\"\\1\"\\]\\]"
      ) %>%
      purrr::walk2(
        .y = files,
        .f = writeLines
      )
  } else {
    usethis::ui_info("Exiting without making any changes")
  }
  return(invisible(NULL))
}
