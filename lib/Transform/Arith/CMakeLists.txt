add_mlir_library(MulToAdd
    MulToAdd.cpp

    ${PROJECT_SOURCE_DIR}/lib/Transform/Arith/
    ADDITIONAL_HEADER_DIRS

    #DEPENDS
    #MLIRMulToAddPasses

    LINK_LIBS PUBLIC
)
