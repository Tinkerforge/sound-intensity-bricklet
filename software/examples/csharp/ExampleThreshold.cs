using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change to your UID

	// Callback for intensity greater than 2000
	static void ReachedCB(BrickletSoundIntensity sender, int intensity)
	{
		System.Console.WriteLine("Intensity: " + intensity);
	}

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletSoundIntensity si = new BrickletSoundIntensity(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 1 seconds (1000ms)
		si.SetDebouncePeriod(1000);

		// Register threshold reached callback to function ReachedCB
		si.IntensityReached += ReachedCB;

		// Configure threshold for "greater than 2000"
		si.SetIntensityCallbackThreshold('>', 2000, 0);

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
