get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)
get_property(conversion_libs GLOBAL PROPERTY MLIR_CONVERSION_LIBS)

set(LIBS
    ${dialect_libs}
    ${conversion_libs}
    AffineFullUnroll
    MLIROptLib
    MLIRPass
    MLIRPoly
    MulToAdd
    MLIRLspServerLib
)

add_llvm_executable(tutorial-lsp-server
    tutorial-lsp-server.cpp
    DEPENDS ${LIBS}
)

llvm_update_compile_flags(tutorial-lsp-server)
target_link_libraries(tutorial-lsp-server PRIVATE ${LIBS})

mlir_check_all_link_libraries(tutorial-lsp-server)
