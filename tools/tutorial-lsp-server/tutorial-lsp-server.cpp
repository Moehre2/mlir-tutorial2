#include "lib/Dialect/Poly/PolyDialect.hpp"
#include "mlir/InitAllDialects.h"
#include "mlir/Tools/mlir-lsp-server/MlirLspServerMain.h"

int main(int argc, char** argv) {
    mlir::DialectRegistry registry;
    registry.insert<mlir::tutorial::poly::PolyDialect>();
    mlir::registerAllDialects(registry);
    return mlir::failed(mlir::MlirLspServerMain(argc, argv, registry));
}
