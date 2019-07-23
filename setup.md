# Setup for installing and then running tests (WIP)

Note for commands below: 

* `$` denotes bash prompt
* `r>` is the r prompt

## Install r packages

You'll need some r packages installed.  Below is a partial list.  Some of these need to be compiled but the system will do it automatically.

```
install.packages("testthat", "progress", "jsonlite", "devtools")
```

## Temporary workaround for paths
update the cwd line in `./tests/testthat/test_json.R` to your system's cwd. (todo: improve this)

## build, check, and test

Build the package used for testing:

```
$ R CMD build .
* checking for file ‘./DESCRIPTION’ ... OK
* preparing ‘idbCollections’:
* checking DESCRIPTION meta-information ... OK
* checking for LF line-endings in source and make files and shell scripts
* checking for empty or unneeded directories
* creating default NAMESPACE file
* building ‘idbCollections_0.0.1.tar.gz’
```

run a check.  Technically, the command can be done through R CMD but it's better to run it through devtools because it does some extra cleanup:

```
devtools::check()
```

Now run tests.  If you're familiar with testthat, don't try to run `test_dir()` or `test_file()`, it won't find the package.

```
r> devtools::test()
```

ideally, you'll see something similar to the following, where n = our number of collections, including the one just added:

```
Loading idbCollections
Testing idbCollections
✔ |  OK F W S | Context
✔ |  n        | test attributes [27.0 s]

══ Results ═════════════════════
Duration: 27.0 s

OK:       n
Failed:   0
Warnings: 0
Skipped:  0
```

Note that `update-json-index.sh` cannot yet be run locally, so this is the end of the local process for now.