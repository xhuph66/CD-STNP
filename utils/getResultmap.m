function map = getResultmap(im_di,gbestmin)
%GETRESULTMAP �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
map=im_di;
map(map<=gbestmin)=0;
map(map>gbestmin)=1;
end

