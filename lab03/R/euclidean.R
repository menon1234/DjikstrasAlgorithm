


#' Euclidean 
#'
#' @param a number
#' @param b number
#'
#' @return return GCD
#' @export
#'
#' @examples
#' euclidean(10,100)
euclidean<-function(a,b)
{
  while(a!=b)
  {
    if(a>b)
    {a=a-b}
    else
    {b=b-a}

  }
  return(a)
}
