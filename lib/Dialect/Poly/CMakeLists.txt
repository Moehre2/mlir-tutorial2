set(LLVM_TARGET_DEFINITIONS PolyDialect.td)
mlir_tablegen(PolyDialect.h.inc -gen-dialect-decls)
mlir_tablegen(PolyDialect.cpp.inc -gen-dialect-defs)
set(LLVM_TARGET_DEFINITIONS PolyTypes.td)
mlir_tablegen(PolyTypes.h.inc -gen-typedef-decls -typedefs-dialect=poly)
mlir_tablegen(PolyTypes.cpp.inc -gen-typedef-defs -typedefs-dialect=poly)
add_public_tablegen_target(MLIRPolyOpsIncGen)
add_dependencies(mlir-headers MLIRPolyOpsIncGen)

add_mlir_doc(PolyDialect PolyDialect Poly/ -gen-dialect-doc)

add_mlir_dialect_library(MLIRPoly
    PolyDialect.cpp

    ADDITIONAL_HEADER_DIRS
    ${PROJECT_SOURCE_DIR}/lib/Dialect/Poly

    LINK_LIBS PUBLIC
)
