#include "suiData.h"

std::vector<BikeTrip> parse_data(const char* fileName) {
    std::ifstream ifs(fileName, std::ifstream::in);
    std::string line, point, xpos, ypos;
    std::vector<BikeTrip> trips;
    
    if (!ifs.is_open()) {
        std::cerr << "File did not open correctly" << std::endl;
        exit(EXIT_FAILURE);
    }

    getline(ifs, line); // Column Names

    while (getline(ifs, line)) {
        std::stringstream ss(line);
        BikeTrip trip;
        getline(ss, line, ','); // Member Type
        getline(ss, line, ','); // Bike ID
        getline(ss, line, ','); // Start Time
        getline(ss, line, ','); // Start Station Name
        getline(ss, line, ','); // Start Station ID
        getline(ss, line, ','); // Start Location
        
        // START LOCATION
        std::istringstream iss(line);
        iss >> point >> xpos >> ypos;
        trip.startingX = atof(xpos.c_str() + 1);
        trip.startingY = atof(ypos.c_str() + 0);

        getline(ss, line, ','); // End Time
        getline(ss, line, ','); // End Station Name
        getline(ss, line, ','); // End Station ID
        getline(ss, line, ','); // End Location
        
        // END LOCATION
        iss.clear();
        iss.str(line);
        iss >> point >> xpos >> ypos;
        trip.endX = atof(xpos.c_str() + 1);
        trip.endY = atof(ypos.c_str() + 0);
        
        // RIDE TIME
        getline(ss, line, ','); // Trip Duration Min
        trip.rideTime = stof(line);

        trips.push_back(trip);
    }
    return trips;
}