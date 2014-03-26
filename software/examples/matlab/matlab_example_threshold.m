function matlab_example_threshold
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletSoundIntensity;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'iQb'; % Change to your UID
    
    ipcon = IPConnection(); % Create IP connection
    si = BrickletSoundIntensity(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get threshold callbacks with a debounce time of 1 seconds (1000ms)
    si.setDebouncePeriod(1000);

    % Register threshold reached callback to function cb_reached
    set(si, 'IntensityReachedCallback', @(h, e)cb_reached(e.intensity));

    % Configure threshold for "greater than 2000"
    si.setIntensityCallbackThreshold('>', 2000, 0);

    input('\nPress any key to exit...\n', 's');
    ipcon.disconnect();
end

% Callback for intensity greater than 2000
function cb_reached(intensity)
    fprintf('Intensity: %g\n', intensity);
end
