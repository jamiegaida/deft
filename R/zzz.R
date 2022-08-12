.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    praise::praise(
      "${Exclamation}! This ${rpackage} `deft` is ${adjective}!"
    )
  )
}
