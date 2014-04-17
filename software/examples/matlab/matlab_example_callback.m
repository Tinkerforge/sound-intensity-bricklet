function matlab_example_callback
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletSoundIntensity;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'iQb'; % Change to your UID
    
    ipcon = IPConnection(); % Create IP connection
    si = BrickletSoundIntensity(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set Period for intensity callback to 1s (1000ms)
    % Note: The intensity callback is only called every second if the 
    %       intensity has changed since the last call!
    si.setIntensityCallbackPeriod(1000);

    % Register intensity callback to function cb_intensity
    set(si, 'IntensityCallback', @(h, e) cb_intensity(e));

    input('Press any key to exit...\n', 's');
    ipcon.disconnect();
end

% Callback function for intensity
function cb_intensity(e)
    fprintf('Intensity: %g\n', e.intensity);
end
