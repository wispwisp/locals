#include <iomanip>

std::cout << std::fixed << std::setprecision(2) << values[i] << " ";
std::cout << std::setfill('0') << std::setw(5) << 25; // -> output: 00025

