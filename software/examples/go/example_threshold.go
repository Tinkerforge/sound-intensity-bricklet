package main

import (
	"fmt"
	"github.com/tinkerforge/go-api-bindings/ipconnection"
	"github.com/tinkerforge/go-api-bindings/sound_intensity_bricklet"
)

const ADDR string = "localhost:4223"
const UID string = "XYZ" // Change XYZ to the UID of your Sound Intensity Bricklet.

func main() {
	ipcon := ipconnection.New()
	defer ipcon.Close()
	si, _ := sound_intensity_bricklet.New(UID, &ipcon) // Create device object.

	ipcon.Connect(ADDR) // Connect to brickd.
	defer ipcon.Disconnect()
	// Don't use device before ipcon is connected.

	// Get threshold receivers with a debounce time of 1 second (1000ms).
	si.SetDebouncePeriod(1000)

	si.RegisterIntensityReachedCallback(func(intensity uint16) {
		fmt.Printf("Intensity: %d\n", intensity)
	})

	// Configure threshold for intensity "greater than 2000".
	si.SetIntensityCallbackThreshold('>', 2000, 0)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
