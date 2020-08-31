% function [c_sum,t,a,b,c,d,e,f,rate,dict,deco_overhead,size_deco_overhead,permark,loc_num,overhead,location,a_location,cal]=capacity(img,mode_new,h,w)
 function [c_sum,cal,location,overhead,LUT,len_0,len_1]=capacity1(img,mode_new,h,w,i)

% img_22=[10 10 10 2 2 2 1 1 10 10 13 13 10 10 10 10 4 16 1 10 ]
%% 大于2的总和=可翻转的个数
% cal= struct('list1',[],'pattern1',[],'list2',[],'pattern2',[],'cap',[],'dist',[],'x',[],'y',[]);
% cal_now=0;
% f=1/11.566*[0.1628 0.3215 0.4035 0.3215 0.1628;
%             0.3215 0.6352 0.7970 0.6352 0.3215;
%             0.4035 0.7970 1 0.7970 0.4035;
%             0.3215 0.6352 0.7970 0.6352 0.3215;
%             0.1628 0.3215 0.4035 0.3215 0.1628;];
% B=[];
% c_sum=0;
len_0=length(mode_new([mode_new.num]==0));
len_1=length(mode_new([mode_new.num]==1));
% mode0=mode_new([mode_new.num]==0);
% for i_i=1:20
%     if i_i<=4 &&i_i>=1
%         i=1;
%     elseif i_i<=8 &&i_i>4
%         i=2;
%     elseif i_i<=12 &&i_i>8
%         i=3;
%     elseif i_i<=16 &&i_i>12
%         i=4; 
%     elseif i_i<=20 &&i_i>16
%         i=5; 
%     end
% %     i
%     dis=10000;
%     j_j=0;
%     for j=1:len_0
%         if ismember(mode0(j).list,B)==0
%             hf=conv2(double(mode_new(i).pattern),f);
%             lf=conv2(double(mode0(j).pattern),f);
%             A=(hf(:,:)-lf(:,:)).^2;
%             if(dis>sum(A(:)))
%                 j_j=j;
%                 dis=sum(A(:));
%             end
%         end
%     end
%         cal_now=cal_now+1;
%         cal(cal_now).dist=dis;
%         cal(cal_now).list1=mode_new(i).list;
%         cal(cal_now).pattern1=mode_new(i).pattern;
%         cal(cal_now).list2=mode0(j_j).list;
%         B=[B mode0(j_j).list];
%         cal(cal_now).pattern2=mode0(j_j).pattern;
%         cal(cal_now).cap=mode_new(i).num+mode0(j_j).num;
%         cal(cal_now).x=mode0(j_j).x;
%         cal(cal_now).y=mode0(j_j).y;
%         %c_sum=c_sum+cal(cal_now).cap;
%         
% end
% for k=1:5
%     c_sum=c_sum+(mode_new(k).num);
% end


%     str=['E:\琳\RDH-halftone\状态机改良-非定位\mode_0\误差扩散\0\cal_',num2str(i),'.mat'];
    str=['E:\琳\RDH-halftone\状态机改良-非定位\mode_0\matlab有序抖动\0\cal_',num2str(i),'.mat'];
%     str=['E:\琳\RDH-halftone\状态机改良-非定位\mode_0\2012有序抖动\0\cal_',num2str(i),'.mat'];
    load(str);
     c_sum=(cal(1).cap)+(cal(5).cap)+(cal(9).cap)+(cal(13).cap)+(cal(17).cap);

%% 找出会引起歧义的a间隔段的首地址
% t = find(img_22==a.list); %所有a的地址
% find_two_now=1;
% find_two=[];
% for i=2:length(t)
%     if t(i)-t(i-1)~=1
%         find_two(find_two_now)=t(i-1);
%         find_two_now=find_two_now+1;
%         find_two(find_two_now)=t(i);
%         find_two_now=find_two_now+1;
%     end
% end
% 
% % a=mode_new(1);
% if mode_new(16).list==0 || mode_new(16).list==15
%     b=mode_new(11);
%     c=mode_new(12);
%     d=mode_new(15);
%     e=mode_new(14);
%     f=mode_new(13);
% elseif mode_new(15).list==0 || mode_new(15).list==15
%     b=mode_new(11);
%     c=mode_new(12);
%     d=mode_new(16);
%     e=mode_new(14);
%     f=mode_new(13);
% elseif mode_new(14).list==0 || mode_new(14).list==15
%     b=mode_new(11);
%     c=mode_new(12);
%     d=mode_new(16);
%     e=mode_new(15);
%     f=mode_new(13);
% elseif mode_new(13).list==0 || mode_new(13).list==15
%     b=mode_new(11);
%     c=mode_new(12);
%     d=mode_new(16);
%     e=mode_new(15);
%     f=mode_new(14);
% elseif mode_new(12).list==0 || mode_new(12).list==15
%     b=mode_new(11);
%     c=mode_new(13);
%     d=mode_new(16);
%     e=mode_new(15);
%     f=mode_new(14);
% else
%     b=mode_new(12);
%     c=mode_new(13);
%     d=mode_new(16);
%     e=mode_new(15);
%     f=mode_new(14);
% end
% % b=mode_new(12);
% % c=mode_new(13);
% % d=mode_new(16);
% % e=mode_new(15);
% % f=mode_new(14);
permark=log2(h*w/16);
location=[];
LUT=[];
LUT_mode=[1 2 3 4 8];
for k=1:5
    LUT=[LUT fliplr(dec2binvec(LUT_mode(k),6)) ];
end
LUT=[LUT fliplr(dec2binvec(cal(1).list1,16)) fliplr(dec2binvec(cal(5).list1,16)) fliplr(dec2binvec(cal(9).list1,16)) fliplr(dec2binvec(cal(13).list1,16)) fliplr(dec2binvec(cal(17).list1,16))];
for k=1:20
    location=[location fliplr(dec2binvec(cal(k).x,9)) fliplr(dec2binvec(cal(k).y,9))];
    LUT=[LUT fliplr(dec2binvec(cal(k).list2,16))];
end

% l_now=1;
% for i=1:4:h
%     for j=1:4:w
%         for k=1:10
%             if (img(i:i+3,j:j+3)==cal(k).list2)
%                 location(l_now).x=i;
%                 location(l_now).y=j;
%                 l_now=l_now+1;
%                 break;
%             end
%         end
%     end
% end
loc_len=length(location);
% 
% %% 记录a-f
% 

% % af=[fliplr(dec2binvec(a.list,4)) fliplr(dec2binvec(b.list,4)) fliplr(dec2binvec(c.list,4)) fliplr(dec2binvec(d.list,4)) fliplr(dec2binvec(e.list,4)) fliplr(dec2binvec(f.list,4))];
% % af
% % length(af)
% %% 记录首a的地址
% % overhead=[];
% permark=log2(h*w/4);
% a_location=[];
% for i=1:length(location)
% %     location(i)
%     a_location(permark*(i-1)+1:permark*i)=fliplr(dec2binvec(location(i),permark));
% end
% % a_location
% % length(a_location)
mark=[];
LUT_now=1;
for i=h-2:2:h
    for j=1:2:w
        if LUT_now<=length(LUT)
            mark(LUT_now)=img(i,j);
            LUT_now=LUT_now+1;
        end
    end
end

% mark=rand(1,length(LUT))>0.5;
IO=[location mark];
IO;
length(IO);
[ rate,dict,IO_deco_overhead,IO_size_deco_overhead] = Huffman_em( IO );
% IO_deco_overhead
% IO_size_deco_overhead;
overhead=[fliplr(dec2binvec(IO_size_deco_overhead,permark)) IO_deco_overhead];


