#ifndef TESTFOO_H
#define TESTFOO_H

#include <gtest/gtest.h>

namespace test
{
  class TestFoo : public ::testing::Test
  {
  public:
    virtual void SetUp();
    virtual void TearDown();
  };

} // End namespace test

#endif //TESTFOO_H
