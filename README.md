# pfr-cstr-simulation
# CSTR and PFR Reactor Simulations in MATLAB

This repository contains MATLAB implementations for simulating two fundamental chemical reactor types:

1. **Continuous Stirred Tank Reactor (CSTR)**
2. **Plug Flow Reactor (PFR)**

## Contents

- `cstr.m` - Simulates a CSTR with heat effects
- `pfr.m` - Simulates a PFR with axial profiles

## Features

### CSTR Simulation
- Solves coupled material and energy balance equations
- Models a first-order reaction A → B
- Includes:
  - Arrhenius temperature dependence
  - Heat transfer effects
  - Dynamic response over time
- Outputs:
  - Concentration and temperature profiles
  - Conversion at steady-state
  - Graphical visualization

### PFR Simulation 
- Solves axial profiles along reactor length
- Models a first-order reaction A → B
- Includes:
  - Variable reaction rate along reactor length
  - Heat transfer through reactor walls
  - Temperature effects on reaction kinetics
- Outputs:
  - Concentration and temperature axial profiles
  - Conversion at reactor outlet
  - Graphical visualization

## Requirements

- MATLAB R2016b or later
- No additional toolboxes required

## Usage

1. Clone the repository:
```bash
git clone https://github.com/devanshsaroja/pfr-cstr-simulation.git
```

2. Run either simulation in MATLAB:
```matlab
cstr_simulation()  % Run CSTR simulation
pfr_simulation()   % Run PFR simulation
```

## Parameters

Both simulations use realistic default parameters that can be easily modified:

- Reaction kinetics (k₀, Eₐ)
- Operating conditions (T₀, C₀, flow rates)
- Reactor dimensions (volume, length, diameter)
- Thermodynamic properties (ΔH, ρ, Cp)
- Heat transfer parameters (U, Tc)

## Outputs

Each simulation provides:
- Graphical plots of key variables
- Numerical output of important results
- Conversion calculations

## Customization

To model different systems:
1. Change the reaction kinetics in the ODE functions
2. Modify the reactor parameters
3. Add additional components for more complex reactions
