// Test case to reproduce the issue where DebugFunction uses DebugInfoNone instead of DebugFunctionDeclaration
// for the Declaration operand when there's no separate function declaration.
// This should cause spirv-val to fail with an error about the Declaration operand
// not being a DebugFunctionDeclaration result ID.

// RUN: %clang_cc1 %s -emit-llvm-bc -triple spir -debug-info-kind=limited -O0 -o - | llvm-spirv -o %t.spv
// RUN: spirv-val %t.spv 2>&1 | FileCheck %s --check-prefix=CHECK-SPIRV-VAL-ERROR

// This test should fail spirv-val validation due to the bug
// CHECK-SPIRV-VAL-ERROR: error: Declaration operand {{.*}} must be a DebugFunctionDeclaration

int test_function(int x) {
    return x + 1;
}

void kernel test_kernel() {
    int result = test_function(42);
} 