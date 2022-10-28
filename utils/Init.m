%Initialize particle swarm
function [pop,v]=Init(m,n,popsize)
% pop=rand(1,popsize)*2;
pop=rand(1,popsize)*12+0.5;
v=(rand(1,popsize )*2-1)*2;
end

