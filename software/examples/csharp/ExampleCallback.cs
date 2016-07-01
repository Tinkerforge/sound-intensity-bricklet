using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change XYZ to the UID of your Sound Intensity Bricklet

	// Callback function for intensity callback
	static void IntensityCB(BrickletSoundIntensity sender, int intensity)
	{
		Console.WriteLine("Intensity: " + intensity);
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletSoundIntensity si = new BrickletSoundIntensity(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Register intensity callback to function IntensityCB
		si.Intensity += IntensityCB;

		// Set period for intensity callback to 0.05s (50ms)
		// Note: The intensity callback is only called every 0.05 seconds
		//       if the intensity has changed since the last call!
		si.SetIntensityCallbackPeriod(50);

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
