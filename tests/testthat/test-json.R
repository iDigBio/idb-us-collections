## Test structure of collection JSON files
setwd("/home/travis/build/iDigBio/idb-us-collections/data/")
context("test attributes")
test_that("check JSON file attributes against stub", {
        stub <- jsonlite::fromJSON("../stub.json")
        stubAttr <- attr(stub,"names")
        for (i in 1:length(list.files("collections/"))){
       
        colFile <- jsonlite::fromJSON(paste("collections/",list.files("collections/")[i],sep=""))
        colAttr <- attr(colFile,"names")
        expect_equal(length(colAttr), length(stubAttr),info =paste(list.files("collections/")[i],setdiff(colAttr,stubAttr),sep=","))
        
}
})        

test_that("check each collection file for valid JSON", {
        for (i in 1:length(list.files("collections/"))){

                expect_true(jsonlite::validate(jsonlite::toJSON(jsonlite::fromJSON(paste("collections/",list.files("collections/")[i],sep="")),auto_unbox = TRUE,pretty = TRUE)))
        }
})

test_that("check for duplicate collection ID's", {
    expect_true(anyDuplicated(list.files("collections/")) == 0)
})