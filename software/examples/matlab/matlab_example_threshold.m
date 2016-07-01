function matlab_example_threshold()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletSoundIntensity;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change XYZ to the UID of your Sound Intensity Bricklet

    ipcon = IPConnection(); % Create IP connection
    si = handle(BrickletSoundIntensity(UID, ipcon), 'CallbackProperties'); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get threshold callbacks with a debounce time of 1 second (1000ms)
    si.setDebouncePeriod(1000);

    % Register intensity reached callback to function cb_intensity_reached
    set(si, 'IntensityReachedCallback', @(h, e) cb_intensity_reached(e));

    % Configure threshold for intensity "greater than 2000"
    si.setIntensityCallbackThreshold('>', 2000, 0);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end

% Callback function for intensity reached callback
function cb_intensity_reached(e)
    fprintf('Intensity: %i\n', e.intensity);
end
