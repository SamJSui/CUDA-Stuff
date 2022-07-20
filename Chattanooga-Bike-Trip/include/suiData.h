#pragma once

#include <iostream>
#include <fstream>
#include <sstream>
#include <iostream>
#include <stdlib.h>
#include <cstring>
#include <vector>

typedef struct {
    double startingX;
    double startingY;
    double endX;
    double endY;
    double rideTime;
} BikeTrip;

std::vector<BikeTrip> parse_data(const char*);