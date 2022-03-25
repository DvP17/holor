#' Preview quilts
#'
#' \code{preview_quilt} creates a GIF preview of a quilt image.
#'
#' @importFrom magick image_read image_scale image_crop image_animate
#'
#' @param file File name of the quilt image.
#' @param width Width of the GIF. Default is 1200.
#' @param fps Frames per second. Default is 20.
#' @param save If GIF should be saved. Default is FALSE.
#'
#' @export
preview_quilt <- function(file, width = 1200, fps = 20, save = FALSE) {
  # Declare width and height of separate images
  str <- width/8
  end <- width/6

  # Read original image and rescale
  or <- image_read(file)
  or <- image_scale(or, geometry = as.character(width))

  # Crop single images and create series
  for (i in 1:6) {
    for (j in 1:8) {
      if (exists("img") == FALSE) {
        img <- image_crop(or, paste0(str, "x", end, "+", j*str-str, "+", width-i*end))
      } else {
        img <- append(img, image_crop(or, paste0(str, "x", end, "+", j*str-str, "+", width-i*end)))
      }
    }
  }

  # Crop single images and create series in reverse
  for (i in 6:1) {
    for (j in 8:1) {
      img <- append(img, image_crop(or, paste0(str, "x", end, "+", j*str-str, "+", width-i*end)))
    }
  }

  # Render Animation
  animation <- image_animate(img, fps = fps)

  # Save Animation
  if (save == TRUE) {
    image_write(animation, sub("\\..*", "-preview.gif", file))
  }

  # Print Animation
  print(animation)
}

