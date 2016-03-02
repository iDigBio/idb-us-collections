##' Function to write JSON files for each item returned by the API
##' df: Data frame built from iDigBio API using jsonlite::fromJSON method
##' Per suggestions, file names will be strict UUID
##' @return a directory named "collections" that contains a json file
##' for every collection object returned by the API
writeCollections <-
  function(df = jsonlite::fromJSON("http://internal.idigbio.org/collections")) {
    df <- jsonlite::fromJSON("http://internal.idigbio.org/collections")
    dir.create("collections",showWarnings = FALSE)
    for (i in 1:nrow(df)) {
      fn <- df$collection_uuid[i]
      sink(paste("collections/",substr(fn,10,nchar(fn)),sep = ""))
      row <-
        jsonlite::toJSON(unbox(df[i,]),pretty = TRUE, na = "string")
      cat(row)
      sink()
      
    }
  }


##' Function to compile collection JSON files into one validated file
##' @param api Default is FALSE and the Master file will be created from data in the 
##' package data directory. TRUE will build the master file from the API 
##' @return JSON formated file named "collections.json"
writeMasterFile <- function(api = FALSE) {
  if (api == TRUE) {
    sink("collections.json")
    for (i in 1:length(list.files("collections/"))) {
      if (i == 1) {
        cat("[")
      }
      cat(jsonlite::toJSON(
        jsonlite::fromJSON(paste(
          "collections/",list.files("collections/")[i],sep = ""
        )),auto_unbox = TRUE,pretty = TRUE
      ))
      if (i < length(list.files("collections/"))) {
        cat(",")
      }
      if (i == length(list.files("collections/"))) {
        cat("]")
      }
    }
    sink()
    
  }else{
    sink("collections.json")
    for (i in 1:length(list.files("data/collections/"))) {
      if (i == 1) {
        cat("[")
      }
      cat(jsonlite::toJSON(
        jsonlite::fromJSON(paste(
          "data/collections/",list.files("data/collections/")[i],sep = ""
        )),auto_unbox = TRUE,pretty = TRUE
      ))
      if (i < length(list.files("data/collections/"))) {
        cat(",")
      }
      if (i == length(list.files("data/collections/"))) {
        cat("]")
      }
    }
    sink()
  }
}


##' Function to create stub collection files
##' @param collection: Can be used to stub in a collection name
##' @return directory called 'stubs' that contains stub json files

createCollStub <- function(collection = "") {
  ##Create Stub dir
  dir.create("stubs",showWarnings = FALSE)
  ##Load stub JSON
  stub <- jsonlite::fromJSON("stub.json")
  ##Mint UUID
  colUUID <- uuid::UUIDgenerate()
  ##Set some values in stub
  stub$collection <- collection
  stub$collection_uuid <- paste("urn:uuid:",colUUID,sep = "")
  ##Write file
  sink(paste("stubs/",colUUID,sep = ""))
  cat(jsonlite::toJSON(stub,pretty = TRUE,auto_unbox = TRUE))
  sink()
}

