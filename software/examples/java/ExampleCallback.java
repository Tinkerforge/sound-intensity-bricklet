import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletSoundIntensity;

public class ExampleCallback {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;

	// Change XYZ to the UID of your Sound Intensity Bricklet
	private static final String UID = "XYZ";

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions
	//       you might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletSoundIntensity si = new BrickletSoundIntensity(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Add intensity listener
		si.addIntensityListener(new BrickletSoundIntensity.IntensityListener() {
			public void intensity(int intensity) {
				System.out.println("Intensity: " + intensity);
			}
		});

		// Set period for intensity callback to 0.05s (50ms)
		// Note: The intensity callback is only called every 0.05 seconds
		//       if the intensity has changed since the last call!
		si.setIntensityCallbackPeriod(50);

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
