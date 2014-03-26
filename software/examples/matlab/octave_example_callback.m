function octave_example_callback
    more off;
    
    HOST = "localhost";
    PORT = 4223;
    UID = "iQb"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    si = java_new("com.tinkerforge.BrickletSoundIntensity", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set Period for intensity callback to 1s (1000ms)
    % Note: The intensity callback is only called every second if the 
    %       intensity has changed since the last call!
    si.setIntensityCallbackPeriod(1000);

    % Register intensity callback to function cb_intensity
    si.addIntensityListener("cb_intensity");

    input("\nPress any key to exit...\n", "s");
    ipcon.disconnect();
end

% Callback function for intensity
function cb_intensity(intensity)
    fprintf("Intensity: %g\n", intensity);
end
