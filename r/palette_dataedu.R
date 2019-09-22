# palette -----------------------------------------------------------------

dataedu_colors <- c(
    `darkblue`        = "#003f5c",
    `turquoise`      = "#006876",
    `green`       = "#00906b",
    `lightgreen`     = "#87af49",
    `yellow`     = "#ffbc49")

#' Function to extract dataedu colors as hex codes
#'
#' @param ... Character names of dataedu_colors 
#'
dataedu_cols <- function(...) {
    cols <- c(...)
    
    if (is.null(cols))
        return (dataedu_colors)
    
    dataedu_colors[cols]
}

dataedu_cols()

dataedu_palettes <- list(
    `short`  = dataedu_cols("green", "yellow"),
    `main` = dataedu_cols("darkblue", "turquoise", "green", "lightgreen", "yellow")
)

#' Return function to interpolate a dataedu color palette
#'
#' @param palette Character name of palette in dataedu_palettes
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments to pass to colorRampPalette()
#'
dataedu_pal <- function(palette = "main", reverse = FALSE, ...) {
    pal <- dataedu_palettes[[palette]]
    
    if (reverse) pal <- rev(pal)
    
    colorRampPalette(pal, ...)
}

#' Color scale constructor for dataedu colors
#'
#' @param palette Character name of palette in dataedu_palettes
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_color_gradientn(), used respectively when discrete is TRUE or FALSE
#'
scale_color_dataedu <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
    pal <- dataedu_pal(palette = palette, reverse = reverse)
    
    if (discrete) {
        discrete_scale("colour", paste0("dataedu_", palette), palette = pal, ...)
    } else {
        scale_color_gradientn(colours = pal(256), ...)
    }
}

#' Fill scale constructor for dataedu colors
#'
#' @param palette Character name of palette in dataedu_palettes
#' @param discrete Boolean indicating whether color aesthetic is discrete or not
#' @param reverse Boolean indicating whether the palette should be reversed
#' @param ... Additional arguments passed to discrete_scale() or
#'            scale_fill_gradientn(), used respectively when discrete is TRUE or FALSE
#'
scale_fill_dataedu <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
    pal <- dataedu_pal(palette = palette, reverse = reverse)
    
    if (discrete) {
        discrete_scale("fill", paste0("dataedu_", palette), palette = pal, ...)
    } else {
        scale_fill_gradientn(colours = pal(256), ...)
    }
}