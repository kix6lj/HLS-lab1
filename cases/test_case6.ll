; ModuleID = 'test_case6.ll'
source_filename = "../cases/test_case6.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@_ZL12GRAD_WEIGHTS = internal constant [5 x i32] [i32 1, i32 -8, i32 0, i32 8, i32 -1], align 16

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z15gradient_z_calcPA1024_fS0_S0_S0_S0_S0_([1024 x float]* noundef %0, [1024 x float]* noundef %1, [1024 x float]* noundef %2, [1024 x float]* noundef %3, [1024 x float]* noundef %4, [1024 x float]* noundef %5) #0 {
  br label %7

7:                                                ; preds = %41, %6
  %.01 = phi i32 [ 0, %6 ], [ %42, %41 ]
  %8 = icmp slt i32 %.01, 436
  br i1 %8, label %9, label %43

9:                                                ; preds = %7
  br label %10

10:                                               ; preds = %38, %9
  %.0 = phi i32 [ 0, %9 ], [ %39, %38 ]
  %11 = icmp slt i32 %.0, 1024
  br i1 %11, label %12, label %40

12:                                               ; preds = %10
  %13 = sext i32 %.01 to i64
  %14 = getelementptr inbounds [1024 x float], [1024 x float]* %5, i64 %13
  %15 = sext i32 %.0 to i64
  %16 = getelementptr inbounds [1024 x float], [1024 x float]* %14, i64 0, i64 %15
  store float 0.000000e+00, float* %16, align 4
  %17 = getelementptr inbounds [1024 x float], [1024 x float]* %0, i64 %13
  %18 = getelementptr inbounds [1024 x float], [1024 x float]* %17, i64 0, i64 %15
  %19 = load float, float* %18, align 4
  %20 = call float @llvm.fmuladd.f32(float %19, float 1.000000e+00, float 0.000000e+00)
  store float %20, float* %16, align 4
  %21 = getelementptr inbounds [1024 x float], [1024 x float]* %1, i64 %13
  %22 = getelementptr inbounds [1024 x float], [1024 x float]* %21, i64 0, i64 %15
  %23 = load float, float* %22, align 4
  %24 = call float @llvm.fmuladd.f32(float %23, float -8.000000e+00, float %20)
  store float %24, float* %16, align 4
  %25 = getelementptr inbounds [1024 x float], [1024 x float]* %2, i64 %13
  %26 = getelementptr inbounds [1024 x float], [1024 x float]* %25, i64 0, i64 %15
  %27 = load float, float* %26, align 4
  %28 = call float @llvm.fmuladd.f32(float %27, float 0.000000e+00, float %24)
  store float %28, float* %16, align 4
  %29 = getelementptr inbounds [1024 x float], [1024 x float]* %3, i64 %13
  %30 = getelementptr inbounds [1024 x float], [1024 x float]* %29, i64 0, i64 %15
  %31 = load float, float* %30, align 4
  %32 = call float @llvm.fmuladd.f32(float %31, float 8.000000e+00, float %28)
  store float %32, float* %16, align 4
  %33 = getelementptr inbounds [1024 x float], [1024 x float]* %4, i64 %13
  %34 = getelementptr inbounds [1024 x float], [1024 x float]* %33, i64 0, i64 %15
  %35 = load float, float* %34, align 4
  %36 = call float @llvm.fmuladd.f32(float %35, float -1.000000e+00, float %32)
  %37 = fdiv float %36, 1.200000e+01
  store float %37, float* %16, align 4
  br label %38

38:                                               ; preds = %12
  %39 = add nsw i32 %.0, 1
  br label %10, !llvm.loop !4

40:                                               ; preds = %10
  br label %41

41:                                               ; preds = %40
  %42 = add nsw i32 %.01, 1
  br label %7, !llvm.loop !6

43:                                               ; preds = %7
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare float @llvm.fmuladd.f32(float, float, float) #1

attributes #0 = { mustprogress noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{!"clang version 14.0.0"}
!4 = distinct !{!4, !5}
!5 = !{!"llvm.loop.mustprogress"}
!6 = distinct !{!6, !5}
