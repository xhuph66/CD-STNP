%Update position and speed
function [ newpop,newv ] = updatepop( pop,v,pbest,gbest,boundary )

[~,pz]=size(pop);
xmax=max(boundary);
xmin=min(boundary);
vmax=9;

for k=1:pz
    newv(k)=0.25*v(k)+0.25*rand(1,1)*(pbest(k)-pop(k))+...
            0.5*rand(1,1)*(gbest-pop(k));
    if abs(newv(k))>vmax
        if newv(k)<0
            newv(k)=-vmax;
        end
        if newv(k)>0
            newv(k)=vmax;
        end
    end
    newpop(k)=pop(k)+newv(k);
    if newpop(k)<xmin
        newpop(k)=xmin;        
    end
    if newpop(k)>xmax
        newpop(k)=xmax;        
    end
end





