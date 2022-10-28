function fitness_value = singlefitness(individual,xd)
%FUNCTION_FITNESS 此处显示有关此函数的摘要
%   individual:Binary matrix of size MxN
N0=0;
N1=0;
U0=0;
U1=0;
U0_temp=0;
U1_temp=0;
[M, N]=size(individual);
%% 
N1=sum(sum(individual));
N0=M*N-N1;
for i=1:M
    for j=1:N
        if individual(i,j)==0
            U0_temp=U0_temp+xd(i,j);
        else
            U1_temp=U1_temp+xd(i,j);
        end
    end
end
U0=U0_temp/N0;
U1=U1_temp/N1;
%% 
U0_temp=0;
U1_temp=0;
for i=1:M
    for j=1:N
        if individual(i,j)==0
           U0_temp=U0_temp+(xd(i,j)-U0)^2;
        else
           U1_temp=U1_temp+(xd(i,j)-U1)^2;  
        end
    end
end
fitness_value=N0*U0_temp/(M*N)+N1*U1_temp/(M*N);
end

