function matlab_example_simple()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletSoundIntensity;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    si = handle(BrickletSoundIntensity(UID, ipcon), 'CallbackProperties'); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current intensity
    intensity = si.getIntensity();
    fprintf('Intensity: %i\n', intensity);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end
