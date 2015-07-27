#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_sound_intensity.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XYZ" // Change to your UID

int main() {
	// Create IP connection
	IPConnection ipcon;
	ipcon_create(&ipcon);

	// Create device object
	SoundIntensity si;
	sound_intensity_create(&si, UID, &ipcon);

	// Connect to brickd
	if(ipcon_connect(&ipcon, HOST, PORT) < 0) {
		fprintf(stderr, "Could not connect\n");
		exit(1);
	}
	// Don't use device before ipcon is connected

	// Get current intensity
	uint16_t intensity;
	if(sound_intensity_get_intensity(&si, &intensity) < 0) {
		fprintf(stderr, "Could not get intensity, probably timeout\n");
		exit(1);
	}

	printf("Intensity: %d\n", intensity);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
}
