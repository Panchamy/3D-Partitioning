function [data] = sl2xytspeed(sl, links, nodes)

nbperiod = length(unique([sl.period]));
nblinks = length(sl)/nbperiod;

v = 1:nbperiod;
t = [];
for i = 1:nbperiod
    t = [t ; repmat(v(i),nblinks,1)];
end
clear('v', 'i');

    %Conversion index-ids
    Ids = [links.id];
    n = length(Ids);
    Max = max(Ids);
    Index = (1:n)';
    %matrice de conversion de Ids vers Index
    Conversion_Ids2Index = NaN(Max,2);
    Conversion_Ids2Index(:,1) = (1:Max)';
    Conversion_Ids2Index(Ids,2) = Index;
    %matrice de conversion de Index vers Ids
    Conversion_Index2Ids = NaN(n,2);
    Conversion_Index2Ids(:,1) = Index;
    Conversion_Index2Ids(:,2) = Ids;
    clear('Ids', 'n', 'Max', 'Index');
    
for i = 1:length(sl)
    
    index = Conversion_Ids2Index(sl(i).id, 2);
    
    %The origin and destination node of the link
    o = links(index).o_node;
    d = links(index).d_node;
    
    %Coordinates of them
    index = find([nodes.id]==o);
    x1 = nodes(index).coordinates(2);
    y1 = nodes(index).coordinates(1);
    index = find([nodes.id]==d);
    x2 = nodes(index).coordinates(2);
    y2 = nodes(index).coordinates(1);
    
    sl(i).x = (x1+x2)/2;
    sl(i).y = (y1+y2)/2;
    sl(i).t = t(i);
       
end
clear('o', 'd', 'x1', 'x2', 'y1', 'y2', 'index');


%Normalized
%For x
Bmin = min([sl.x]);
Bmax = max([sl.x]);
x_norm = norm01([sl.x], Bmin, Bmax);
%For y
Bmin = min([sl.y]);
Bmax = max([sl.y]);
y_norm = norm01([sl.y], Bmin, Bmax);
%For t 
Bmin = min([sl.t]);
Bmax = max([sl.t]);
t_norm = norm01([sl.t], Bmin, Bmax);
%For speed
Bmin = 0;
Bmax = max([sl.speed]);
speed_norm = norm01([sl.speed], Bmin, Bmax);
speed_norm = speed_norm*3;%Give more weight

%Add normalized variable to 'sl' dataset
for i = 1:length(sl)
    sl(i).x = x_norm(i);
    sl(i).y = y_norm(i);
    sl(i).t = t_norm(i);
    sl(i).speed = speed_norm(i);
end
clear('speed_norm', 'y_norm', 'x_norm', 't_norm');

%Struct to matrix

data = [sl.speed ; sl.x ; sl.y ; sl.t]';
















end