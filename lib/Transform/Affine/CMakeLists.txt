add_mlir_library(AffineFullUnroll
    AffineFullUnroll.cpp

    ${PROJECT_SOURCE_DIR}/lib/Transform/Affine/
    ADDITIONAL_HEADER_DIRS

    #DEPENDS
    #MLIRAffineFullUnrollPasses

    LINK_LIBS PUBLIC
)
