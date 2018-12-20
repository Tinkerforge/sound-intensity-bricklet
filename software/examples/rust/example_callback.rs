use std::{io, error::Error};
use std::thread;
use tinkerforge::{ip_connection::IpConnection, 
                  sound_intensity_bricklet::*};


const HOST: &str = "localhost";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Sound Intensity Bricklet.

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection.
    let si = SoundIntensityBricklet::new(UID, &ipcon); // Create device object.

    ipcon.connect((HOST, PORT)).recv()??; // Connect to brickd.
    // Don't use device before ipcon is connected.

     let intensity_receiver = si.get_intensity_callback_receiver();

        // Spawn thread to handle received callback messages. 
        // This thread ends when the `si` object
        // is dropped, so there is no need for manual cleanup.
        thread::spawn(move || {
            for intensity in intensity_receiver {           
                		println!("Intensity: {}", intensity);
            }
        });

		// Set period for intensity receiver to 0.05s (50ms).
		// Note: The intensity callback is only called every 0.05 seconds
		//       if the intensity has changed since the last call!
		si.set_intensity_callback_period(50);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
