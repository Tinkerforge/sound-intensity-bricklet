use std::{error::Error, io, thread};
use tinkerforge::{ipconnection::IpConnection, sound_intensity_bricklet::*};

const HOST: &str = "127.0.0.1";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Sound Intensity Bricklet

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection
    let sound_intensity_bricklet = SoundIntensityBricklet::new(UID, &ipcon); // Create device object

    ipcon.connect(HOST, PORT).recv()??; // Connect to brickd
                                        // Don't use device before ipcon is connected

    // Get threshold listeners with a debounce time of 1 second (1000ms)
    sound_intensity_bricklet.set_debounce_period(1000);

    //Create listener for intensity reached events.
    let intensity_reached_listener = sound_intensity_bricklet.get_intensity_reached_receiver();
    // Spawn thread to handle received events. This thread ends when the sound_intensity_bricklet
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for event in intensity_reached_listener {
            println!("Intensity: {}", event);
        }
    });

    // Configure threshold for intensity "greater than 2000"
    sound_intensity_bricklet.set_intensity_callback_threshold('>', 2000, 0);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
