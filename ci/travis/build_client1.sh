# Any commands which fail will cause the shell script to exit immediately
set -e

# Validate Travis CI environment
if [ "$TRAVIS_BUILD_DIR" = "" ]; then
  echo "Please define 'TRAVIS_BUILD_DIR' environment variable.";
  exit 1;
fi

# Copy all installed packages to the same directory
export MERGED_INSTALL_DIR=$TRAVIS_BUILD_DIR/install_merge
mkdir $MERGED_INSTALL_DIR >/dev/null 2>/dev/null
cp -a $TRAVIS_BUILD_DIR/third_parties/googletest/install/. $MERGED_INSTALL_DIR/
cp -a $TRAVIS_BUILD_DIR/library/install/. $MERGED_INSTALL_DIR/

echo ============================================================================
echo Generating...
echo ============================================================================
cd $TRAVIS_BUILD_DIR/clients/client1
mkdir build >/dev/null 2>/dev/null
cd build
cmake -DCMAKE_INSTALL_PREFIX=$MERGED_INSTALL_DIR -DCMAKE_BUILD_TYPE=Release ..

echo ============================================================================
echo Compiling...
echo ============================================================================
cmake --build .
echo

# Delete all temporary environment variable created
unset MERGED_INSTALL_DIR
