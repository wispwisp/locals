auto t1 = std::chrono::steady_clock::now();

// ...
std::this_thread::sleep_for(std::chrono::seconds(5));

// seconds/milliseconds(1000seconds)/...
auto m = std::chrono::duration_cast<std::chrono::seconds>(std::chrono::steady_clock::now() - t1);
std::cout << m.count() << " seconds\n";

