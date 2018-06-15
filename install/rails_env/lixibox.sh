echo "installing RVM"
\curl -sSL https://get.rvm.io | bash
source /Users/nguyenductoan/.rvm/scripts/rvm

echo "installing ruby"
rvm install 2.3.3

echo "creating gem set"
rvm gemset create lixibox
rvm list gemsets
rvm gemset use lixibox

echo "Installing Rails"
gem install rails -v 4.2.1

echo "install qt"
brew install qt@5.5
echo "force Homebrew to symlink qt binaries"
brew link --force qt@5.5

echo "Installing elasticsearch 2.4"
brew install elasticsearch@2.4
brew services start elasticsearch@2.4

