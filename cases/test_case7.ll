; ModuleID = 'test_case7.ll'
source_filename = "../cases/test_case7.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.gradient_t = type { float, float, float }

@_ZL11GRAD_FILTER = internal constant [7 x float] [float 0x3FB353F7C0000000, float 0x3FC10624E0000000, float 0x3FC7EC56E0000000, float 0x3FD2944680000000, float 0x3FC7EC56E0000000, float 0x3FC10624E0000000, float 0x3FB353F7C0000000], align 16

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z17gradient_weight_yPA1024_fS0_S0_PA1024_10gradient_t([1024 x float]* noundef %0, [1024 x float]* noundef %1, [1024 x float]* noundef %2, [1024 x %struct.gradient_t]* noundef %3) #0 {
  br label %5

5:                                                ; preds = %57, %4
  %.02 = phi i32 [ 0, %4 ], [ %58, %57 ]
  %6 = icmp slt i32 %.02, 439
  br i1 %6, label %7, label %59

7:                                                ; preds = %5
  br label %8

8:                                                ; preds = %54, %7
  %.01 = phi i32 [ 0, %7 ], [ %55, %54 ]
  %9 = icmp slt i32 %.01, 1024
  br i1 %9, label %10, label %56

10:                                               ; preds = %8
  %11 = icmp sge i32 %.02, 6
  br i1 %11, label %12, label %44

12:                                               ; preds = %10
  %13 = icmp slt i32 %.02, 436
  br i1 %13, label %14, label %44

14:                                               ; preds = %12
  br label %15

15:                                               ; preds = %36, %14
  %.sroa.8.0 = phi float [ 0.000000e+00, %14 ], [ %35, %36 ]
  %.sroa.5.0 = phi float [ 0.000000e+00, %14 ], [ %31, %36 ]
  %.sroa.0.0 = phi float [ 0.000000e+00, %14 ], [ %27, %36 ]
  %.0 = phi i32 [ 0, %14 ], [ %37, %36 ]
  %16 = icmp slt i32 %.0, 7
  br i1 %16, label %17, label %38

17:                                               ; preds = %15
  %18 = sub nsw i32 %.02, %.0
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [1024 x float], [1024 x float]* %0, i64 %19
  %21 = sext i32 %.01 to i64
  %22 = getelementptr inbounds [1024 x float], [1024 x float]* %20, i64 0, i64 %21
  %23 = load float, float* %22, align 4
  %24 = sext i32 %.0 to i64
  %25 = getelementptr inbounds [7 x float], [7 x float]* @_ZL11GRAD_FILTER, i64 0, i64 %24
  %26 = load float, float* %25, align 4
  %27 = call float @llvm.fmuladd.f32(float %23, float %26, float %.sroa.0.0)
  %28 = getelementptr inbounds [1024 x float], [1024 x float]* %1, i64 %19
  %29 = getelementptr inbounds [1024 x float], [1024 x float]* %28, i64 0, i64 %21
  %30 = load float, float* %29, align 4
  %31 = call float @llvm.fmuladd.f32(float %30, float %26, float %.sroa.5.0)
  %32 = getelementptr inbounds [1024 x float], [1024 x float]* %2, i64 %19
  %33 = getelementptr inbounds [1024 x float], [1024 x float]* %32, i64 0, i64 %21
  %34 = load float, float* %33, align 4
  %35 = call float @llvm.fmuladd.f32(float %34, float %26, float %.sroa.8.0)
  br label %36

36:                                               ; preds = %17
  %37 = add nsw i32 %.0, 1
  br label %15, !llvm.loop !4

38:                                               ; preds = %15
  %39 = sub nsw i32 %.02, 3
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [1024 x %struct.gradient_t], [1024 x %struct.gradient_t]* %3, i64 %40
  %42 = sext i32 %.01 to i64
  %43 = getelementptr inbounds [1024 x %struct.gradient_t], [1024 x %struct.gradient_t]* %41, i64 0, i64 %42
  %.sroa.0.0..sroa_idx = getelementptr inbounds %struct.gradient_t, %struct.gradient_t* %43, i64 0, i32 0
  store float %.sroa.0.0, float* %.sroa.0.0..sroa_idx, align 4
  %.sroa.5.0..sroa_idx5 = getelementptr inbounds %struct.gradient_t, %struct.gradient_t* %43, i64 0, i32 1
  store float %.sroa.5.0, float* %.sroa.5.0..sroa_idx5, align 4
  %.sroa.8.0..sroa_idx8 = getelementptr inbounds %struct.gradient_t, %struct.gradient_t* %43, i64 0, i32 2
  store float %.sroa.8.0, float* %.sroa.8.0..sroa_idx8, align 4
  br label %53

44:                                               ; preds = %12, %10
  %45 = icmp sge i32 %.02, 3
  br i1 %45, label %46, label %52

46:                                               ; preds = %44
  %47 = sub nsw i32 %.02, 3
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds [1024 x %struct.gradient_t], [1024 x %struct.gradient_t]* %3, i64 %48
  %50 = sext i32 %.01 to i64
  %51 = getelementptr inbounds [1024 x %struct.gradient_t], [1024 x %struct.gradient_t]* %49, i64 0, i64 %50
  %.sroa.0.0..sroa_idx3 = getelementptr inbounds %struct.gradient_t, %struct.gradient_t* %51, i64 0, i32 0
  store float 0.000000e+00, float* %.sroa.0.0..sroa_idx3, align 4
  %.sroa.5.0..sroa_idx6 = getelementptr inbounds %struct.gradient_t, %struct.gradient_t* %51, i64 0, i32 1
  store float 0.000000e+00, float* %.sroa.5.0..sroa_idx6, align 4
  %.sroa.8.0..sroa_idx9 = getelementptr inbounds %struct.gradient_t, %struct.gradient_t* %51, i64 0, i32 2
  store float 0.000000e+00, float* %.sroa.8.0..sroa_idx9, align 4
  br label %52

52:                                               ; preds = %46, %44
  br label %53

53:                                               ; preds = %52, %38
  br label %54

54:                                               ; preds = %53
  %55 = add nsw i32 %.01, 1
  br label %8, !llvm.loop !6

56:                                               ; preds = %8
  br label %57

57:                                               ; preds = %56
  %58 = add nsw i32 %.02, 1
  br label %5, !llvm.loop !7

59:                                               ; preds = %5
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare float @llvm.fmuladd.f32(float, float, float) #1

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

attributes #0 = { mustprogress noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nofree nounwind willreturn }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{!"clang version 14.0.0"}
!4 = distinct !{!4, !5}
!5 = !{!"llvm.loop.mustprogress"}
!6 = distinct !{!6, !5}
!7 = distinct !{!7, !5}
