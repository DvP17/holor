#' Render quilts
#'
#' \code{quilt} renders quilt images for the Looking Glass holographic display.
#'
#' @param fun The plot function. Currently supported for \code{plot3D::scatter3D} and \code{plot3D::hist3D}.
#' @param cone The viewing cone.
#' @param theta The theta parameter.
#' @param phi The phi parameter.
#' @param device The Looking Glass Device.
#'
#' @export
quilt <- function(fun, cone = 10, theta = 0, phi = 0, device = "LGP", file) {

  # Set perspectives
  str <- theta - cone / 2
  end <- theta + cone / 2
  fov <- seq(str, end, (abs(str) + abs (end)) / (48-1)) # 48 is number of frames

  # Set number of quilts
  nrw <- 6 #row
  ncl <- 8 #col
  ord <- as.vector(sapply(rev(1:nrw*ncl - (ncl-1)), function(i) i:(i+(ncl-1))))

  # LGP resolution
  wid <- 1536*ncl
  hei <- 2048*nrw

  # Image naming
  loc <- gsub("(\\.)([A-z]+)$", paste0("_qs", ncl, "x", nrw, "\\1\\2"), file)

  # Call function
  f_nam <- deparse(substitute(fun)[[1]]) # deparse for check
  args <- substitute(fun)
  args[[1]] <- NULL # delete first element (fun name)

  # Render image
  png(loc, width = wid, height = hei)
  par(mfrow = c(nrw, ncl))
  if (grepl("scatter3D", f_nam)) {
    require("plot3D")
    for (i in fov[ord]) {
      do.call("scatter3D", c(args, list(theta = i, phi = phi, cex=20, pch=20)))
    }
  } else if (grepl("hist3D", f_nam)) {
    require("plot3D")
    for (i in fov[ord]) {
      do.call("hist3D", c(args, list(theta = i, phi = phi, cex=20, pch=20)))
    }
  } else if (grepl("persp3D", f_nam)) {
    require("plot3D")
    for (i in fov[ord]) {
      do.call("persp3D", c(args, list(theta = i, phi = phi, cex=20, pch=20)))
    }
  } else {
    warning("Please enter a supported plot function.")
  }
  dev.off()
}

