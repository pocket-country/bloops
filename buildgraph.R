#library(readr)
#library(igraph)
# read vertices - bloops themselves (note attributes at time Tick in a differet file)
geneverts <- read_csv("geneverts.csv", col_types = cols(Born = col_integer(), 
                                                        Died = col_integer()))
# read edges - bloop parent child relationships
geneedges <- read_csv("geneedges.csv")
# make into an igraph graph data object
b_geno <- graph.data.frame(geneedges,directed=TRUE,vertices=geneverts)
plot(b_geno, layout=layout.reingold.tilford)