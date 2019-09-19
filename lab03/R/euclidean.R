#' calculate the greatest common divisor of two numbers
#' @param a a number
#' @param b a number
#' @return the greatest common divisor of two numbers
#' @export
#' @examples
#' euclidean(100,1000)
#' @seealso \url{https://en.wikipedia.org/wiki/Euclidean_algrithm}


euclidean <- function(a,b)
{
  if(!(is.numeric(a) & is.numeric(b))) stop("must input numbers!")
  while (b!=0)
  {
    t <- b
    b <- a %% b
    a <- t
  }
  return(abs(a))
}

