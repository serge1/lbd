; RUN: llc  -march=cpu0el -mcpu=cpu032II -relocation-model=pic -O3 < %s | FileCheck %s -check-prefix=16

@iiii = global i64 5, align 8
@jjjj = global i64 -6, align 8
@kkkk = common global i64 0, align 8

define void @test() nounwind {
entry:
  %0 = load i64, i64* @iiii, align 8
  %1 = load i64, i64* @jjjj, align 8
  %mul = mul nsw i64 %1, %0
  store i64 %mul, i64* @kkkk, align 8
; 16:	multu	${{[0-9]+|t9}}, ${{[0-9]+|t9}}
; 16: 	mflo	${{[0-9]+|t9}}
; 16: 	mfhi	${{[0-9]+|t9}}
; 16:	mul	${{[0-9]+|t9}}, ${{[0-9]+|t9}}
; 16:	mul	${{[0-9]+|t9}}, ${{[0-9]+|t9}}

  ret void
}
