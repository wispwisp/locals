auto t1 = std::chrono::steady_clock::now();

// ...

using time = std::chrono::milliseconds;
auto m = std::chrono::duration_cast<time>(std::chrono::steady_clock::now() - t1);
std::cout << m.count() << "\n";

