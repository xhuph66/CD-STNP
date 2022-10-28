%author:Rikong Lugu
%email:2218961555@qq.com
%date:2022/10/24
clc
clear
close
addpath('./utils');
addpath('./pic');
addpath(genpath(pwd));

%% Read pictures
[imagename1, imagepath1]=uigetfile('*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the first input image');
t1 = imread(strcat(imagepath1,imagename1)); 
[imagename2,imagepath2]=uigetfile('*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image'); 
t2 =imread(strcat(imagepath2,imagename2));
[imagename3,imagepath3]=uigetfile('*.jpg;*.bmp;*.png;*.tif;*.tiff;*.pgm;*.gif','Please choose the second input image'); 
t_gt =imread(strcat(imagepath3,imagename3));


if size(t1,3)==3
    t1 = rgb2gray(t1);
end
if size(t2,3)==3
    t2 = rgb2gray(t2);
end
if size(t_gt,3)==3
    t_gt = rgb2gray(t_gt);
end
%% begin
for it=1:20 %Realize multiple groups
%% Set related variables
popsize=70;%Number of individuals
degree=1000;%Number of internal circulation
result_gbestmin=0;%the best threshold
result_bestPCC=0; %the best index of PCC

im1=t1;
im2=t2;
gt=t_gt;
%% Difference calculation, sampling and filtering
fprintf('... ... compute the difference image ... ...\n');
im_di=di_generate(im1,im2);
im_di=SamplingAndFiltering(im_di);
im_min=min(min(im_di));
im_max=max(max(im_di));

%% Group initialization
fprintf(' ... ... ...Population initialization ... ....\n');
[m, n]=size(im_di);
[popmin,vmin]=Init(m,n,popsize);



%% Calculate the fitness of the initial group and the optimal individual of the group
[value_min,gbestvaluemin,gbestmin]=calfitvaluemin(popmin,im_di);


%% Set the individual history as the initialization value first
pbestmin=popmin;
tic
for i=1:degree
    %Generate new location
    fprintf(' ... ... ... %d number iteration of population  ... ....\n', i);
    [newpopmin,newvmin]=updatepop(popmin,vmin,pbestmin,gbestmin,[im_min,im_max]);
    
    %Update speed value
    vmin=newvmin;
    
    %Update Location Value
    popmin=newpopmin;
    
    %Calculate the new fitness value, and the population in this cycle is optimal
    [newvalue_min,newbestvaluemin,newbestmin]=calfitvaluemin(popmin,im_di);
    
    %Update individual history best
    for j=1:popsize
        if newvalue_min(j)>value_min(j)
            pbestmin(j)=newpopmin(j);
        end      
    end
    
    %Renewal group optimization
    if newbestvaluemin>gbestvaluemin
        gbestvaluemin=newbestvaluemin;
        gbestmin=newbestmin;
    end 
end
map=getResultmap(im_di,gbestmin);
[~,~,FN,FP,~,~,~,PCC,Kappa,~,OE]=PE(map,gt);

%Record optimal threshold
if result_bestPCC<=PCC
    result_bestPCC=PCC;
    result_gbestmin=gbestmin;
end 
toc
result=[gbestmin;FN;FP;OE;PCC;Kappa];
remap(:,it)=result; 
end
%% save the best result
result_map=getResultmap(im_di,result_gbestmin);
imwrite(result_map,'result.bmp');

      
        
        
        