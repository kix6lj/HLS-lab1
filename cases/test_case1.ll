; ModuleID = 'test_case1.ll'
source_filename = "../cases/test_case1.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress nofree nosync nounwind readnone sspstrong uwtable willreturn
define noundef float @_Z14ternary_searchff(float noundef %0, float noundef %1) local_unnamed_addr #0 {
  %3 = fsub float %1, %0
  %4 = tail call float @llvm.fabs.f32(float %3) #2
  %5 = fcmp ult float %4, 0x3E7AD7F2A0000000
  br i1 %5, label %27, label %6

6:                                                ; preds = %6, %2
  %7 = phi float [ %24, %6 ], [ %3, %2 ]
  %8 = phi float [ %23, %6 ], [ %0, %2 ]
  %9 = phi float [ %22, %6 ], [ %1, %2 ]
  %10 = fdiv float %7, 3.000000e+00
  %11 = fadd float %8, %10
  %12 = fsub float %9, %10
  %13 = fmul float %11, 9.000000e+00
  %14 = fmul float %11, 3.000000e+00
  %15 = tail call float @llvm.fmuladd.f32(float %13, float %11, float %14) #2
  %16 = fadd float %15, -1.000000e+00
  %17 = fmul float %12, 9.000000e+00
  %18 = fmul float %12, 3.000000e+00
  %19 = tail call float @llvm.fmuladd.f32(float %17, float %12, float %18) #2
  %20 = fadd float %19, -1.000000e+00
  %21 = fcmp olt float %16, %20
  %22 = select i1 %21, float %12, float %9
  %23 = select i1 %21, float %8, float %11
  %24 = fsub float %22, %23
  %25 = tail call float @llvm.fabs.f32(float %24) #2
  %26 = fcmp ult float %25, 0x3E7AD7F2A0000000
  br i1 %26, label %27, label %6, !llvm.loop !4

27:                                               ; preds = %6, %2
  %28 = phi float [ %1, %2 ], [ %22, %6 ]
  %29 = phi float [ %0, %2 ], [ %23, %6 ]
  %30 = fadd float %28, %29
  %31 = fmul float %30, 5.000000e-01
  ret float %31
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare float @llvm.fabs.f32(float) #1

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare float @llvm.fmuladd.f32(float, float, float) #1

attributes #0 = { mustprogress nofree nosync nounwind readnone sspstrong uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="4" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{!"clang version 14.0.0"}
!4 = distinct !{!4, !5}
!5 = !{!"llvm.loop.mustprogress"}
