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

    % Get current intensity
    intensity = si.getIntensity();

    fprintf('Intensity: %g\n', intensity);

    input('\nPress any key to exit...\n', 's');
    ipcon.disconnect();
end
