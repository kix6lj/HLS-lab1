; ModuleID = 'example.cpp'
source_filename = "example.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress nofree nosync nounwind readnone sspstrong uwtable willreturn
define noundef float @_Z6mysqrtf(float noundef %0) local_unnamed_addr #0 {
  %2 = fmul float %0, 5.000000e-01
  %3 = tail call float @llvm.fabs.f32(float %2) #2
  %4 = fcmp olt float %3, 0x3E7AD7F2A0000000
  br i1 %4, label %5, label %14

5:                                                ; preds = %1, %5
  %6 = phi float [ %10, %5 ], [ %2, %1 ]
  %7 = fmul float %6, 5.000000e-01
  %8 = fmul float %6, 2.000000e+00
  %9 = fdiv float %0, %8
  %10 = fadd float %7, %9
  %11 = fsub float %10, %6
  %12 = tail call float @llvm.fabs.f32(float %11) #2
  %13 = fcmp olt float %12, 0x3E7AD7F2A0000000
  br i1 %13, label %5, label %14, !llvm.loop !4

14:                                               ; preds = %5, %1
  %15 = phi float [ 0.000000e+00, %1 ], [ %6, %5 ]
  ret float %15
}

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare float @llvm.fabs.f32(float) #1

attributes #0 = { mustprogress nofree nosync nounwind readnone sspstrong uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="4" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{!"clang version 14.0.0"}
!4 = distinct !{!4, !5}
!5 = !{!"llvm.loop.mustprogress"}
