## Test structure of collection JSON files
setwd("/home/travis/build/iDigBio/idb-us-collections/")
context("test attributes")

test_that("check JSON file attributes against stub", {
    stub <- jsonlite::fromJSON("stub.json")
    stubAttr <- attr(stub, "names")
    
    for (i in 1:length(list.files("collections/"))) {
        
        thisFile = list.files("collections/")[i]
        
        colFile <- jsonlite::fromJSON(paste("collections/", thisFile, sep = ""))
        colAttr <- attr(colFile, "names")
        
        diffForFailureMessage = paste(
            thisFile,
            setdiff(colAttr, stubAttr),
            sep = ","
        )
        
        expect_equal(length(colAttr),
                     length(stubAttr),
                     info = diffForFailureMessage
        )
    }
})
test_that("check each collection file for valid JSON", {
    for (i in 1:length(list.files("collections/"))) {
        
        thisFile = list.files("collections/")[i]
        
        r_object = paste("collections/", thisFile, sep = "")
        reparsed = jsonlite::toJSON(
            jsonlite::fromJSON(r_object),
            auto_unbox = TRUE,
            pretty = TRUE
        )
        
        expect_true(jsonlite::validate(reparsed))
    }
})

test_that("check for duplicate collection ID's", {
    expect_true(anyDuplicated(list.files("collections/")) == 0)
})