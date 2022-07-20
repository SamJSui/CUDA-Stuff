#include "suiData.h"

BikeTrip* parse_data(const char* fileName, BikeTrip* bTrips, size_t* nRides) {
    std::ifstream ifs(fileName, std::ifstream::in);
    std::string line, point, xpos, ypos;
    std::vector<BikeTrip> trips;

    if (!ifs.is_open()) {
        std::cerr << "File did not open correctly" << std::endl;
        exit(EXIT_FAILURE);
    }

    getline(ifs, line); // Column Names
    int i = 0;
    while (getline(ifs, line)) {
        bool push = true;
        std::stringstream ss(line);
        BikeTrip trip;
        getline(ss, line, ','); // Member Type
        getline(ss, line, ','); // Bike ID
        trip.BikeID = line;
        getline(ss, line, ','); // Start Time
        getline(ss, line, ','); // Start Station Name
        getline(ss, line, ','); // Start Station ID
        getline(ss, line, ','); // Start Location
        
        // START LOCATION
        std::istringstream iss(line);
        iss >> point >> xpos >> ypos;
        try {
            trip.startingX = std::stod(xpos.c_str() + 1);
            trip.startingY = std::stod(ypos.c_str() + 0);
        }
        catch (std::invalid_argument) {
            push = false;
            continue;
        }

        xpos.clear();
        ypos.clear();

        getline(ss, line, ','); // End Time
        getline(ss, line, ','); // End Station Name
        getline(ss, line, ','); // End Station ID
        getline(ss, line, ','); // End Location

        // END LOCATION
        iss.clear();
        iss.str(line);
        iss >> point >> xpos >> ypos;
        
        try {
            trip.endX = std::stod(xpos.c_str() + 1);
            trip.endY = std::stod(ypos.c_str() + 0);
        }
        catch (std::invalid_argument) {
            push = false;
            continue;
        }

        // RIDE TIME
        getline(ss, line, ','); // Trip Duration Min
        trip.rideTime = stod(line);

        if(push) trips.push_back(trip);
        xpos.clear();
        ypos.clear();
        i++;
    }

    // Vector to Array
    *nRides = trips.size();
    bTrips = new BikeTrip[*nRides];
    std::copy(trips.begin(), trips.end(), bTrips);
    ifs.close();
    return bTrips;
}

void write_to_file(BikeTrip* trips, TripStats* stats, int size) {
    std::ofstream ofs;
    ofs.open("output.csv", std::ofstream::out);
    ofs << "BikeID,DistanceInYards,YardsPerMin" << std::endl;
    int idx = 0;
    while (idx < size) {
        if (stats[idx].distanceInYard) {
            ofs << trips[idx].BikeID << "," << stats[idx].distanceInYard << "," << stats[idx].yardPerMin << std::endl;
        }
        idx++;
    }
}