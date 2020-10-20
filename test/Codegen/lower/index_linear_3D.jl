# RUN: julia -e "import Brutus; Brutus.lit(:emit_lowered)" --startup-file=no %s 2>&1 | FileCheck %s

index(A, i) = A[i]
emit(index, Array{Int64, 3}, Int64)
#



# CHECK: module {
# CHECK-NEXT:   func @"Tuple{typeof(Main.index), Array{Int64, 3}, Int64}"(%arg0: !jlir<"typeof(Main.index)">, %arg1: memref<?x?x?xi64>, %arg2: i64) -> i64 {
# CHECK-NEXT:     %c0 = constant 0 : index
# CHECK-NEXT:     %c1 = constant 1 : index
# CHECK-NEXT:     %0 = "jlir.convertstd"(%arg2) : (i64) -> index
# CHECK-NEXT:     %1 = subi %0, %c1 : index
# CHECK-NEXT:     %2 = load %arg1[%c0, %c0, %1] : memref<?x?x?xi64>
# CHECK-NEXT:     return %2 : i64
# CHECK-NEXT:   }
# CHECK-NEXT: }

# CHECK: module {
# CHECK-NEXT:   llvm.func @"Tuple{typeof(Main.index), Array{Int64, 3}, Int64}"(%arg0: !llvm.ptr<struct<"jl_value_t", ()>>, %arg1: !llvm.ptr<i64>, %arg2: !llvm.ptr<i64>, %arg3: !llvm.i64, %arg4: !llvm.i64, %arg5: !llvm.i64, %arg6: !llvm.i64, %arg7: !llvm.i64, %arg8: !llvm.i64, %arg9: !llvm.i64, %arg10: !llvm.i64) -> !llvm.i64 {
# CHECK-NEXT:     %0 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<3 x i64>, array<3 x i64>)>
# CHECK-NEXT:     %1 = llvm.insertvalue %arg1, %0[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<3 x i64>, array<3 x i64>)>
# CHECK-NEXT:     %2 = llvm.insertvalue %arg2, %1[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<3 x i64>, array<3 x i64>)>
# CHECK-NEXT:     %3 = llvm.insertvalue %arg3, %2[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<3 x i64>, array<3 x i64>)>
# CHECK-NEXT:     %4 = llvm.insertvalue %arg4, %3[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<3 x i64>, array<3 x i64>)>
# CHECK-NEXT:     %5 = llvm.insertvalue %arg7, %4[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<3 x i64>, array<3 x i64>)>
# CHECK-NEXT:     %6 = llvm.insertvalue %arg5, %5[3, 1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<3 x i64>, array<3 x i64>)>
# CHECK-NEXT:     %7 = llvm.insertvalue %arg8, %6[4, 1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<3 x i64>, array<3 x i64>)>
# CHECK-NEXT:     %8 = llvm.insertvalue %arg6, %7[3, 2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<3 x i64>, array<3 x i64>)>
# CHECK-NEXT:     %9 = llvm.insertvalue %arg9, %8[4, 2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<3 x i64>, array<3 x i64>)>
# CHECK-NEXT:     %10 = llvm.mlir.constant(0 : index) : !llvm.i64
# CHECK-NEXT:     %11 = llvm.mlir.constant(1 : index) : !llvm.i64
# CHECK-NEXT:     %12 = llvm.sub %arg10, %11 : !llvm.i64
# CHECK-NEXT:     %13 = llvm.extractvalue %9[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<3 x i64>, array<3 x i64>)>
# CHECK-NEXT:     %14 = llvm.extractvalue %9[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<3 x i64>, array<3 x i64>)>
# CHECK-NEXT:     %15 = llvm.mul %10, %14 : !llvm.i64
# CHECK-NEXT:     %16 = llvm.add %10, %15 : !llvm.i64
# CHECK-NEXT:     %17 = llvm.extractvalue %9[4, 1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<3 x i64>, array<3 x i64>)>
# CHECK-NEXT:     %18 = llvm.mul %10, %17 : !llvm.i64
# CHECK-NEXT:     %19 = llvm.add %16, %18 : !llvm.i64
# CHECK-NEXT:     %20 = llvm.mul %12, %11 : !llvm.i64
# CHECK-NEXT:     %21 = llvm.add %19, %20 : !llvm.i64
# CHECK-NEXT:     %22 = llvm.getelementptr %13[%21] : (!llvm.ptr<i64>, !llvm.i64) -> !llvm.ptr<i64>
# CHECK-NEXT:     %23 = llvm.load %22 : !llvm.ptr<i64>
# CHECK-NEXT:     llvm.return %23 : !llvm.i64
# CHECK-NEXT:   }
# CHECK-NEXT: }
