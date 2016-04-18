  echo -e "Starting to update json-index\n"

  #go to home and setup git
  cd $HOME
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis"

  #using token clone json-index branch
  git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/iDigBio/idb-us-collections.git  gh-pages > /dev/null
  df -h

  #go into directory and create our index file
  cd gh-pages/collections
  sed -s '$a,' * > ../index.json
  sed -i '$ d' ../index.json
  sed -i '1i [' ../index.json
  sed -i '$a ]' ../index.json

  #add, commit and push files
  git add -f .
  git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to gh-pages"
  git push -fq origin gh-pages > /dev/null

  echo -e "Done magic with GitHub pages\n"
