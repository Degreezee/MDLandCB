#include <iostream>

int main() {
    int a;
    int b;
    std::cin>>a;
    std::cin>>b;

    unsigned char sf = 0;

    __asm__ (
        "test %[val1], %[val2]\n\t"
        "sets %[sf_flag]"
        : [sf_flag] "=r" (sf)
        : [val1] "r" (a), [val2] "r" (b)
        : "cc"
        );

    std::cout << "a = " << a << ", b = " << b << std::endl;
    std::cout << "Sign Flag (SF) after TEST: " << static_cast<int>(sf) << std::endl;

    if (sf)
        std::cout << "SF = 1 (результат отрицательный)" << std::endl;
    else
        std::cout << "SF = 0 (результат неотрицательный)" << std::endl;

    return 0;
}
