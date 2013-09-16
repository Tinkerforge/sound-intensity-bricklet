
#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_sound_intensity.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XYZ" // Change to your UID

// Callback for intensity greater than 2000
void cb_reached(uint16_t intensity, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	printf("Intensity: %d\n", intensity);
}

int main() {
	// Create IP connection
	IPConnection ipcon;
	ipcon_create(&ipcon);

	// Create device object
	SoundIntensity sound_intensity;
	sound_intensity_create(&sound_intensity, UID, &ipcon); 

	// Connect to brickd
	if(ipcon_connect(&ipcon, HOST, PORT) < 0) {
		fprintf(stderr, "Could not connect\n");
		exit(1);
	}
	// Don't use device before ipcon is connected

	// Get threshold callbacks with a debounce time of 1 seconds (1000ms)
	sound_intensity_set_debounce_period(&sound_intensity, 1000);

	// Register threshold reached callback to function cb_reached
	sound_intensity_register_callback(&sound_intensity,
	                                  SOUND_INTENSITY_CALLBACK_INTENSITY_REACHED,
	                                  (void *)cb_reached,
	                                  NULL);

	// Configure threshold for "greater than 2000"
	sound_intensity_set_intensity_callback_threshold(&sound_intensity, '>', 2000, 0);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
}
