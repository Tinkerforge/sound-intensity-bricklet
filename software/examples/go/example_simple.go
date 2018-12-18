package main

import (
	"fmt"
	"github.com/Tinkerforge/go-api-bindings/ipconnection"
	"github.com/Tinkerforge/go-api-bindings/sound_intensity_bricklet"
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

	// Get current intensity.
	intensity, _ := si.GetIntensity()
	fmt.Printf("Intensity: \n", intensity)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
