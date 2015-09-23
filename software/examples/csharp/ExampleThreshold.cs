using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change to your UID

	// Callback function for intensity reached callback
	static void IntensityReachedCB(BrickletSoundIntensity sender, int intensity)
	{
		Console.WriteLine("Intensity: " + intensity);
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletSoundIntensity si = new BrickletSoundIntensity(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 1 second (1000ms)
		si.SetDebouncePeriod(1000);

		// Register intensity reached callback to function IntensityReachedCB
		si.IntensityReached += IntensityReachedCB;

		// Configure threshold for intensity "greater than 2000"
		si.SetIntensityCallbackThreshold('>', 2000, 0);

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
