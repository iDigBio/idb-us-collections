## Set up workspace
library(jsonlite);library(progress)
dir.create("collections",showWarnings = FALSE)

## Build data frame from iDigBio collections API
df <- fromJSON("http://internal.idigbio.org/collections")
## Write a CSV, cause why not?
##write.csv(df, file = "master.csv")

## Function to write JSON files for each item returned by the API
## df: Data frame built from iDigBio API using jsonlit::fromJSON method
## Per suggestions, file names will be strict UUID
writeCollections <- function(df = fromJSON("http://internal.idigbio.org/collections")){
        pb <- progress_bar$new(total=nrow(df))
 for (i in 1:nrow(df)){
        pb$tick() 
        fn <- df$collection_uuid[i]
        sink(paste("collections/",substr(fn,10,nchar(fn)),sep=""))
        row <- toJSON(unbox(df[i,]),pretty = TRUE, na = "string")
        cat(row)
        sink()
        
 }
}
##writeCollections()


## Function to compile collection JSON files into one validated file
writeMasterFile <- function(){
        pb <- progress_bar$new(total=length(list.files("collections/")))
        sink("collections.json")
        for (i in 1:length(list.files("collections/"))){
                pb$tick()
                if(i == 1){cat("[")}
                cat(toJSON(fromJSON(paste("collections/",list.files("collections/")[i],sep="")),auto_unbox = TRUE,pretty = TRUE))
                if(i < length(list.files("collections/"))){cat(",")}
                if(i == length(list.files("collections/"))){cat("]")}
         } 
        sink()
}
##writeMasterFile()

## Function to create stub collection files
## collection: Can be used to stub in a collection name

createCollStub <- function(collection=""){
        ##Create Stub dir
        dir.create("stubs",showWarnings = FALSE)
        ##Load stub JSON
        stub <- fromJSON("stub.json")
        ##Mint UUID
        colUUID <- uuid::UUIDgenerate()
        ##Set some values in stub
        stub$collection <- collection
        stub$collection_uuid <- paste("urn:uuid:",colUUID,sep="")
        ##Write file
        sink(paste("stubs/",colUUID,sep=""))
        cat(toJSON(stub,pretty = TRUE,auto_unbox = TRUE))
        sink()
        }
##createCollStub()
