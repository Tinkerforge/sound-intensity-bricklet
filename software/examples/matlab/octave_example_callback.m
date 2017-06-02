function octave_example_callback()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Sound Intensity Bricklet

    ipcon = javaObject("com.tinkerforge.IPConnection"); % Create IP connection
    si = javaObject("com.tinkerforge.BrickletSoundIntensity", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register intensity callback to function cb_intensity
    si.addIntensityCallback(@cb_intensity);

    % Set period for intensity callback to 0.05s (50ms)
    % Note: The intensity callback is only called every 0.05 seconds
    %       if the intensity has changed since the last call!
    si.setIntensityCallbackPeriod(50);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for intensity callback
function cb_intensity(e)
    fprintf("Intensity: %d\n", e.intensity);
end
