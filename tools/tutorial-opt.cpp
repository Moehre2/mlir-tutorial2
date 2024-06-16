#include "lib/Dialect/Poly/PolyDialect.hpp"
#include "lib/Transform/Affine/Passes.hpp"
#include "lib/Transform/Arith/Passes.hpp"
#include "mlir/InitAllDialects.h"
#include "mlir/InitAllPasses.h"
#include "mlir/Pass/PassManager.h"
#include "mlir/Pass/PassRegistry.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"

int main(int argc, char **argv) {
    mlir::DialectRegistry registry;
    registry.insert<mlir::tutorial::poly::PolyDialect>();
    mlir::registerAllDialects(registry);
    mlir::registerAllPasses();
    mlir::tutorial::registerAffinePasses();
    mlir::tutorial::registerArithPasses();
    return mlir::asMainReturnCode(mlir::MlirOptMain(argc, argv, "Tutorial Pass Driver", registry));
}
