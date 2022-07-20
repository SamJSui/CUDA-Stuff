#include "suiData.h"
#include "kernel.cuh"

int main (int argc, char** argv) {
    const char* fileName;
    if (argc < 2) {
        std::cerr << "Too few arguments!" << std::endl;
        return 1;
    } else {
        fileName = argv[1];
    }
    
    size_t nRides = 0;
    BikeTrip* trips = parse_data(fileName, trips, &nRides), *d_trips;
    const int trip_bytes = nRides * sizeof(BikeTrip);
    const int stat_bytes = nRides * sizeof(TripStats);
    printf("nRides: %zu\n", nRides);
    TripStats* stats = new TripStats[nRides], *d_stats;

    cudaError_t malloc_trip = cudaMalloc((void**) &d_trips, trip_bytes); // Allocates memory size of buf onto Device
    if (malloc_trip != cudaSuccess){
        printf("%s", cudaGetErrorString( malloc_trip ));
    }else{
        printf("%s\n", "TRIPS: CUDAMALLOC COMPLETE");
    }
    
    cudaError_t malloc_stats = cudaMalloc((void**) &d_stats, stat_bytes); // Allocates memory size of buf onto Device
    if (malloc_stats != cudaSuccess){
        printf("%s", cudaGetErrorString( malloc_stats ));
    }else{
        printf("%s\n", "STATS: CUDAMALLOC STATS COMPLETE");
    }

    cudaError_t tripMemcpyHtoD = cudaMemcpy(d_trips, trips, trip_bytes, cudaMemcpyHostToDevice); // Copies memory from Host to Device
    if (tripMemcpyHtoD != cudaSuccess){
        printf("%s\n", cudaGetErrorString( tripMemcpyHtoD ));
    }else{
        printf("%s\n", "TRIPS: MEMCPY FROM HOST TO DEVICE COMPLETE");
    }

    dim3 nThreads(512, 1, 1); 
    dim3 nBlocks(nRides/nThreads.x, 1, 1);
    calculate_distance<<<nBlocks, nThreads>>>(d_trips, d_stats, nRides);

    cudaError_t err = cudaGetLastError();
    if (err != cudaSuccess) printf("Error: %s\n", cudaGetErrorString(err));

    cudaError_t cudaSync = cudaDeviceSynchronize();
    if (cudaSync != cudaSuccess){
        printf("%s\n", cudaGetErrorString( cudaSync ));
    }else{
        printf("%s\n", "CUDA SYNC SUCCESS");
    }

    cudaError_t statMemcpyDtoH = cudaMemcpy(stats, d_stats, stat_bytes, cudaMemcpyDeviceToHost); // Copies memory from Host to Device
    if (statMemcpyDtoH != cudaSuccess){
        printf("%s\n", cudaGetErrorString( statMemcpyDtoH ));
    }else{
        printf("%s\n", "STATS: MEMCPY FROM DEVICE TO HOST COMPLETE");
    }

    write_to_file(trips, stats, nRides);

    cudaFree(d_trips);
    cudaFree(d_stats);
    delete[] stats;
    delete[] trips;
    return 0;
}