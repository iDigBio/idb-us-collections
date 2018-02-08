  echo -e "Starting to update json-index\n"
  
  #copy new files
  echo -e "Copy new files"
  cp -R collections $HOME/collections
  

  #go to home and setup git
  cd $HOME
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis"

  #using token clone gh-pages branch
  git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/iDigBio/idb-us-collections.git  gh-pages > /dev/null
  echo -e "Clone gh-pages repo"
 
  #go into directory and create our index file
  cd gh-pages/
  rm -rf collections/
  mkdir collections
  cp -R $HOME/collections/* collections/
  cd collections
  sed -s '$a,' * > ../collections.json
  sed -i '$ d' ../collections.json
  sed -i '1i [' ../collections.json
  sed -i '$a ]' ../collections.json

  #add, commit and push files
  git add --all :/
  git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to gh-pages"
  git push -fq origin gh-pages > /dev/null
  
  
  
  #using token clone json-index branch
  cd $HOME
  git clone --quiet --branch=json-index https://${GH_TOKEN}@github.com/iDigBio/idb-us-collections.git  json-index > /dev/null
  echo -e "Clone json-index repo"
 
  #go into directory and create our index file
  cd json-index/
  mkdir collections
  cd collections
  cp -R $HOME/collections/* .
  sed -s '$a,' * > ../collections.json
  sed -i '$ d' ../collections.json
  sed -i '1i [' ../collections.json
  sed -i '$a ]' ../collections.json
  cd ..
  rm -rf collections/
  Rscript buildCSV.R

  #add, commit and push files
  git add --all 
  git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to json-index"
  git push -fq origin json-index > /dev/null
  
  

  echo -e "Done magic with GitHub pages\n"
