#how to run this script --> sh setup.sh

#install postgresql, to install pg
brew install postgresql

#install imagemagick, to use .variant(resize: "100x100")
brew install imagemagick

#install chromedrvier for cucumber
brew install chromedriver

#if not success
'''
$ brew install chromedriver
Error: No available formula with the name "chromedriver" 
It was migrated from homebrew/core to caskroom/cask.
You can access it again by running:
  brew tap caskroom/cask

$ brew tap caskroom/cask
$ brew install chromedriver
Error: No available formula with the name "chromedriver" 
It was migrated from homebrew/core to caskroom/cask.
You can access it again by running:
  brew tap caskroom/cask
'''