; ModuleID = 'test_case5.ll'
source_filename = "../cases/test_case5.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Triangle_2D = type { i8, i8, i8, i8, i8, i8, i8 }

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z10projection11Triangle_3DP11Triangle_2Di(i64 %0, i8 %1, %struct.Triangle_2D* noundef %2, i32 noundef %3) #0 {
  %.sroa.01.0.extract.trunc = trunc i64 %0 to i8
  %.sroa.4.0.extract.shift = lshr i64 %0, 8
  %.sroa.4.0.extract.trunc = trunc i64 %.sroa.4.0.extract.shift to i8
  %.sroa.7.0.extract.shift = lshr i64 %0, 16
  %.sroa.7.0.extract.trunc = trunc i64 %.sroa.7.0.extract.shift to i8
  %.sroa.10.0.extract.shift = lshr i64 %0, 24
  %.sroa.10.0.extract.trunc = trunc i64 %.sroa.10.0.extract.shift to i8
  %.sroa.13.0.extract.shift = lshr i64 %0, 32
  %.sroa.13.0.extract.trunc = trunc i64 %.sroa.13.0.extract.shift to i8
  %.sroa.16.0.extract.shift = lshr i64 %0, 40
  %.sroa.16.0.extract.trunc = trunc i64 %.sroa.16.0.extract.shift to i8
  %.sroa.19.0.extract.shift = lshr i64 %0, 48
  %.sroa.19.0.extract.trunc = trunc i64 %.sroa.19.0.extract.shift to i8
  %.sroa.22.0.extract.shift = lshr i64 %0, 56
  %.sroa.22.0.extract.trunc = trunc i64 %.sroa.22.0.extract.shift to i8
  %5 = icmp eq i32 %3, 0
  br i1 %5, label %6, label %23

6:                                                ; preds = %4
  %7 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 0
  store i8 %.sroa.01.0.extract.trunc, i8* %7, align 1
  %8 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 1
  store i8 %.sroa.4.0.extract.trunc, i8* %8, align 1
  %9 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 2
  store i8 %.sroa.10.0.extract.trunc, i8* %9, align 1
  %10 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 3
  store i8 %.sroa.13.0.extract.trunc, i8* %10, align 1
  %11 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 4
  store i8 %.sroa.19.0.extract.trunc, i8* %11, align 1
  %12 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 5
  store i8 %.sroa.22.0.extract.trunc, i8* %12, align 1
  %13 = zext i8 %.sroa.7.0.extract.trunc to i32
  %14 = sdiv i32 %13, 3
  %15 = zext i8 %.sroa.16.0.extract.trunc to i32
  %16 = sdiv i32 %15, 3
  %17 = add nsw i32 %14, %16
  %18 = zext i8 %1 to i32
  %19 = sdiv i32 %18, 3
  %20 = add nsw i32 %17, %19
  %21 = trunc i32 %20 to i8
  %22 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 6
  store i8 %21, i8* %22, align 1
  br label %63

23:                                               ; preds = %4
  %24 = icmp eq i32 %3, 1
  br i1 %24, label %25, label %42

25:                                               ; preds = %23
  %26 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 0
  store i8 %.sroa.01.0.extract.trunc, i8* %26, align 1
  %27 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 1
  store i8 %.sroa.7.0.extract.trunc, i8* %27, align 1
  %28 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 2
  store i8 %.sroa.10.0.extract.trunc, i8* %28, align 1
  %29 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 3
  store i8 %.sroa.16.0.extract.trunc, i8* %29, align 1
  %30 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 4
  store i8 %.sroa.19.0.extract.trunc, i8* %30, align 1
  %31 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 5
  store i8 %1, i8* %31, align 1
  %32 = zext i8 %.sroa.4.0.extract.trunc to i32
  %33 = sdiv i32 %32, 3
  %34 = zext i8 %.sroa.13.0.extract.trunc to i32
  %35 = sdiv i32 %34, 3
  %36 = add nsw i32 %33, %35
  %37 = zext i8 %.sroa.22.0.extract.trunc to i32
  %38 = sdiv i32 %37, 3
  %39 = add nsw i32 %36, %38
  %40 = trunc i32 %39 to i8
  %41 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 6
  store i8 %40, i8* %41, align 1
  br label %62

42:                                               ; preds = %23
  %43 = icmp eq i32 %3, 2
  br i1 %43, label %44, label %61

44:                                               ; preds = %42
  %45 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 0
  store i8 %.sroa.7.0.extract.trunc, i8* %45, align 1
  %46 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 1
  store i8 %.sroa.4.0.extract.trunc, i8* %46, align 1
  %47 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 2
  store i8 %.sroa.16.0.extract.trunc, i8* %47, align 1
  %48 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 3
  store i8 %.sroa.13.0.extract.trunc, i8* %48, align 1
  %49 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 4
  store i8 %1, i8* %49, align 1
  %50 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 5
  store i8 %.sroa.22.0.extract.trunc, i8* %50, align 1
  %51 = zext i8 %.sroa.01.0.extract.trunc to i32
  %52 = sdiv i32 %51, 3
  %53 = zext i8 %.sroa.10.0.extract.trunc to i32
  %54 = sdiv i32 %53, 3
  %55 = add nsw i32 %52, %54
  %56 = zext i8 %.sroa.19.0.extract.trunc to i32
  %57 = sdiv i32 %56, 3
  %58 = add nsw i32 %55, %57
  %59 = trunc i32 %58 to i8
  %60 = getelementptr inbounds %struct.Triangle_2D, %struct.Triangle_2D* %2, i32 0, i32 6
  store i8 %59, i8* %60, align 1
  br label %61

61:                                               ; preds = %44, %42
  br label %62

62:                                               ; preds = %61, %25
  br label %63

63:                                               ; preds = %62, %6
  ret void
}

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #1

attributes #0 = { mustprogress noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { argmemonly nofree nounwind willreturn }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{!"clang version 14.0.0"}
