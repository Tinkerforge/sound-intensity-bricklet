function octave_example_threshold
    more off;
    
    HOST = "localhost";
    PORT = 4223;
    UID = "iQb"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    si = java_new("com.tinkerforge.BrickletSoundIntensity", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get threshold callbacks with a debounce time of 1 seconds (1000ms)
    si.setDebouncePeriod(1000);

    % Register threshold reached callback to function cb_reached
    si.addIntensityReachedListener("cb_reached");

    % Configure threshold for "greater than 2000"
    si.setIntensityCallbackThreshold(">", 2000, 0);

    input("\nPress any key to exit...\n", "s");
    ipcon.disconnect();
end

% Callback for intensity greater than 2000
function cb_reached(intensity)
    fprintf("Intensity: %g\n", intensity);
end
