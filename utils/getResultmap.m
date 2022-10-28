function map = getResultmap(im_di,gbestmin)
%GETRESULTMAP 此处显示有关此函数的摘要
%   此处显示详细说明
map=im_di;
map(map<=gbestmin)=0;
map(map>gbestmin)=1;
end

