#' Create a quilt image
#'
#' @param cone The viewing cone
#' @param theta Is theta
#' @param phi Is phi
#' @param device Is Looking Glass Device
quilt <- function(cone = 10, theta = 0, phi = 0, device = "LGP", file) {

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

  # Create image
  loc <- gsub("(\\.)([A-z]+)$", paste0("_qs", ncl, "x", nrw, "\\1\\2"), file)
  png(loc, width = wid, height = hei)
  par(mfrow = c(nrw, ncl))
  for (i in fov[ord]) {
    plot3D::scatter3D(x, y, z, theta = i, phi = phi, cex=20, pch=20)
  }
  dev.off()

}
