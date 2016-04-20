  echo -e "Starting to update json-index\n"
  
  #copy new files
  echo -e "Copy new files"
  cp -R collections $HOME/collections
  

  #go to home and setup git
  cd $HOME
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis"

  #using token clone json-index branch
  git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/iDigBio/idb-us-collections.git  gh-pages > /dev/null
  echo -e "Clone repo"
 
  #go into directory and create our index file
  cd gh-pages/collections
  cp -R $HOME/collections/* .
  sed -s '$a,' * > ../collections.json
  sed -i '$ d' ../collections.json
  sed -i '1i [' ../collections.json
  sed -i '$a ]' ../collections.json

  #add, commit and push files
  git add --all
  git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to gh-pages"
  git push -fq origin gh-pages > /dev/null

  echo -e "Done magic with GitHub pages\n"
