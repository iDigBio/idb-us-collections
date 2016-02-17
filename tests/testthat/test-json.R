## Test structure of collection JSON files
setwd("/home/travis/build/kevinlove/idb-us-collections/")
context("test attributes")
test_that("check JSON file attributes against stub", {
        stub <- jsonlite::fromJSON("stub.json")
        stubAttr <- attr(stub,"names")
        for (i in 1:length(list.files("collections/"))){
       
        colFile <- jsonlite::fromJSON(paste("collections/",list.files("collections/")[i],sep=""))
        colAttr <- attr(colFile,"names")
        expect_equal(length(colAttr), length(stubAttr),info =paste(list.files("collections/")[i],setdiff(colAttr,stubAttr),sep=","))
        
}
})        

test_that("check each collection file for valid JSON", {
        for (i in 1:length(list.files("collections/"))){

                expect_true(validate(toJSON(fromJSON(paste("collections/",list.files("collections/")[i],sep="")),auto_unbox = TRUE,pretty = TRUE)))
        }
})