; ModuleID = 'test_case8.ll'
source_filename = "../cases/test_case8.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z14kernel_heat_3diiPA120_A120_dS1_(i32 noundef %0, i32 noundef %1, [120 x [120 x double]]* noundef %2, [120 x [120 x double]]* noundef %3) #0 {
  br label %5

5:                                                ; preds = %143, %4
  %.05 = phi i32 [ 1, %4 ], [ %144, %143 ]
  %6 = icmp sle i32 %.05, 500
  br i1 %6, label %7, label %145

7:                                                ; preds = %5
  br label %8

8:                                                ; preds = %73, %7
  %.03 = phi i32 [ 1, %7 ], [ %74, %73 ]
  %9 = sub nsw i32 %1, 1
  %10 = icmp slt i32 %.03, %9
  br i1 %10, label %11, label %75

11:                                               ; preds = %8
  br label %12

12:                                               ; preds = %70, %11
  %.01 = phi i32 [ 1, %11 ], [ %71, %70 ]
  %13 = icmp slt i32 %.01, %9
  br i1 %13, label %14, label %72

14:                                               ; preds = %12
  br label %15

15:                                               ; preds = %68, %14
  %.0 = phi i32 [ 1, %14 ], [ %53, %68 ]
  %16 = icmp slt i32 %.0, %9
  br i1 %16, label %17, label %69

17:                                               ; preds = %15
  %18 = add nsw i32 %.03, 1
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [120 x [120 x double]], [120 x [120 x double]]* %2, i64 %19
  %21 = sext i32 %.01 to i64
  %22 = getelementptr inbounds [120 x [120 x double]], [120 x [120 x double]]* %20, i64 0, i64 %21
  %23 = sext i32 %.0 to i64
  %24 = getelementptr inbounds [120 x double], [120 x double]* %22, i64 0, i64 %23
  %25 = load double, double* %24, align 8
  %26 = sext i32 %.03 to i64
  %27 = getelementptr inbounds [120 x [120 x double]], [120 x [120 x double]]* %2, i64 %26
  %28 = getelementptr inbounds [120 x [120 x double]], [120 x [120 x double]]* %27, i64 0, i64 %21
  %29 = getelementptr inbounds [120 x double], [120 x double]* %28, i64 0, i64 %23
  %30 = load double, double* %29, align 8
  %31 = call double @llvm.fmuladd.f64(double -2.000000e+00, double %30, double %25)
  %32 = sub nsw i32 %.03, 1
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [120 x [120 x double]], [120 x [120 x double]]* %2, i64 %33
  %35 = getelementptr inbounds [120 x [120 x double]], [120 x [120 x double]]* %34, i64 0, i64 %21
  %36 = getelementptr inbounds [120 x double], [120 x double]* %35, i64 0, i64 %23
  %37 = load double, double* %36, align 8
  %38 = fadd double %31, %37
  %39 = add nsw i32 %.01, 1
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [120 x [120 x double]], [120 x [120 x double]]* %27, i64 0, i64 %40
  %42 = getelementptr inbounds [120 x double], [120 x double]* %41, i64 0, i64 %23
  %43 = load double, double* %42, align 8
  %44 = call double @llvm.fmuladd.f64(double -2.000000e+00, double %30, double %43)
  %45 = sub nsw i32 %.01, 1
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds [120 x [120 x double]], [120 x [120 x double]]* %27, i64 0, i64 %46
  %48 = getelementptr inbounds [120 x double], [120 x double]* %47, i64 0, i64 %23
  %49 = load double, double* %48, align 8
  %50 = fadd double %44, %49
  %51 = fmul double 1.250000e-01, %50
  %52 = call double @llvm.fmuladd.f64(double 1.250000e-01, double %38, double %51)
  %53 = add nsw i32 %.0, 1
  %54 = sext i32 %53 to i64
  %55 = getelementptr inbounds [120 x double], [120 x double]* %28, i64 0, i64 %54
  %56 = load double, double* %55, align 8
  %57 = call double @llvm.fmuladd.f64(double -2.000000e+00, double %30, double %56)
  %58 = sub nsw i32 %.0, 1
  %59 = sext i32 %58 to i64
  %60 = getelementptr inbounds [120 x double], [120 x double]* %28, i64 0, i64 %59
  %61 = load double, double* %60, align 8
  %62 = fadd double %57, %61
  %63 = call double @llvm.fmuladd.f64(double 1.250000e-01, double %62, double %52)
  %64 = fadd double %63, %30
  %65 = getelementptr inbounds [120 x [120 x double]], [120 x [120 x double]]* %3, i64 %26
  %66 = getelementptr inbounds [120 x [120 x double]], [120 x [120 x double]]* %65, i64 0, i64 %21
  %67 = getelementptr inbounds [120 x double], [120 x double]* %66, i64 0, i64 %23
  store double %64, double* %67, align 8
  br label %68

68:                                               ; preds = %17
  br label %15, !llvm.loop !4

69:                                               ; preds = %15
  br label %70

70:                                               ; preds = %69
  %71 = add nsw i32 %.01, 1
  br label %12, !llvm.loop !6

72:                                               ; preds = %12
  br label %73

73:                                               ; preds = %72
  %74 = add nsw i32 %.03, 1
  br label %8, !llvm.loop !7

75:                                               ; preds = %8
  br label %76

76:                                               ; preds = %140, %75
  %.14 = phi i32 [ 1, %75 ], [ %141, %140 ]
  %77 = icmp slt i32 %.14, %9
  br i1 %77, label %78, label %142

78:                                               ; preds = %76
  br label %79

79:                                               ; preds = %137, %78
  %.12 = phi i32 [ 1, %78 ], [ %138, %137 ]
  %80 = icmp slt i32 %.12, %9
  br i1 %80, label %81, label %139

81:                                               ; preds = %79
  br label %82

82:                                               ; preds = %135, %81
  %.1 = phi i32 [ 1, %81 ], [ %120, %135 ]
  %83 = icmp slt i32 %.1, %9
  br i1 %83, label %84, label %136

84:                                               ; preds = %82
  %85 = add nsw i32 %.14, 1
  %86 = sext i32 %85 to i64
  %87 = getelementptr inbounds [120 x [120 x double]], [120 x [120 x double]]* %3, i64 %86
  %88 = sext i32 %.12 to i64
  %89 = getelementptr inbounds [120 x [120 x double]], [120 x [120 x double]]* %87, i64 0, i64 %88
  %90 = sext i32 %.1 to i64
  %91 = getelementptr inbounds [120 x double], [120 x double]* %89, i64 0, i64 %90
  %92 = load double, double* %91, align 8
  %93 = sext i32 %.14 to i64
  %94 = getelementptr inbounds [120 x [120 x double]], [120 x [120 x double]]* %3, i64 %93
  %95 = getelementptr inbounds [120 x [120 x double]], [120 x [120 x double]]* %94, i64 0, i64 %88
  %96 = getelementptr inbounds [120 x double], [120 x double]* %95, i64 0, i64 %90
  %97 = load double, double* %96, align 8
  %98 = call double @llvm.fmuladd.f64(double -2.000000e+00, double %97, double %92)
  %99 = sub nsw i32 %.14, 1
  %100 = sext i32 %99 to i64
  %101 = getelementptr inbounds [120 x [120 x double]], [120 x [120 x double]]* %3, i64 %100
  %102 = getelementptr inbounds [120 x [120 x double]], [120 x [120 x double]]* %101, i64 0, i64 %88
  %103 = getelementptr inbounds [120 x double], [120 x double]* %102, i64 0, i64 %90
  %104 = load double, double* %103, align 8
  %105 = fadd double %98, %104
  %106 = add nsw i32 %.12, 1
  %107 = sext i32 %106 to i64
  %108 = getelementptr inbounds [120 x [120 x double]], [120 x [120 x double]]* %94, i64 0, i64 %107
  %109 = getelementptr inbounds [120 x double], [120 x double]* %108, i64 0, i64 %90
  %110 = load double, double* %109, align 8
  %111 = call double @llvm.fmuladd.f64(double -2.000000e+00, double %97, double %110)
  %112 = sub nsw i32 %.12, 1
  %113 = sext i32 %112 to i64
  %114 = getelementptr inbounds [120 x [120 x double]], [120 x [120 x double]]* %94, i64 0, i64 %113
  %115 = getelementptr inbounds [120 x double], [120 x double]* %114, i64 0, i64 %90
  %116 = load double, double* %115, align 8
  %117 = fadd double %111, %116
  %118 = fmul double 1.250000e-01, %117
  %119 = call double @llvm.fmuladd.f64(double 1.250000e-01, double %105, double %118)
  %120 = add nsw i32 %.1, 1
  %121 = sext i32 %120 to i64
  %122 = getelementptr inbounds [120 x double], [120 x double]* %95, i64 0, i64 %121
  %123 = load double, double* %122, align 8
  %124 = call double @llvm.fmuladd.f64(double -2.000000e+00, double %97, double %123)
  %125 = sub nsw i32 %.1, 1
  %126 = sext i32 %125 to i64
  %127 = getelementptr inbounds [120 x double], [120 x double]* %95, i64 0, i64 %126
  %128 = load double, double* %127, align 8
  %129 = fadd double %124, %128
  %130 = call double @llvm.fmuladd.f64(double 1.250000e-01, double %129, double %119)
  %131 = fadd double %130, %97
  %132 = getelementptr inbounds [120 x [120 x double]], [120 x [120 x double]]* %2, i64 %93
  %133 = getelementptr inbounds [120 x [120 x double]], [120 x [120 x double]]* %132, i64 0, i64 %88
  %134 = getelementptr inbounds [120 x double], [120 x double]* %133, i64 0, i64 %90
  store double %131, double* %134, align 8
  br label %135

135:                                              ; preds = %84
  br label %82, !llvm.loop !8

136:                                              ; preds = %82
  br label %137

137:                                              ; preds = %136
  %138 = add nsw i32 %.12, 1
  br label %79, !llvm.loop !9

139:                                              ; preds = %79
  br label %140

140:                                              ; preds = %139
  %141 = add nsw i32 %.14, 1
  br label %76, !llvm.loop !10

142:                                              ; preds = %76
  br label %143

143:                                              ; preds = %142
  %144 = add nsw i32 %.05, 1
  br label %5, !llvm.loop !11

145:                                              ; preds = %5
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare double @llvm.fmuladd.f64(double, double, double) #1

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
!7 = distinct !{!7, !5}
!8 = distinct !{!8, !5}
!9 = distinct !{!9, !5}
!10 = distinct !{!10, !5}
!11 = distinct !{!11, !5}
