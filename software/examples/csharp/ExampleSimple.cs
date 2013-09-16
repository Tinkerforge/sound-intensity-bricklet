using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change to your UID

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletSoundIntensity si = new BrickletSoundIntensity(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get current intensity
		int intensity = si.GetIntensity();

		System.Console.WriteLine("Intensity: " + intensity);

		System.Console.WriteLine("Press key to exit");
		System.Console.ReadKey();
		ipcon.Disconnect();
	}
}
