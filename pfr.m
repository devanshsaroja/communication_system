function pfr_simulation()
    % PFR simulation for a simple reaction A -> B with heat effects
    
    % Parameters
    CA0 = 2.0;      % Initial concentration of A (mol/m3)
    T0 = 300;       % Inlet temperature (K)
    L = 10;         % Reactor length (m)
    A_cross = 0.1;  % Cross-sectional area (m2)
    q = 0.01;       % Flow rate (m3/s)
    k0 = 1.0e6;     % Pre-exponential factor (1/s)
    Ea = 50000;     % Activation energy (J/mol)
    R = 8.314;      % Gas constant (J/mol·K)
    deltaH = -50000; % Heat of reaction (J/mol)
    rho = 1000;     % Density (kg/m3)
    Cp = 4.18;      % Heat capacity (J/kg·K)
    U = 100;        % Overall heat transfer coefficient (W/m2·K)
    D = 2*sqrt(A_cross/pi); % Diameter (m)
    Tc = 320;       % Coolant temperature (K)
    
    % Initial conditions
    y0 = [CA0; T0]; % [CA; T] at z=0
    
    % Spatial span (reactor length)
    zspan = [0 L];  % From inlet to outlet
    
    % Solve ODEs
    [z, y] = ode45(@pfr_odes, zspan, y0);
    
    % Extract results
    CA = y(:,1);
    T = y(:,2);
    
    % Calculate conversion along the reactor
    X = (CA0 - CA) / CA0;
    
    % Plot results
    figure;
    subplot(2,1,1);
    plot(z, CA);
    xlabel('Reactor Length (m)');
    ylabel('Concentration of A (mol/m^3)');
    title('PFR Axial Profiles');
    
    subplot(2,1,2);
    plot(z, T);
    xlabel('Reactor Length (m)');
    ylabel('Temperature (K)');
    
    % Display outlet values
    fprintf('Outlet concentration of A: %.4f mol/m^3\n', CA(end));
    fprintf('Outlet temperature: %.2f K\n', T(end));
    fprintf('Outlet conversion: %.2f%%\n', X(end)*100);
    
    % ODE function
    function dydz = pfr_odes(~, y)
        CA = y(1);
        T = y(2);
        
        % Linear velocity
        u = q / A_cross;
        
        % Reaction rate
        k = k0 * exp(-Ea/(R*T));
        rA = k * CA;
        
        % Material balance for A
        dCAdz = -rA / u;
        
        % Energy balance
        dTdz = (-deltaH/rho/Cp)*rA/u - (4*U/D/rho/Cp)*(T - Tc)/u;
        
        dydz = [dCAdz; dTdz];
    end
end