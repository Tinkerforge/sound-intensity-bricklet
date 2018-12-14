package main

import (
	"fmt"
	"tinkerforge/ipconnection"
	"tinkerforge/sound_intensity_bricklet"
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

	si.RegisterIntensityCallback(func(intensity uint16) {
		fmt.Printf("Intensity: %d\n", intensity)
	})

	// Set period for intensity receiver to 0.05s (50ms).
	// Note: The intensity callback is only called every 0.05 seconds
	//       if the intensity has changed since the last call!
	si.SetIntensityCallbackPeriod(50)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
