; ModuleID = 'test_case9.ll'
source_filename = "../cases/test_case9.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: mustprogress noinline nounwind uwtable
define dso_local void @_Z14update_weightsPdS_S_S_S_S_S_S_S_S_S_S_(double* noundef %0, double* noundef %1, double* noundef %2, double* noundef %3, double* noundef %4, double* noundef %5, double* noundef %6, double* noundef %7, double* noundef %8, double* noundef %9, double* noundef %10, double* noundef %11) #0 {
  br label %13

13:                                               ; preds = %59, %12
  %.010 = phi i32 [ 0, %12 ], [ %60, %59 ]
  %.01 = phi double [ 0.000000e+00, %12 ], [ %.12, %59 ]
  %14 = icmp slt i32 %.010, 13
  br i1 %14, label %15, label %61

15:                                               ; preds = %13, %17
  %.04 = phi i32 [ %58, %17 ], [ 0, %13 ]
  %.12 = phi double [ %57, %17 ], [ %.01, %13 ]
  %16 = icmp ult i32 %.04, 64
  br i1 %16, label %17, label %59

17:                                               ; preds = %15
  %18 = mul nsw i32 %.010, 64
  %19 = add nuw nsw i32 %18, %.04
  %20 = sext i32 %19 to i64
  %21 = getelementptr inbounds double, double* %3, i64 %20
  %22 = load double, double* %21, align 8
  %23 = getelementptr inbounds double, double* %0, i64 %20
  %24 = load double, double* %23, align 8
  %25 = fneg double %22
  %26 = call double @llvm.fmuladd.f64(double %25, double 1.000000e-02, double %24)
  store double %26, double* %23, align 8
  %27 = call double @llvm.fmuladd.f64(double %26, double %26, double %.12)
  %28 = add nuw nsw i32 %.04, 1
  %29 = add nuw nsw i32 %18, %28
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds double, double* %3, i64 %30
  %32 = load double, double* %31, align 8
  %33 = getelementptr inbounds double, double* %0, i64 %30
  %34 = load double, double* %33, align 8
  %35 = fneg double %32
  %36 = call double @llvm.fmuladd.f64(double %35, double 1.000000e-02, double %34)
  store double %36, double* %33, align 8
  %37 = call double @llvm.fmuladd.f64(double %36, double %36, double %27)
  %38 = add nuw nsw i32 %28, 1
  %39 = add nuw nsw i32 %18, %38
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds double, double* %3, i64 %40
  %42 = load double, double* %41, align 8
  %43 = getelementptr inbounds double, double* %0, i64 %40
  %44 = load double, double* %43, align 8
  %45 = fneg double %42
  %46 = call double @llvm.fmuladd.f64(double %45, double 1.000000e-02, double %44)
  store double %46, double* %43, align 8
  %47 = call double @llvm.fmuladd.f64(double %46, double %46, double %37)
  %48 = add nuw nsw i32 %38, 1
  %49 = add nuw nsw i32 %18, %48
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds double, double* %3, i64 %50
  %52 = load double, double* %51, align 8
  %53 = getelementptr inbounds double, double* %0, i64 %50
  %54 = load double, double* %53, align 8
  %55 = fneg double %52
  %56 = call double @llvm.fmuladd.f64(double %55, double 1.000000e-02, double %54)
  store double %56, double* %53, align 8
  %57 = call double @llvm.fmuladd.f64(double %56, double %56, double %47)
  %58 = add nuw nsw i32 %48, 1
  br label %15, !llvm.loop !4

59:                                               ; preds = %15
  %60 = add nsw i32 %.010, 1
  br label %13, !llvm.loop !7

61:                                               ; preds = %13, %63
  %.111 = phi i32 [ %99, %63 ], [ 0, %13 ]
  %.0 = phi double [ %98, %63 ], [ 0.000000e+00, %13 ]
  %62 = icmp ult i32 %.111, 64
  br i1 %62, label %63, label %100

63:                                               ; preds = %61
  %64 = sext i32 %.111 to i64
  %65 = getelementptr inbounds double, double* %9, i64 %64
  %66 = load double, double* %65, align 8
  %67 = getelementptr inbounds double, double* %6, i64 %64
  %68 = load double, double* %67, align 8
  %69 = fneg double %66
  %70 = call double @llvm.fmuladd.f64(double %69, double 1.000000e-02, double %68)
  store double %70, double* %67, align 8
  %71 = call double @llvm.fmuladd.f64(double %70, double %70, double %.0)
  %72 = add nuw nsw i32 %.111, 1
  %73 = sext i32 %72 to i64
  %74 = getelementptr inbounds double, double* %9, i64 %73
  %75 = load double, double* %74, align 8
  %76 = getelementptr inbounds double, double* %6, i64 %73
  %77 = load double, double* %76, align 8
  %78 = fneg double %75
  %79 = call double @llvm.fmuladd.f64(double %78, double 1.000000e-02, double %77)
  store double %79, double* %76, align 8
  %80 = call double @llvm.fmuladd.f64(double %79, double %79, double %71)
  %81 = add nuw nsw i32 %72, 1
  %82 = sext i32 %81 to i64
  %83 = getelementptr inbounds double, double* %9, i64 %82
  %84 = load double, double* %83, align 8
  %85 = getelementptr inbounds double, double* %6, i64 %82
  %86 = load double, double* %85, align 8
  %87 = fneg double %84
  %88 = call double @llvm.fmuladd.f64(double %87, double 1.000000e-02, double %86)
  store double %88, double* %85, align 8
  %89 = call double @llvm.fmuladd.f64(double %88, double %88, double %80)
  %90 = add nuw nsw i32 %81, 1
  %91 = sext i32 %90 to i64
  %92 = getelementptr inbounds double, double* %9, i64 %91
  %93 = load double, double* %92, align 8
  %94 = getelementptr inbounds double, double* %6, i64 %91
  %95 = load double, double* %94, align 8
  %96 = fneg double %93
  %97 = call double @llvm.fmuladd.f64(double %96, double 1.000000e-02, double %95)
  store double %97, double* %94, align 8
  %98 = call double @llvm.fmuladd.f64(double %97, double %97, double %89)
  %99 = add nuw nsw i32 %90, 1
  br label %61, !llvm.loop !8

100:                                              ; preds = %61
  %101 = call double @sqrt(double noundef %.01) #3
  %102 = call double @sqrt(double noundef %.0) #3
  br label %103

103:                                              ; preds = %133, %100
  %.212 = phi i32 [ 0, %100 ], [ %134, %133 ]
  %104 = icmp slt i32 %.212, 13
  br i1 %104, label %105, label %135

105:                                              ; preds = %103, %107
  %.15 = phi i32 [ %132, %107 ], [ 0, %103 ]
  %106 = icmp ult i32 %.15, 64
  br i1 %106, label %107, label %133

107:                                              ; preds = %105
  %108 = mul nsw i32 %.212, 64
  %109 = add nuw nsw i32 %108, %.15
  %110 = sext i32 %109 to i64
  %111 = getelementptr inbounds double, double* %0, i64 %110
  %112 = load double, double* %111, align 8
  %113 = fdiv double %112, %101
  store double %113, double* %111, align 8
  %114 = add nuw nsw i32 %.15, 1
  %115 = add nuw nsw i32 %108, %114
  %116 = sext i32 %115 to i64
  %117 = getelementptr inbounds double, double* %0, i64 %116
  %118 = load double, double* %117, align 8
  %119 = fdiv double %118, %101
  store double %119, double* %117, align 8
  %120 = add nuw nsw i32 %114, 1
  %121 = add nuw nsw i32 %108, %120
  %122 = sext i32 %121 to i64
  %123 = getelementptr inbounds double, double* %0, i64 %122
  %124 = load double, double* %123, align 8
  %125 = fdiv double %124, %101
  store double %125, double* %123, align 8
  %126 = add nuw nsw i32 %120, 1
  %127 = add nuw nsw i32 %108, %126
  %128 = sext i32 %127 to i64
  %129 = getelementptr inbounds double, double* %0, i64 %128
  %130 = load double, double* %129, align 8
  %131 = fdiv double %130, %101
  store double %131, double* %129, align 8
  %132 = add nuw nsw i32 %126, 1
  br label %105, !llvm.loop !9

133:                                              ; preds = %105
  %134 = add nsw i32 %.212, 1
  br label %103, !llvm.loop !10

135:                                              ; preds = %103, %137
  %.313 = phi i32 [ %157, %137 ], [ 0, %103 ]
  %136 = icmp ult i32 %.313, 64
  br i1 %136, label %137, label %158

137:                                              ; preds = %135
  %138 = sext i32 %.313 to i64
  %139 = getelementptr inbounds double, double* %6, i64 %138
  %140 = load double, double* %139, align 8
  %141 = fdiv double %140, %102
  store double %141, double* %139, align 8
  %142 = add nuw nsw i32 %.313, 1
  %143 = sext i32 %142 to i64
  %144 = getelementptr inbounds double, double* %6, i64 %143
  %145 = load double, double* %144, align 8
  %146 = fdiv double %145, %102
  store double %146, double* %144, align 8
  %147 = add nuw nsw i32 %142, 1
  %148 = sext i32 %147 to i64
  %149 = getelementptr inbounds double, double* %6, i64 %148
  %150 = load double, double* %149, align 8
  %151 = fdiv double %150, %102
  store double %151, double* %149, align 8
  %152 = add nuw nsw i32 %147, 1
  %153 = sext i32 %152 to i64
  %154 = getelementptr inbounds double, double* %6, i64 %153
  %155 = load double, double* %154, align 8
  %156 = fdiv double %155, %102
  store double %156, double* %154, align 8
  %157 = add nuw nsw i32 %152, 1
  br label %135, !llvm.loop !11

158:                                              ; preds = %135, %204
  %.414 = phi i32 [ %205, %204 ], [ 0, %135 ]
  %.23 = phi double [ %.3, %204 ], [ 0.000000e+00, %135 ]
  %159 = icmp slt i32 %.414, 64
  br i1 %159, label %160, label %206

160:                                              ; preds = %158, %162
  %.26 = phi i32 [ %203, %162 ], [ 0, %158 ]
  %.3 = phi double [ %202, %162 ], [ %.23, %158 ]
  %161 = icmp ult i32 %.26, 64
  br i1 %161, label %162, label %204

162:                                              ; preds = %160
  %163 = mul nsw i32 %.414, 64
  %164 = add nuw nsw i32 %163, %.26
  %165 = sext i32 %164 to i64
  %166 = getelementptr inbounds double, double* %4, i64 %165
  %167 = load double, double* %166, align 8
  %168 = getelementptr inbounds double, double* %1, i64 %165
  %169 = load double, double* %168, align 8
  %170 = fneg double %167
  %171 = call double @llvm.fmuladd.f64(double %170, double 1.000000e-02, double %169)
  store double %171, double* %168, align 8
  %172 = call double @llvm.fmuladd.f64(double %171, double %171, double %.3)
  %173 = add nuw nsw i32 %.26, 1
  %174 = add nuw nsw i32 %163, %173
  %175 = sext i32 %174 to i64
  %176 = getelementptr inbounds double, double* %4, i64 %175
  %177 = load double, double* %176, align 8
  %178 = getelementptr inbounds double, double* %1, i64 %175
  %179 = load double, double* %178, align 8
  %180 = fneg double %177
  %181 = call double @llvm.fmuladd.f64(double %180, double 1.000000e-02, double %179)
  store double %181, double* %178, align 8
  %182 = call double @llvm.fmuladd.f64(double %181, double %181, double %172)
  %183 = add nuw nsw i32 %173, 1
  %184 = add nuw nsw i32 %163, %183
  %185 = sext i32 %184 to i64
  %186 = getelementptr inbounds double, double* %4, i64 %185
  %187 = load double, double* %186, align 8
  %188 = getelementptr inbounds double, double* %1, i64 %185
  %189 = load double, double* %188, align 8
  %190 = fneg double %187
  %191 = call double @llvm.fmuladd.f64(double %190, double 1.000000e-02, double %189)
  store double %191, double* %188, align 8
  %192 = call double @llvm.fmuladd.f64(double %191, double %191, double %182)
  %193 = add nuw nsw i32 %183, 1
  %194 = add nuw nsw i32 %163, %193
  %195 = sext i32 %194 to i64
  %196 = getelementptr inbounds double, double* %4, i64 %195
  %197 = load double, double* %196, align 8
  %198 = getelementptr inbounds double, double* %1, i64 %195
  %199 = load double, double* %198, align 8
  %200 = fneg double %197
  %201 = call double @llvm.fmuladd.f64(double %200, double 1.000000e-02, double %199)
  store double %201, double* %198, align 8
  %202 = call double @llvm.fmuladd.f64(double %201, double %201, double %192)
  %203 = add nuw nsw i32 %193, 1
  br label %160, !llvm.loop !12

204:                                              ; preds = %160
  %205 = add nsw i32 %.414, 1
  br label %158, !llvm.loop !13

206:                                              ; preds = %158, %208
  %.515 = phi i32 [ %244, %208 ], [ 0, %158 ]
  %.1 = phi double [ %243, %208 ], [ 0.000000e+00, %158 ]
  %207 = icmp ult i32 %.515, 64
  br i1 %207, label %208, label %245

208:                                              ; preds = %206
  %209 = sext i32 %.515 to i64
  %210 = getelementptr inbounds double, double* %10, i64 %209
  %211 = load double, double* %210, align 8
  %212 = getelementptr inbounds double, double* %7, i64 %209
  %213 = load double, double* %212, align 8
  %214 = fneg double %211
  %215 = call double @llvm.fmuladd.f64(double %214, double 1.000000e-02, double %213)
  store double %215, double* %212, align 8
  %216 = call double @llvm.fmuladd.f64(double %215, double %215, double %.1)
  %217 = add nuw nsw i32 %.515, 1
  %218 = sext i32 %217 to i64
  %219 = getelementptr inbounds double, double* %10, i64 %218
  %220 = load double, double* %219, align 8
  %221 = getelementptr inbounds double, double* %7, i64 %218
  %222 = load double, double* %221, align 8
  %223 = fneg double %220
  %224 = call double @llvm.fmuladd.f64(double %223, double 1.000000e-02, double %222)
  store double %224, double* %221, align 8
  %225 = call double @llvm.fmuladd.f64(double %224, double %224, double %216)
  %226 = add nuw nsw i32 %217, 1
  %227 = sext i32 %226 to i64
  %228 = getelementptr inbounds double, double* %10, i64 %227
  %229 = load double, double* %228, align 8
  %230 = getelementptr inbounds double, double* %7, i64 %227
  %231 = load double, double* %230, align 8
  %232 = fneg double %229
  %233 = call double @llvm.fmuladd.f64(double %232, double 1.000000e-02, double %231)
  store double %233, double* %230, align 8
  %234 = call double @llvm.fmuladd.f64(double %233, double %233, double %225)
  %235 = add nuw nsw i32 %226, 1
  %236 = sext i32 %235 to i64
  %237 = getelementptr inbounds double, double* %10, i64 %236
  %238 = load double, double* %237, align 8
  %239 = getelementptr inbounds double, double* %7, i64 %236
  %240 = load double, double* %239, align 8
  %241 = fneg double %238
  %242 = call double @llvm.fmuladd.f64(double %241, double 1.000000e-02, double %240)
  store double %242, double* %239, align 8
  %243 = call double @llvm.fmuladd.f64(double %242, double %242, double %234)
  %244 = add nuw nsw i32 %235, 1
  br label %206, !llvm.loop !14

245:                                              ; preds = %206
  %246 = call double @sqrt(double noundef %.23) #3
  %247 = call double @sqrt(double noundef %.1) #3
  br label %248

248:                                              ; preds = %278, %245
  %.6 = phi i32 [ 0, %245 ], [ %279, %278 ]
  %249 = icmp slt i32 %.6, 64
  br i1 %249, label %250, label %280

250:                                              ; preds = %248, %252
  %.37 = phi i32 [ %277, %252 ], [ 0, %248 ]
  %251 = icmp ult i32 %.37, 64
  br i1 %251, label %252, label %278

252:                                              ; preds = %250
  %253 = mul nsw i32 %.6, 64
  %254 = add nuw nsw i32 %253, %.37
  %255 = sext i32 %254 to i64
  %256 = getelementptr inbounds double, double* %1, i64 %255
  %257 = load double, double* %256, align 8
  %258 = fdiv double %257, %246
  store double %258, double* %256, align 8
  %259 = add nuw nsw i32 %.37, 1
  %260 = add nuw nsw i32 %253, %259
  %261 = sext i32 %260 to i64
  %262 = getelementptr inbounds double, double* %1, i64 %261
  %263 = load double, double* %262, align 8
  %264 = fdiv double %263, %246
  store double %264, double* %262, align 8
  %265 = add nuw nsw i32 %259, 1
  %266 = add nuw nsw i32 %253, %265
  %267 = sext i32 %266 to i64
  %268 = getelementptr inbounds double, double* %1, i64 %267
  %269 = load double, double* %268, align 8
  %270 = fdiv double %269, %246
  store double %270, double* %268, align 8
  %271 = add nuw nsw i32 %265, 1
  %272 = add nuw nsw i32 %253, %271
  %273 = sext i32 %272 to i64
  %274 = getelementptr inbounds double, double* %1, i64 %273
  %275 = load double, double* %274, align 8
  %276 = fdiv double %275, %246
  store double %276, double* %274, align 8
  %277 = add nuw nsw i32 %271, 1
  br label %250, !llvm.loop !15

278:                                              ; preds = %250
  %279 = add nsw i32 %.6, 1
  br label %248, !llvm.loop !16

280:                                              ; preds = %248, %282
  %.7 = phi i32 [ %302, %282 ], [ 0, %248 ]
  %281 = icmp ult i32 %.7, 64
  br i1 %281, label %282, label %303

282:                                              ; preds = %280
  %283 = sext i32 %.7 to i64
  %284 = getelementptr inbounds double, double* %7, i64 %283
  %285 = load double, double* %284, align 8
  %286 = fdiv double %285, %247
  store double %286, double* %284, align 8
  %287 = add nuw nsw i32 %.7, 1
  %288 = sext i32 %287 to i64
  %289 = getelementptr inbounds double, double* %7, i64 %288
  %290 = load double, double* %289, align 8
  %291 = fdiv double %290, %247
  store double %291, double* %289, align 8
  %292 = add nuw nsw i32 %287, 1
  %293 = sext i32 %292 to i64
  %294 = getelementptr inbounds double, double* %7, i64 %293
  %295 = load double, double* %294, align 8
  %296 = fdiv double %295, %247
  store double %296, double* %294, align 8
  %297 = add nuw nsw i32 %292, 1
  %298 = sext i32 %297 to i64
  %299 = getelementptr inbounds double, double* %7, i64 %298
  %300 = load double, double* %299, align 8
  %301 = fdiv double %300, %247
  store double %301, double* %299, align 8
  %302 = add nuw nsw i32 %297, 1
  br label %280, !llvm.loop !17

303:                                              ; preds = %280, %305
  %.8 = phi i32 [ %333, %305 ], [ 0, %280 ]
  %.4 = phi double [ %332, %305 ], [ 0.000000e+00, %280 ]
  %304 = icmp slt i32 %.8, 64
  br i1 %304, label %305, label %334

305:                                              ; preds = %303
  %306 = mul nsw i32 %.8, 3
  %307 = sext i32 %306 to i64
  %308 = getelementptr inbounds double, double* %5, i64 %307
  %309 = load double, double* %308, align 8
  %310 = getelementptr inbounds double, double* %2, i64 %307
  %311 = load double, double* %310, align 8
  %312 = fneg double %309
  %313 = call double @llvm.fmuladd.f64(double %312, double 1.000000e-02, double %311)
  store double %313, double* %310, align 8
  %314 = call double @llvm.fmuladd.f64(double %313, double %313, double %.4)
  %315 = add nsw i32 %306, 1
  %316 = sext i32 %315 to i64
  %317 = getelementptr inbounds double, double* %5, i64 %316
  %318 = load double, double* %317, align 8
  %319 = getelementptr inbounds double, double* %2, i64 %316
  %320 = load double, double* %319, align 8
  %321 = fneg double %318
  %322 = call double @llvm.fmuladd.f64(double %321, double 1.000000e-02, double %320)
  store double %322, double* %319, align 8
  %323 = call double @llvm.fmuladd.f64(double %322, double %322, double %314)
  %324 = add nsw i32 %306, 2
  %325 = sext i32 %324 to i64
  %326 = getelementptr inbounds double, double* %5, i64 %325
  %327 = load double, double* %326, align 8
  %328 = getelementptr inbounds double, double* %2, i64 %325
  %329 = load double, double* %328, align 8
  %330 = fneg double %327
  %331 = call double @llvm.fmuladd.f64(double %330, double 1.000000e-02, double %329)
  store double %331, double* %328, align 8
  %332 = call double @llvm.fmuladd.f64(double %331, double %331, double %323)
  %333 = add nsw i32 %.8, 1
  br label %303, !llvm.loop !18

334:                                              ; preds = %303
  %335 = load double, double* %11, align 8
  %336 = load double, double* %8, align 8
  %337 = fneg double %335
  %338 = call double @llvm.fmuladd.f64(double %337, double 1.000000e-02, double %336)
  store double %338, double* %8, align 8
  %339 = call double @llvm.fmuladd.f64(double %338, double %338, double 0.000000e+00)
  %340 = getelementptr inbounds double, double* %11, i64 1
  %341 = load double, double* %340, align 8
  %342 = getelementptr inbounds double, double* %8, i64 1
  %343 = load double, double* %342, align 8
  %344 = fneg double %341
  %345 = call double @llvm.fmuladd.f64(double %344, double 1.000000e-02, double %343)
  store double %345, double* %342, align 8
  %346 = call double @llvm.fmuladd.f64(double %345, double %345, double %339)
  %347 = getelementptr inbounds double, double* %11, i64 2
  %348 = load double, double* %347, align 8
  %349 = getelementptr inbounds double, double* %8, i64 2
  %350 = load double, double* %349, align 8
  %351 = fneg double %348
  %352 = call double @llvm.fmuladd.f64(double %351, double 1.000000e-02, double %350)
  store double %352, double* %349, align 8
  %353 = call double @llvm.fmuladd.f64(double %352, double %352, double %346)
  %354 = call double @sqrt(double noundef %.4) #3
  %355 = call double @sqrt(double noundef %353) #3
  br label %356

356:                                              ; preds = %358, %334
  %.10 = phi i32 [ 0, %334 ], [ %374, %358 ]
  %357 = icmp slt i32 %.10, 64
  br i1 %357, label %358, label %375

358:                                              ; preds = %356
  %359 = mul nsw i32 %.10, 3
  %360 = sext i32 %359 to i64
  %361 = getelementptr inbounds double, double* %2, i64 %360
  %362 = load double, double* %361, align 8
  %363 = fdiv double %362, %354
  store double %363, double* %361, align 8
  %364 = add nsw i32 %359, 1
  %365 = sext i32 %364 to i64
  %366 = getelementptr inbounds double, double* %2, i64 %365
  %367 = load double, double* %366, align 8
  %368 = fdiv double %367, %354
  store double %368, double* %366, align 8
  %369 = add nsw i32 %359, 2
  %370 = sext i32 %369 to i64
  %371 = getelementptr inbounds double, double* %2, i64 %370
  %372 = load double, double* %371, align 8
  %373 = fdiv double %372, %354
  store double %373, double* %371, align 8
  %374 = add nsw i32 %.10, 1
  br label %356, !llvm.loop !19

375:                                              ; preds = %356
  %376 = load double, double* %8, align 8
  %377 = fdiv double %376, %355
  store double %377, double* %8, align 8
  %378 = load double, double* %342, align 8
  %379 = fdiv double %378, %355
  store double %379, double* %342, align 8
  %380 = load double, double* %349, align 8
  %381 = fdiv double %380, %355
  store double %381, double* %349, align 8
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare double @llvm.fmuladd.f64(double, double, double) #1

; Function Attrs: nounwind
declare dso_local double @sqrt(double noundef) #2

attributes #0 = { mustprogress noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"uwtable", i32 1}
!2 = !{i32 7, !"frame-pointer", i32 2}
!3 = !{!"clang version 14.0.0"}
!4 = distinct !{!4, !5, !6}
!5 = !{!"llvm.loop.mustprogress"}
!6 = !{!"llvm.loop.unroll.disable"}
!7 = distinct !{!7, !5}
!8 = distinct !{!8, !5, !6}
!9 = distinct !{!9, !5, !6}
!10 = distinct !{!10, !5}
!11 = distinct !{!11, !5, !6}
!12 = distinct !{!12, !5, !6}
!13 = distinct !{!13, !5}
!14 = distinct !{!14, !5, !6}
!15 = distinct !{!15, !5, !6}
!16 = distinct !{!16, !5}
!17 = distinct !{!17, !5, !6}
!18 = distinct !{!18, !5}
!19 = distinct !{!19, !5}
