#pragma once

#include "suiData.h"
#include <cuda.h>
#include <cuda_runtime.h>
#include <cuda_runtime_api.h>

__global__
void calculate_distance(BikeTrip* trips, TripStats* stats, int size);