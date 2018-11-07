use std::{error::Error, io, thread};
use tinkerforge::{ip_connection::IpConnection, sound_intensity_bricklet::*};

const HOST: &str = "localhost";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Sound Intensity Bricklet.

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection.
    let si = SoundIntensityBricklet::new(UID, &ipcon); // Create device object.

    ipcon.connect((HOST, PORT)).recv()??; // Connect to brickd.
                                          // Don't use device before ipcon is connected.

    // Get threshold receivers with a debounce time of 1 second (1000ms).
    si.set_debounce_period(1000);

    // Create receiver for intensity reached events.
    let intensity_reached_receiver = si.get_intensity_reached_receiver();

    // Spawn thread to handle received events. This thread ends when the `si` object
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for intensity_reached in intensity_reached_receiver {
            println!("Intensity: {}", intensity_reached);
        }
    });

    // Configure threshold for intensity "greater than 2000".
    si.set_intensity_callback_threshold('>', 2000, 0);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
