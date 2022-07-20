CC = nvcc
CFLAGS = -g -I include

SOURCE_DIR = src
INCLUDE_DIR = include
BUILD_DIR = build

main : 
	$(CC) $(CFLAGS) $(SOURCE_DIR)/*.cu -o Chattanooga-Bike-Trip.bin

run : main
	./Chattanooga-Bike-Trip.bin Bike_Chattanooga_Trip_Data.csv

clean:
	rm -r ./*.bin