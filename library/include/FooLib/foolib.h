#ifndef FOO_H
#define FOO_H

#include "config.h"
#include "version.h"

#ifdef FOOLIB_BUILT_AS_SHARED
#include "export.h"
#endif

#ifndef FOOLIB_EXPORT
#define FOOLIB_EXPORT
#endif

FOOLIB_EXPORT void sayHello();

#endif //FOO_H
