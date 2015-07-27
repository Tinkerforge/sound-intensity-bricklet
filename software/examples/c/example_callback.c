#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_sound_intensity.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XYZ" // Change to your UID

// Callback function for intensity callback
void cb_intensity(uint16_t intensity, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	printf("Intensity: %d\n", intensity);
}

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

	// Set period for intensity callback to 1s (1000ms)
	// Note: The intensity callback is only called every second
	//       if the intensity has changed since the last call!
	sound_intensity_set_intensity_callback_period(&si, 1000);

	// Register intensity callback to function cb_intensity
	sound_intensity_register_callback(&si,
	                                  SOUND_INTENSITY_CALLBACK_INTENSITY,
	                                  (void *)cb_intensity,
	                                  NULL);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
}
