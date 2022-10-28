%CALFITVALUE :Calculate fitness value
function [ fitvalue,gbestvalue,gbest ]=calfitvaluemin(popmin,xd)
[~,pz]=size(popmin);
%Calculate fitness values for all individuals
for i=1:pz
    map=xd;
    map(map<=popmin(i))=0;
    map(map>popmin(i))=1;
    fitvalue(i)=singlefitness(map,xd);
end
min_index=find(fitvalue==min(fitvalue));
[gbestvalue,gbestindex]=min(fitvalue);
 gbest=popmin(gbestindex);
end

