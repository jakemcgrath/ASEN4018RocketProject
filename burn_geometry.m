function [Ab,Vb] = burn_geometry(ro,ri,h,rb)
    
    if rb >= ro-ri % motor is burnt out
        Ab = 0; % [m^2] 
        Vb = 0;
    else % there is grain remaining
        %% BURN AREA
        hg = h - 2*rb;
        A_side = pi*(ro^2 - (ri+rb^2)); % Area on cylindrical sides
        
        Ab = 2*pi*(ri + rb)*hg + 2*A_side; % [m^2] Burn Area

        %% VOLUME of PROPELLANT
        Vb = A_side*h; % [m^3]
    end
end