#' Set default instance
#'
#' Set the current default LaminDB instance
#'
#' @param instance_slug The slug (`<owner>/<name>`) for the default instance
#'
#' @returns Sets the `LAMINR_DEFAULT_INSTANCE` option
#' @noRd
set_default_instance <- function(instance_slug) {
  current_default <- get_default_instance()

  if (
    !is.null(current_default) && !is.null(instance_slug) &&
      !identical(instance_slug, current_default)
  ) {
    cli::cli_warn(c(
      paste(
        "The default instance has changed",
        "({.field Old default:} {.val {current_default}},",
        "{.field New default:} {.val {instance_slug}})"
      ),
      "i" = "It is recommended to start a new R session"
    ))
  }

  options(LAMINR_DEFAULT_INSTANCE = instance_slug)
}

#' Get default instance
#'
#' Get the slug for the current default LaminDB instance
#'
#' @returns The value of the `LAMINR_DEFAULT_INSTANCE` option
#' @noRd
get_default_instance <- function() {
  getOption("LAMINR_DEFAULT_INSTANCE")
}

#' Get current LaminDB user
#'
#' Get the currently logged in LaminDB user
#'
#' @returns The handle of the current LaminDB user, or `NULL` invisibly if no
#'   user is found
#' @export
#'
#' @details
#' This is done via a system call to `lamin settings` to avoid importing Python
#' `lamindb`
get_current_lamin_user <- function() {
  require_lamindb()
  if (!reticulate::py_available()) {
    # Force reticulate to connect to Python
    py_config <- reticulate::py_config() # nolint object_usage_linter
  }

  settings <- system2("lamin", "settings", stdout = TRUE)

  is_handle <- grepl("handle:", settings)
  handle_setting <- settings[is_handle]

  if (length(handle_setting) == 0) {
    cli::cli_alert_danger("No current user")
    return(invisible(NULL))
  }

  handle <- rev(strsplit(handle_setting, " ")[[1]])[1]

  handle
}

#' Get current LaminDB instance
#'
#' Get the currently connected LaminDB instance
#'
#' @returns The slug of the current LaminDB instance, or `NULL` invisibly if no
#'   instance is found
#' @export
#'
#' @details
#' This is done via a system call to `lamin settings` to avoid importing Python
#' `lamindb`
get_current_lamin_instance <- function() {
  require_lamindb()
  if (!reticulate::py_available()) {
    # Force reticulate to connect to Python
    py_config <- reticulate::py_config() # nolint object_usage_linter
  }

  settings <- system2("lamin", "settings", stdout = TRUE)

  is_instance <- grepl("Current instance:", settings)
  instance_setting <- settings[is_instance]

  if (length(instance_setting) == 0) {
    cli::cli_alert_danger("No current instance")
    return(invisible(NULL))
  }

  instance <- rev(strsplit(instance_setting, " ")[[1]])[1]

  instance
}

#' Check if we are in a knitr notebook
#'
#' @return `TRUE` if we are in a knitr notebook, `FALSE` otherwise
#'
#' @noRd
is_knitr_notebook <- function() {
  # If knitr is not available, assume that we are not in a notebook
  if (!requireNamespace("knitr", quietly = TRUE)) {
    return(FALSE)
  }

  # Check if we are in a notebook
  !is.null(knitr::opts_knit$get("out.format"))
}

#' Check if we are in RStudio
#'
#' @return `TRUE` if we are in RStudio, `FALSE` otherwise
#'
#' @noRd
is_rstudio <- function() {
  requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()
}

#' Detect path
#'
#' Find the path of the file where code is currently been run
#'
#' @return If found, path to the file relative to the working directory,
#'   otherwise `NULL`
#' @noRd
detect_path <- function() {
  # Based on various responses from https://stackoverflow.com/questions/47044068/get-the-path-of-current-script

  current_path <- NULL

  # Get path if in a running RMarkdown notebook
  if (is_knitr_notebook()) {
    current_path <- knitr::current_input()
  }

  # Get path if in a script run by `source("script.R")`
  source_trace <- R.utils::findSourceTraceback()
  if (is.null(current_path) && length(source_trace) > 0) {
    current_path <- names(source_trace)[1]
  }

  # Get path if in a script run by `Rscript script.R`
  if (is.null(current_path)) {
    cmd_args <- R.utils::commandArgs(asValues = TRUE)
    current_path <- cmd_args[["file"]]
  }

  # Get path if in a document in RStudio
  if (is.null(current_path) && is_rstudio()) {
    doc_context <- rstudioapi::getActiveDocumentContext()
    if (doc_context$id != "#console") {
      current_path <- doc_context$path
    }
  }

  # Normalise the path relative to the working directory
  if (!is.null(current_path)) {
    current_path <- R.utils::getRelativePath(current_path)
  }

  current_path
}
