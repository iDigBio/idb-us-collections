if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
  echo -e "Starting to update json-index\n"

  #copy data we're interested in to other place
  cp -R collections/ $HOME/collections

  #go to home and setup git
  cd $HOME
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis"

  #using token clone json-index branch
  git clone --quiet --branch=json-index https://${GH_TOKEN}@github.com/iDigBio/idb-us-collections.git  json-index > /dev/null

  #go into directory and copy data we're interested in to that directory
  cd collections
  sed -s '$a------' * | sed '$d' > index.json
  sed -i '1i [' index.json
  sed -i '$a ]' index.json

  #add, commit and push files
  git add -f .
  git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to json-index"
  git push -fq origin json-index > /dev/null

  echo -e "Done magic with index\n"
fi
