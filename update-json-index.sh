if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  echo -e "Starting to update json-index\n"
  df -h

  #go to home and setup git
  cd $HOME
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis"

  #using token clone json-index branch
  git clone --quiet --branch=json-index https://${GH_TOKEN}@github.com/iDigBio/idb-us-collections.git  json-index > /dev/null
  df -h

  #go into directory and create our index file
  cd json-index/collections
  sed -s '$a,' * > ../index.json
  sed -i '1i [' ../index.json
  sed -i '$a ]' ../index.json

  #add, commit and push files
  git add index.json
  git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to json-index"
  git push -fq origin json-index > /dev/null

  echo -e "Done magic with index\n"
fi
