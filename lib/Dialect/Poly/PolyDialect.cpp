#include "lib/Dialect/Poly/PolyDialect.hpp"

#include "lib/Dialect/Poly/PolyTypes.hpp"
#include "mlir/IR/Builders.h"
#include "llvm/ADT/TypeSwitch.h"

#include "lib/Dialect/Poly/PolyDialect.cpp.inc"
#define GET_TYPEDEF_CLASSES
#include "lib/Dialect/Poly/PolyTypes.cpp.inc"

namespace mlir {

    namespace tutorial {

        namespace poly {

            void PolyDialect::initialize() {
                addTypes<
                    #define GET_TYPEDEF_LIST
                    #include "lib/Dialect/Poly/PolyTypes.cpp.inc"
                >();
            }

        }

    }

}
