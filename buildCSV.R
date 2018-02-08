library(jsonlite)
write.csv(fromJSON("collections.json"),file = "collections.csv",row.names = F)
