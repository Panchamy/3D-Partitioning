function [value_norm] = norm01(value_ini, Bmin, Bmax)
%[6 7 8 9 10] will be [0 0.25 0.5 0.75 1]


value_norm = (value_ini - Bmin) / (Bmax - Bmin);
%value_norm = Bmin + (value_ini - Bmin) / (Bmax - Bmin);

end