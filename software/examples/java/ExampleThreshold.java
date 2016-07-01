import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletSoundIntensity;

public class ExampleThreshold {
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

		// Get threshold callbacks with a debounce time of 1 second (1000ms)
		si.setDebouncePeriod(1000);

		// Add intensity reached listener
		si.addIntensityReachedListener(new BrickletSoundIntensity.IntensityReachedListener() {
			public void intensityReached(int intensity) {
				System.out.println("Intensity: " + intensity);
			}
		});

		// Configure threshold for intensity "greater than 2000"
		si.setIntensityCallbackThreshold('>', 2000, 0);

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
