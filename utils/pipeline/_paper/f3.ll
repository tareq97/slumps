; ModuleID = '_paper/f3.c'
source_filename = "_paper/f3.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @g(i32 %a) #0 {
entry:
  %a.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  %0 = load i32, i32* %a.addr, align 4
  %rem = urem i32 %0, 4
  switch i32 %rem, label %sw.epilog [
    i32 0, label %sw.bb
    i32 1, label %sw.bb1
    i32 2, label %sw.bb3
  ]

sw.bb:                                            ; preds = %entry
  %1 = load i32, i32* %a.addr, align 4
  %add = add i32 %1, 3
  store i32 %add, i32* %a.addr, align 4
  br label %sw.epilog

sw.bb1:                                           ; preds = %entry
  %2 = load i32, i32* %a.addr, align 4
  %add2 = add i32 %2, 2
  store i32 %add2, i32* %a.addr, align 4
  br label %sw.epilog

sw.bb3:                                           ; preds = %entry
  %3 = load i32, i32* %a.addr, align 4
  %add4 = add i32 %3, 1
  store i32 %add4, i32* %a.addr, align 4
  br label %sw.epilog

sw.epilog:                                        ; preds = %entry, %sw.bb3, %sw.bb1, %sw.bb
  %4 = load i32, i32* %a.addr, align 4
  %and = and i32 %4, 3
  ret i32 %and
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 8.0.0 (tags/RELEASE_800/final 375507)"}