#pragma once

#include <iostream>
#include <fstream>

void parse_data(const char* fileName);

typedef struct {
    double startingPoint;
    double endPoint;
    double rideTime;
} Bike;