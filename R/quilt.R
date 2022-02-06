#' Create a quilt image
#'
#' @param cone The viewing cone
#' @param theta Is theta
#' @param phi Is phi
#' @param device Is Looking Glass Device
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

  # Create image
  loc <- gsub("(\\.)([A-z]+)$", paste0("_qs", ncl, "x", nrw, "\\1\\2"), file)
  png(loc, width = wid, height = hei)
  par(mfrow = c(nrw, ncl))
  for (i in fov[ord]) {
    plot3D::scatter3D(x, y, z, theta = i, phi = phi, cex=20, pch=20)
  }
  dev.off()

}


# Testing

# volc <- reshape2::melt(volcano)
# with(volc, plot3D::scatter3D(x = Var1, y = Var2, z = value, ticktype="detailed", pch=16,
#                      xlab="longitude", ylab="latitude", zlab="depth, km", main=""))

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
  if (grepl("scatter3D", f_nam)) {
    require("plot3D")
    png(loc, width = wid, height = hei)
    par(mfrow = c(nrw, ncl))
    for (i in fov[ord]) {
      do.call("scatter3D", c(arg, list(theta = i, phi = phi, cex=20, pch=20)))
    }
    dev.off()
  }
}
