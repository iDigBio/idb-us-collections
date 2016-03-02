## collections.R

writeMasterFile <- function() {
  sink("data-raw/collections.json")
  for (i in 1:length(list.files("data-raw/collections/"))) {
    if (i == 1) {
      cat("[")
    }
    cat(jsonlite::toJSON(
      jsonlite::fromJSON(paste(
        "data-raw/collections/",list.files("data-raw/collections/")[i],sep = ""
      )),auto_unbox = TRUE,pretty = TRUE
    ))
    if (i < length(list.files("data-raw/collections/"))) {
      cat(",")
    }
    if (i == length(list.files("data-raw/collections/"))) {
      cat("]")
    }
  }
  sink()
}
writeMasterFile()
collections <- jsonlite::fromJSON("data-raw/collections.json")
save(collections, file = "data/collections.rda")