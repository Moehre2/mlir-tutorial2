#include "lib/Transform/Affine/AffineFullUnroll.hpp"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Affine/LoopUtils.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"
#include "mlir/Pass/Pass.h"

namespace mlir {

    namespace tutorial {

        using mlir::affine::AffineForOp;
        using mlir::affine::loopUnrollFull;

        //! A pass that manually walks the IR
        void AffineFullUnrollPass::runOnOperation() {
            getOperation()->walk([&](AffineForOp op) {
                if(failed(loopUnrollFull(op))) {
                    op.emitError("unrolling failed");
                    signalPassFailure();
                }
            });
        }

        //! A pattern that matches on AffineForOp and unrolls it.
        struct AffineFullUnrollPattern : public OpRewritePattern<AffineForOp> {

            AffineFullUnrollPattern(mlir::MLIRContext* context) : OpRewritePattern<AffineForOp>(context, 1) {}

            LogicalResult matchAndRewrite(AffineForOp op, PatternRewriter& rewriter) const override { return loopUnrollFull(op); }

        };

        //! A pass that invokes the pattern rewrite engine.
        void AffineFullUnrollPassAsPatternRewrite::runOnOperation() {
            mlir::RewritePatternSet patterns(&getContext());
            patterns.add<AffineFullUnrollPattern>(&getContext());
            (void) applyPatternsAndFoldGreedily(getOperation(), std::move(patterns));
        }

    }

}
