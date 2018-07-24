# Validate Travis CI environment
if [ "$TRAVIS_BUILD_DIR" = "" ]; then
  echo "Please define 'TRAVIS_BUILD_DIR' environment variable.";
  exit 1;
fi

set GTEST_ROOT=$TRAVIS_BUILD_DIR/third_parties/googletest/install
set FOOLIB_DIR=$TRAVIS_BUILD_DIR/library/install
echo FOOLIB_DIR=$FOOLIB_DIR

echo ============================================================================
echo Generating...
echo ============================================================================
cd /d $TRAVIS_BUILD_DIR/clients/client2
mkdir build >/dev/null 2>/dev/null
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..

echo ============================================================================
echo Compiling...
echo ============================================================================
cmake --build .
echo.

::Delete all temporary environment variable created
unset GTEST_ROOT
unset FOOLIB_DIR
