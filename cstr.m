function cstr_simulation()
    % CSTR simulation for a simple reaction A -> B with heat effects
    
    % Parameters
    CA0 = 2.0;      % Initial concentration of A (mol/m3)
    T0 = 300;       % Inlet temperature (K)
    V = 1.0;        % Reactor volume (m3)
    q = 0.01;       % Flow rate (m3/s)
    k0 = 1.0e6;     % Pre-exponential factor (1/s)
    Ea = 50000;     % Activation energy (J/mol)
    R = 8.314;      % Gas constant (J/mol·K)
    H = -50000;     % Heat of reaction (J/mol)
    rho = 1000;     % Density (kg/m3)
    Cp = 4.18;      % Heat capacity (J/kg·K)
    UA = 1000;      % Heat transfer coefficient * area (W/K)
    Tc = 320;       % Coolant temperature (K)
    
    % Initial conditions
    y0 = [CA0; T0]; % [CA; T]
    
    % Time span
    tspan = [0 1000]; % Simulation time (s)
    
    % Solve ODEs
    [t, y] = ode45(@cstr_odes, tspan, y0);
    
    % Extract results
    CA = y(:,1);
    T = y(:,2);
    
    % Calculate conversion
    X = (CA0 - CA) / CA0;
    
    % Plot results
    figure;
    subplot(2,1,1);
    plot(t, CA);
    xlabel('Time (s)');
    ylabel('Concentration of A (mol/m^3)');
    title('CSTR Dynamics');
    
    subplot(2,1,2);
    plot(t, T);
    xlabel('Time (s)');
    ylabel('Temperature (K)');
    
    % Display steady-state values
    fprintf('Steady-state concentration of A: %.4f mol/m^3\n', CA(end));
    fprintf('Steady-state temperature: %.2f K\n', T(end));
    fprintf('Steady-state conversion: %.2f%%\n', X(end)*100);
    
    % ODE function
    function dydt = cstr_odes(~, y)
        CA = y(1);
        T = y(2);
        
        % Reaction rate
        k = k0 * exp(-Ea/(R*T));
        rA = k * CA;
        
        % Material balance for A
        dCAdt = (q/V)*(CA0 - CA) - rA;
        
        % Energy balance
        dTdt = (q/V)*(T0 - T) + (-H/rho/Cp)*rA - (UA/rho/Cp/V)*(T - Tc);
        
        dydt = [dCAdt; dTdt];
    end
end
