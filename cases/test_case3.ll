; ModuleID = 'test_case3.ll'
source_filename = "../cases/test_case3.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress nofree norecurse nosync nounwind sspstrong uwtable
define noundef i32 @_Z3kmpPcS_PiS0_(i8* nocapture noundef readonly %0, i8* nocapture noundef readonly %1, i32* nocapture noundef %2, i32* nocapture noundef %3) local_unnamed_addr #0 {
  store i32 0, i32* %3, align 4, !tbaa !4
  store i32 0, i32* %2, align 4, !tbaa !4
  %5 = getelementptr i8, i8* %0, i64 1
  %6 = load i8, i8* %5, align 1, !tbaa !8
  %7 = load i8, i8* %0, align 1, !tbaa !8
  %8 = icmp eq i8 %7, %6
  %9 = zext i1 %8 to i32
  %10 = getelementptr i32, i32* %2, i64 1
  store i32 %9, i32* %10, align 4, !tbaa !4
  %11 = getelementptr i8, i8* %0, i64 2
  %12 = load i8, i8* %11, align 1, !tbaa !8
  br i1 %8, label %13, label %24

13:                                               ; preds = %4
  %14 = getelementptr i32, i32* %2, i64 2
  br label %15

15:                                               ; preds = %21, %13
  %16 = phi i32 [ 1, %13 ], [ %22, %21 ]
  %17 = zext i32 %16 to i64
  %18 = getelementptr i8, i8* %0, i64 %17
  %19 = load i8, i8* %18, align 1, !tbaa !8
  %20 = icmp eq i8 %19, %12
  br i1 %20, label %24, label %21

21:                                               ; preds = %15
  %22 = load i32, i32* %14, align 4, !tbaa !4
  %23 = icmp sgt i32 %22, 0
  br i1 %23, label %15, label %24, !llvm.loop !9

24:                                               ; preds = %21, %15, %4
  %25 = phi i32 [ 0, %4 ], [ %16, %15 ], [ %22, %21 ]
  %26 = sext i32 %25 to i64
  %27 = getelementptr i8, i8* %0, i64 %26
  %28 = load i8, i8* %27, align 1, !tbaa !8
  %29 = icmp eq i8 %28, %12
  %30 = zext i1 %29 to i32
  %31 = add i32 %25, %30
  %32 = getelementptr i32, i32* %2, i64 2
  store i32 %31, i32* %32, align 4, !tbaa !4
  %33 = icmp sgt i32 %31, 0
  %34 = getelementptr i8, i8* %0, i64 3
  %35 = load i8, i8* %34, align 1, !tbaa !8
  br i1 %33, label %36, label %47

36:                                               ; preds = %24
  %37 = getelementptr i32, i32* %2, i64 3
  br label %38

38:                                               ; preds = %44, %36
  %39 = phi i32 [ %31, %36 ], [ %45, %44 ]
  %40 = zext i32 %39 to i64
  %41 = getelementptr i8, i8* %0, i64 %40
  %42 = load i8, i8* %41, align 1, !tbaa !8
  %43 = icmp eq i8 %42, %35
  br i1 %43, label %47, label %44

44:                                               ; preds = %38
  %45 = load i32, i32* %37, align 4, !tbaa !4
  %46 = icmp sgt i32 %45, 0
  br i1 %46, label %38, label %47, !llvm.loop !9

47:                                               ; preds = %44, %38, %24
  %48 = phi i32 [ %31, %24 ], [ %39, %38 ], [ %45, %44 ]
  %49 = sext i32 %48 to i64
  %50 = getelementptr i8, i8* %0, i64 %49
  %51 = load i8, i8* %50, align 1, !tbaa !8
  %52 = icmp eq i8 %51, %35
  %53 = zext i1 %52 to i32
  %54 = add i32 %48, %53
  %55 = getelementptr i32, i32* %2, i64 3
  store i32 %54, i32* %55, align 4, !tbaa !4
  br label %56

56:                                               ; preds = %88, %47
  %57 = phi i64 [ 0, %47 ], [ %90, %88 ]
  %58 = phi i32 [ 0, %47 ], [ %89, %88 ]
  %59 = icmp sgt i32 %58, 0
  %60 = getelementptr i8, i8* %1, i64 %57
  %61 = load i8, i8* %60, align 1, !tbaa !8
  br i1 %59, label %62, label %72

62:                                               ; preds = %68, %56
  %63 = phi i32 [ %70, %68 ], [ %58, %56 ]
  %64 = zext i32 %63 to i64
  %65 = getelementptr i8, i8* %0, i64 %64
  %66 = load i8, i8* %65, align 1, !tbaa !8
  %67 = icmp eq i8 %66, %61
  br i1 %67, label %72, label %68

68:                                               ; preds = %62
  %69 = getelementptr i32, i32* %2, i64 %64
  %70 = load i32, i32* %69, align 4, !tbaa !4
  %71 = icmp sgt i32 %70, 0
  br i1 %71, label %62, label %72, !llvm.loop !11

72:                                               ; preds = %68, %62, %56
  %73 = phi i32 [ %58, %56 ], [ %70, %68 ], [ %63, %62 ]
  %74 = sext i32 %73 to i64
  %75 = getelementptr i8, i8* %0, i64 %74
  %76 = load i8, i8* %75, align 1, !tbaa !8
  %77 = icmp eq i8 %76, %61
  %78 = zext i1 %77 to i32
  %79 = add i32 %73, %78
  %80 = icmp sgt i32 %79, 3
  br i1 %80, label %81, label %88

81:                                               ; preds = %72
  %82 = load i32, i32* %3, align 4, !tbaa !4
  %83 = add i32 %82, 1
  store i32 %83, i32* %3, align 4, !tbaa !4
  %84 = add nsw i32 %79, -1
  %85 = zext i32 %84 to i64
  %86 = getelementptr i32, i32* %2, i64 %85
  %87 = load i32, i32* %86, align 4, !tbaa !4
  br label %88

88:                                               ; preds = %81, %72
  %89 = phi i32 [ %87, %81 ], [ %79, %72 ]
  %90 = add nuw nsw i64 %57, 1
  %91 = icmp eq i64 %90, 32411
  br i1 %91, label %92, label %56, !llvm.loop !12

92:                                               ; preds = %88
  ret i32 0
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind sspstrong uwtable "frame-pointer"="none" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="4" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{!"clang version 14.0.0"}
!4 = !{!5, !5, i64 0}
!5 = !{!"int", !6, i64 0}
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C++ TBAA"}
!8 = !{!6, !6, i64 0}
!9 = distinct !{!9, !10}
!10 = !{!"llvm.loop.mustprogress"}
!11 = distinct !{!11, !10}
!12 = distinct !{!12, !10}
