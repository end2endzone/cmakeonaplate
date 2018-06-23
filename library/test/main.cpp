#include "FooLib/foolib.h"

#include <gtest/gtest.h>

#include <cstdio>

int main(int argc, char **argv)
{
  printf("Running footest v%s.\n", FOOLIB_VERSION);

  ::testing::GTEST_FLAG(output) = "xml:footest.xml";
  ::testing::GTEST_FLAG(filter) = "*";
  ::testing::InitGoogleTest(&argc, argv);

  int result = RUN_ALL_TESTS();
  return result;

  return 0;
}
