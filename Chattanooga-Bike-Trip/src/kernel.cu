#include "kernel.cuh"

__global__
void calculate_distance(BikeTrip* trips, TripStats* stats, int size) {
    int idx = threadIdx.x + blockDim.x * blockIdx.x;
    if (idx < size) {
        double dx = trips[idx].endX - trips[idx].startingX;
        double dy = trips[idx].endY - trips[idx].startingY;
        dx = dx * (1000/9) * 3280.4 / 3; // Longitude/Latitude to km
        dy = dy * (1000/9) * 3280.4 / 3;
        stats[idx].distanceInYard = sqrt(pow(dx,2)+pow(dy,2));
        stats[idx].yardPerMin = stats[idx].distanceInYard / trips[idx].rideTime;
    }
}