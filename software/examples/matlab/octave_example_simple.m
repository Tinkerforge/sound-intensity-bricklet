function octave_example_simple()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Sound Intensity Bricklet

    ipcon = javaObject("com.tinkerforge.IPConnection"); % Create IP connection
    si = javaObject("com.tinkerforge.BrickletSoundIntensity", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current intensity
    intensity = si.getIntensity();
    fprintf("Intensity: %d\n", intensity);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end
