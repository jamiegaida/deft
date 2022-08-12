#' Set standard RStudio preferences
#'
#' A very opinionated set of RStudio settings
#'
#' @param show_invisibles (Boolean; default = TRUE) Ok, not everyone wants to
#'   see invisible characters. Change it to your preference
#'
#' @return Nothing, called for side effect
#' @export
#'
#' @examples \dontrun{
#' set_rstudio_defaults()
#' }
set_rstudio_preferences <- function(show_invisibles = TRUE) {
  rstudio.prefs::use_rstudio_prefs(
    always_save_history = FALSE,
    auto_append_newline = TRUE,
    default_project_location = "~/git",
    editor_theme = "Tomorrow Night 80s",
    graphics_antialiasing = "subpixel",
    graphics_backend = "cairo",
    highlight_r_function_calls = TRUE,
    initial_working_directory = "~",
    jobs_tab_visibility = "shown",
    load_workspace = FALSE,
    rmd_chunk_output_inline = FALSE,
    rmd_viewer_type = "pane",
    save_files_before_build = TRUE,
    save_workspace = "never",
    spelling_dictionary_language = "en_AU",
    scroll_past_end_of_document = TRUE,
    show_invisibles = show_invisibles,
    strip_trailing_whitespace = TRUE,
    syntax_color_console = TRUE,
    windows_terminal_shell = "win-git-bash"
  )

  # Can't specify font
  usethis::ui_line(glue::glue(
    "Recommend setting editor font to ",
    "{usethis::ui_field('Consolas')}, ",
    "must be done manually."
  ))
  usethis::ui_line("Tools > Global Options > Appearance > Editor Font")
}
