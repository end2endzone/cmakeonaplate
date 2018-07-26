# Any commands which fail will cause the shell script to exit immediately
set -e

# Validate Travis CI environment
if [ "$TRAVIS_BUILD_DIR" = "" ]; then
  echo "Please define 'TRAVIS_BUILD_DIR' environment variable.";
  exit 1;
fi

set GTEST_ROOT=$TRAVIS_BUILD_DIR/third_parties/googletest/install

# Copy install package to CMake's CMAKE_INSTALL_PREFIX default directory
export PROGRAMFILES_INSTALL_DIR=/usr/local
# mkdir $PROGRAMFILES_INSTALL_DIR >/dev/null 2>/dev/null
sudo cp -a $TRAVIS_BUILD_DIR/library/install/. $PROGRAMFILES_INSTALL_DIR

echo ============================================================================
echo Generating...
echo ============================================================================
cd $TRAVIS_BUILD_DIR/clients/client3
mkdir build >/dev/null 2>/dev/null
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..

echo ============================================================================
echo Compiling...
echo ============================================================================
cmake --build .
echo

# Delete all temporary environment variable created
unset GTEST_ROOT
unset PROGRAMFILES_INSTALL_DIR
