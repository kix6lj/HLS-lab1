; ModuleID = 'test_case2.ll'
source_filename = "../cases/test_case2.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress nofree nosync nounwind readnone sspstrong uwtable willreturn
define noundef i32 @_Z11pollard_rhoiii(i32 noundef %0, i32 noundef %1, i32 noundef %2) local_unnamed_addr #0 {
  br label %4

4:                                                ; preds = %22, %3
  %5 = phi i32 [ %2, %3 ], [ %12, %22 ]
  %6 = phi i32 [ %1, %3 ], [ %8, %22 ]
  %7 = mul i32 %6, %6
  %8 = add i32 %7, 1
  %9 = mul i32 %5, %5
  %10 = add i32 %9, 1
  %11 = mul i32 %10, %10
  %12 = add i32 %11, 1
  %13 = sub i32 %8, %12
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %22, label %15

15:                                               ; preds = %4
  %16 = tail call i32 @llvm.abs.i32(i32 %13, i1 true)
  br label %17

17:                                               ; preds = %17, %15
  %18 = phi i32 [ %20, %17 ], [ %16, %15 ]
  %19 = phi i32 [ %18, %17 ], [ %0, %15 ]
  %20 = srem i32 %19, %18
  %21 = icmp eq i32 %20, 0
  br i1 %21, label %22, label %17, !llvm.loop !4

22:                                               ; preds = %17, %4
  %23 = phi i32 [ %0, %4 ], [ %18, %17 ]
  %24 = icmp eq i32 %23, 1
  br i1 %24, label %4, label %25, !llvm.loop !6

25:                                               ; preds = %22
  %26 = icmp eq i32 %23, %0
  %27 = select i1 %26, i32 0, i32 %23
  ret i32 %27
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.abs.i32(i32, i1 immarg) #1

attributes #0 = { mustprogress nofree nosync nounwind readnone sspstrong uwtable willreturn "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="4" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{!"clang version 14.0.0"}
!4 = distinct !{!4, !5}
!5 = !{!"llvm.loop.mustprogress"}
!6 = distinct !{!6, !5}
