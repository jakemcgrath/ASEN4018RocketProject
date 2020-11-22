function[SM_results] = aerothermochemistry(Pc, AR_sup)
        
    % Define Propellant Ingredients & initial condition 
    
    % For example
%     SM_inputs = CEAinput();
%     
%     SM_inputs.ox1      = 'NH4CLO4(I)';           %primary oxidizer
%     SM_inputs.ox1T     = 298;                    %primary ox temp (K)
% 
%     SM_inputs.fu1      = 'C4H6,butadiene';       %primary fuel
%     SM_inputs.fu1T     = 298;                    %primary fuel temp (K)
% 
%     SM_inputs.fu2      = 'AL(cr)';               %secondary fuel
%     SM_inputs.fu2T     = 298;                    %secondary fuel temp (K)
%       
%     SM_inputs.ox1wt    = 80;                     %primary oxidizer weight (by mass) in total 
%     SM_inputs.fu1wt    = 10;                     %primary fuel weight (by mass) in total
%     SM_inputs.fu2wt    = 10;                     %secondary fuel weight (by mass) in total
%     
%     SM_inputs.Pc       = Pc;                     %chamber pressure (Pa)
%     
%     SM_inputs.supar    = AR_sup;                 % nozzle expansion ratio 
     
    %% Insert Algorithms or Table of Theoretical Aerothermochemistry Data for the chamber, nozzle throat and nozzle exit
    
%         SM_results.T = 2616; % [K] chamber temperature
%         SM_results.g = 1.235; % ratio of specific heats
%         SM_results.MolWt = 22.959; % molecular weight
%         SM_results.rho = 7.276; % [kg/m3] gas density
%         SM_results.c = 1500; % [m/s] cstar
    
    %% Return results
    %SM_results1 = SM_inputs.getresults(1,'si');
    %SM_results2 = SM_inputs.getresults(2,'si');
    %SM_results3 = SM_inputs.getresults(3,'si');           %1 for chamber conditions, 2 for throat, 3 for nozzle exit: requires arg for area ratio or exit pressure), 'en' for english units
    
    
    %% New Method to retrieve data from CEA:
    reactants =   [                                           ...
             CEA.Reactant('C3H8',                            ...
                     'Type','Fuel',                     ...
                     'E',DimVar(-10000,'J/mol'),        ...
                     'T',DimVar(27,'C'),               ...         
                     'Q',DimVar(1,'kg'))                ...
            CEA.Reactant('H2O2(L)',                          ...
                    'Type','ox',                        ...
                    'T',DimVar(298,'K'),                ...         
                    'Q',DimVar(0.9,'kg'))               ...
            CEA.Reactant('H2O(L)',                           ...
                    'Type','ox',                        ...
                    'T',DimVar(298,'K'),                ...         
                    'Q',DimVar(0.1,'kg'))               ...
            ];     
        

    data =  CEA.Run(reactants,                              ...
            'ProblemType','Rocket',                         ...
            'Flow','eq',                                    ...
            'Pc',DimVar(Pc*0.000145038,'psi'),                         ...
            'OF',1,                                         ...
            'Outputs',{'T','gam','m','rho','son'});
        disp(data)
        SM_results.T = data.Temperature(1,1); % [K] chamber temperature
        SM_results.g = data.gam(1,1); % ratio of specific heats
        SM_results.MolWt = data.MolarMass(1,1); % molecular weight
        SM_results.rho = data.Density(1,1); % [kg/m3] gas density
        SM_results.c = data.son(1,1); % [m/s] cstar
    
end