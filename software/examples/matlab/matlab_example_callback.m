function matlab_example_callback()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletEnergyMonitor;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change XYZ to the UID of your Energy Monitor Bricklet

    ipcon = IPConnection(); % Create IP connection
    em = handle(BrickletEnergyMonitor(UID, ipcon), 'CallbackProperties'); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register Energy Data callback to function cb_energy_data
    set(em, 'EnergyDataCallback', @(h, e) cb_energy_data(e));

    % Set period for Energy Data callback to 1s (1000ms)
    em.setEnergyDataCallbackConfiguration(1000, false);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end

% Callback function for Energy Data callback
function cb_energy_data(e)
    fprintf('Voltage: %g V\n', e.voltage/100.0);
    fprintf('Current: %g A\n', e.current/100.0);
    fprintf('Energy: %g Wh\n', e.energy/100.0);
    fprintf('Real Power: %g h\n', e.realPower/100.0);
    fprintf('Apparent Power: %g VA\n', e.apparentPower/100.0);
    fprintf('Reactive Power: %g VAR\n', e.reactivePower/100.0);
    fprintf('Power Factor: %g\n', e.powerFactor/1000.0);
    fprintf('Frequency: %g Hz\n', e.frequency/100.0);
    fprintf('\n');
end
