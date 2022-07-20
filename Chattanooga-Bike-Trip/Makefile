CC = nvcc
CFLAGS = -g -I include

SOURCE_DIR = src
INCLUDE_DIR = include
BUILD_DIR = build

main : $(BUILD_DIR)

run : main
	./Chattanooga-Bike-Trip Bike_Chattanooga_Trip_Data.csv

clean:
	rm -rf $(BUILD_DIR)

$(BUILD_DIR) : 
	$(CC) $(CFLAGS) $(SOURCE_DIR)/*.cu -o Chattanooga-Bike-Trip