#include <iostream> 
#include <fstream>
#include "suiData.h"

int main (int argc, char** argv) {
    const char* fileName;
    if (argc < 2) {
        std::cerr << "Too few arguments!" << std::endl;
        return 1;
    } else {
        fileName = argv[1];
    }
    parse_data(fileName);
    return 0;
}