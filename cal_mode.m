function [mode_new,mode,img_44] = cal_mode(img,mode,h,w)
% mode(1).pattern=[1 1;1 1];
% mode(2).pattern=[1 1;1 0];
% mode(3).pattern=[1 1;0 1];
% mode(4).pattern=[1 1;0 0];
% mode(5).pattern=[1 0;1 1];
% mode(6).pattern=[1 0;1 0];
% mode(7).pattern=[1 0;0 1];
% mode(8).pattern=[1 0;0 0];
% mode(9).pattern=[0 1;1 1];
% mode(10).pattern=[0 1;1 0];
% mode(11).pattern=[0 1;0 1];
% mode(12).pattern=[0 1;0 0];
% mode(13).pattern=[0 0;1 1];
% mode(14).pattern=[0 0;1 0];
% mode(15).pattern=[0 0;0 1];
% mode(16).pattern=[0 0;0 0];
% mode(1).pattern=[255 255;255 255];
% mode(2).pattern=[255 255;255 0];
% mode(3).pattern=[255 255;0 255];
% mode(4).pattern=[255 255;0 0];
% mode(5).pattern=[255 0;255 255];
% mode(6).pattern=[255 0;255 0];
% mode(7).pattern=[255 0;0 255];
% mode(8).pattern=[255 0;0 0];
% mode(9).pattern=[0 255;255 255];
% mode(10).pattern=[0 255;255 0];
% mode(11).pattern=[0 255;0 255];
% mode(12).pattern=[0 255;0 0];
% mode(13).pattern=[0 0;255 255];
% mode(14).pattern=[0 0;255 0];
% mode(15).pattern=[0 0;0 255];
% mode(16).pattern=[0 0;0 0];
% for i=1:2^16
%     dec2binvec(i-1,16);
%     mode(i).pattern=reshape(dec2binvec(i-1,16), 4, 4);
% end
% mode(1).pattern=reshape(dec2binvec(0,16), 4, 4)
% toc;
img_44=zeros(1,h*w/16);
for i=1:2^16
    mode(i).list=i-1;
    mode(i).num=0;
end
img_i=1;
for i=1:4:h
    for j=1:4:w
        for k=1:2^16
%             [hi,wi]=size(img(i:i+3,j:j+3))
%             [h2,w2]=size(mode(k).pattern)
            if img(i:i+3,j:j+3)==mode(k).pattern
                mode(k).num=mode(k).num+1;
%                 img_22(img_i).list=img_i;
                img_44(img_i)=k-1;
                img_i=img_i+1;
                break;
            end
        end
    end
end
[a,idx] = sort([mode.num],'descend');
mode_new1=mode(idx);
mode_new = mode_new1([mode_new1.num]>0);