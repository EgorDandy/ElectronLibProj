#include <iostream> 
#include <string> 
extern "C" {
    __attribute__((visibility("default")))
    __attribute__((used))
    bool compareStrings(const char* str1, const char* str2) { 
        std::string s1(str1); 
        std::string s2(str2); 
        std::cout << "SSSSSSSS========== " << s1 << std::endl << "SSSSSSSSSSSSSS============ " << s2 << std::endl;
        return s1 == s2; 
    } 
}