#pragma once

#include <iostream>
#include <fstream>
#include <sstream>
#include <iostream>
#include <stdlib.h>
#include <cstring>
#include <vector>
#include <cmath>

class BikeTrip {
    public:
        double startingX;
        double startingY;
        double endX;
        double endY;
        double rideTime;
        std::string BikeID;
};

class TripStats {
    public:
        double distanceInDegrees;
        double yardPerMin;
        double distanceInYard;
};

BikeTrip* parse_data(const char*, BikeTrip*, size_t*);
void write_to_file(BikeTrip*, TripStats*, int);