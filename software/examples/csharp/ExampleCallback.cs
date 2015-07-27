using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change to your UID

	// Callback function for intensity callback
	static void IntensityCB(BrickletSoundIntensity sender, int intensity)
	{
		System.Console.WriteLine("Intensity: " + intensity);
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletSoundIntensity si = new BrickletSoundIntensity(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Set period for intensity callback to 1s (1000ms)
		// Note: The intensity callback is only called every second
		//       if the intensity has changed since the last call!
		si.SetIntensityCallbackPeriod(1000);

		// Register intensity callback to function IntensityCB
		si.Intensity += IntensityCB;

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
