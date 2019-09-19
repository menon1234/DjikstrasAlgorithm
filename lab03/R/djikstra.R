#' calculate the shortest path
#' @param graph a data.frame
#' @param init_node a number
#' @return the shortest path from the init_node to every other node
#' @export
#' @examples
#' wiki_graph <-
#'  data.frame(v1=c(1,1,1,2,2,2,3,3,3,3,4,4,4,5,5,6,6,6),
#'             v2=c(2,3,6,1,3,4,1,2,4,6,2,3,5,4,6,1,3,5),
#'            w=c(7,9,14,7,10,15,9,10,11,2,15,11,6,6,9,14,2,9))
#'
#' dijkstra(wiki_graph,1)
#' dijkstra(wiki_graph,3)
#' @seealso \url{https://en.wikipedia.org/wiki/Dijkstra\%27s_algorithm}
#' 


dijkstra <- function(graph, init_node)
  # first, find all nodes in the graph
  # vec_path_wei is used to store shortest weights from the init_node to each other nodes
  # idea: divide the whole graph into two graphs, one graph (named graph_1) only includes nodes with the same start node
  # the other graph (named graph_2) includes the remaind nodes
  # add a column in graph_1 with the sum of weight of end node (the third column) and the weight of the start node
  # compare the final weight of end node in graph_1 (column 4) with the weight of that corresponding node in vec_path_wei
  # replace the weight if the value of weight in vec_path_wei is 0 or larger than the weight in graph_1 column 4
  # repeat this process until the graph_2 is empty
  # finally, put 0 into the vec_path_wei where the init_node is.
  
{
  stopifnot(is.data.frame(graph) )
  stopifnot(is.numeric(init_node))
  stopifnot(names(graph)==c("v1","v2","w"))
  if(ncol(graph)!=3) stop("wrong graph!")
  
  
  vec_node <- 0
  j <- 1
  for (i in 1:nrow(graph))
  {
    if(!(graph[i, 1] %in% vec_node))
    {  vec_node[j] <- graph[i,1]
    j <- j+1
    }
  }
  stopifnot( init_node %in% vec_node )
  vec_path_wei <- vector(length = length(vec_node))
  
  start_node <- init_node
  graph_1 <- graph[graph[,1]==start_node, ]
  graph_2 <- graph[!graph[,1]==start_node,]
  node_num <- graph_1[,2]
  vec_path_wei[node_num] <- graph_1[,3]
  
  while (nrow(graph_2)!=0 ) {
    graph <- graph_2
    start_node <- graph[1,1]
    graph_1 <- graph[graph[,1]==start_node, ]
    graph_1 <- cbind(graph_1,w2=graph_1[,3]+vec_path_wei[start_node])
    graph_2 <- graph[!graph[,1]==start_node,]
    node_num_new <- graph_1[,2]
    for (i in node_num_new)
    {
      if(vec_path_wei[i]==0) {vec_path_wei[i]=graph_1[graph_1[,2]==i,4]}
      if(vec_path_wei[i]>graph_1[graph_1[,2]==i,4])  {vec_path_wei[i]=graph_1[graph_1[,2]==i,4]}
    }
  }
  
  vec_path_wei[init_node] <- 0
  return(vec_path_wei)
}
