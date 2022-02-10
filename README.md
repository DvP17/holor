![GitHub](https://img.shields.io/github/r-package/v/DvP17/holor) ![GitHub](https://img.shields.io/github/license/DvP17/holor)

# holor Package

A package that creates quilts for holographic images on the Looking Glass Device.

## Dependencies

As of right now `holor` supports the following functions:

`plot3D::scatter3D()`
`plot3D::hist3D()`


## Install

```{r}
devtools::install_github("DvP17/holor")
```

## Create a quilt

```{r}
library(holor)
quilt(plot3D::scatter3D(x = iris$Sepal.Length,
                        y = iris$Petal.Length,
                        z = iris$Sepal.Width),
      cone = 10, theta = 0, phi = 0, device = "LGP", file = "myquilt.png")
```

The `device` argument corresponds to the device you are using to display the hologram. The file name is automatically changed to include information on the parameters needed for HoloPlayStudio.

Now you can export the quilt to HoloPlayStudio with drag & drop.


