 m=[1];%8267
 n=[10000];
quality = struct('i',[],'p',[],'ws',[],'q',[],'S1',[],'S2',[],'S3',[],'S4',[],'S5',[],'pure',[],'msg_all',[],'size_deco_overhead',[],'change_pattern',[],'flip',[],'rat_pure_flip',[],'rat_mark_all',[],'size0',[],'size1',[]);
tic;
for j=1:1
    ok=0;
    for i=m(j):n(j)
        i

%         str = ['E:\琳\RDH-halftone\状态机\dataset\512\误差扩散_BOSSbase_1.01_HT_org\',num2str(i),'.bmp'];
        str = ['E:\琳\RDH-halftone\状态机\dataset\512\有序抖动_BOSSbase_1.01_HT_org\',num2str(i),'.bmp'];
%         str = ['E:\琳\RDH-halftone\状态机\dataset\512\2012有序抖动_BOSSbase_1.01_HT_org\',num2str(i),'.bmp'];        
        mode= struct('list',[],'pattern',[],'num',[]);
        img = imread(str);
        img=double(img);
        b=find(img==255);
        img(b)=1;
%         figure;
%         subplot(1,2,1)
%         imshow(img,[]);

        [h,w]=size(img);
        %% 计算最大模块
        load('mode.mat');
%         str=['E:\琳\RDH-halftone\状态机改良-非定位\mode_0\误差扩散\mode\mode_',num2str(i),'.mat'];
        str=['E:\琳\RDH-halftone\状态机改良-非定位\mode_0\matlab有序抖动\mode\mode_',num2str(i),'.mat'];
%           str=['E:\琳\RDH-halftone\状态机改良-非定位\mode_0\2012有序抖动\mode\mode_',num2str(i),'.mat'];
          load(str);

        %% 计算容量，找到可嵌入的位置
%         [c_sum,t,a,b,c,d,e,f,rate,dict,deco_overhead,size_deco_overhead,permark,loc_num,overhead,location,a_location,cal]=capacity(img,mode_new,h,w);
%         [c_sum,cal,location,overhead,LUT,len_0,len_1]=capacity(img,mode_new,h,w);
        [c_sum,cal,location,overhead,LUT,len_0,len_1]=capacity1(img,mode_new,h,w,i);
% 
%         %% 嵌入
        pure=800;
        msg=[overhead rand(1,pure)>0.5];
        m_len=length(msg);
        [img_emb,pure1,msg_all,change_pattern,msg_now,quantity]=emb_fix(img,msg,h,w,cal,overhead,LUT,m_len);
% 
%         figure;
%         subplot(1,2,2)
%         imshow(img_emb,[]);
%         if pure>=0
% %             [img_ext_seq,msg_new]=ext(img_emb_seq,deco_overhead,h,w,a,b,c,d,e,f,overhead,dict,permark,loc_num,location,a_location);
% %             if (img_ext_seq==img_22) 
% %                 if (msg_new==msg(1:length(msg_new)))
% %                     disp('reversible');
% %                 end
% %             end
%             ok=ok+1;
%         else
%         i
%         disp('no pure')
%         end
% 
% msg_now

        %% 图像质量指标
        if (pure1+3)>=pure
            ok=ok+1;
            quality(i).i=i;
            quality(i).p=psnr(img,img_emb);
            quality(i).ws = wsnr(img,img_emb);
            [q, quality_map] = img_qi(img, img_emb);
            quality(i).q=q;
            S = calVSco(img, img_emb);
            quality(i).S1=S(1);
            quality(i).S2=S(2);
            quality(i).S3=S(3);
            quality(i).S4=S(4);
            quality(i).S5=S(5);
            %% 嵌入量比较
            quality(i).pure=pure1;
            quality(i).msg_all=msg_all;
            quality(i).size_deco_overhead=length(overhead);
            quality(i).change_pattern=change_pattern;
            flip=length(find((img-img_emb)~=0));
            quality(i).flip=flip;
            quality(i).rat_pure_flip=pure1/flip;
            quality(i).rat_mark_all=length(overhead)/msg_all;
%             quality(i).size0=len_0;
%             quality(i).size1=len_1;
        end
    end
end
mean_quality = struct('ok',[],'p',[],'ws',[],'q',[],'S1',[],'S2',[],'S3',[],'S4',[],'S5',[],'pure',[],'msg_all',[],'size_deco_overhead',[],'change_pattern',[],'flip',[],'rat_pure_flip',[],'rat_mark_all',[],'size0',[],'size1',[]);
mean_quality.ok=ok;
mean_quality.p=mean([quality(:).p]);
mean_quality.ws=mean([quality(:).ws]);
mean_quality.q=mean([quality(:).q]);
mean_quality.S1=mean([quality(:).S1]);
mean_quality.S2=mean([quality(:).S2]);
mean_quality.S3=mean([quality(:).S3]);
mean_quality.S4=mean([quality(:).S4]);
mean_quality.S5=mean([quality(:).S5]);
mean_quality.pure=mean([quality(:).pure]);
mean_quality.msg_all=mean([quality(:).msg_all]);
mean_quality.size_deco_overhead=mean([quality(:).size_deco_overhead]);
mean_quality.change_pattern=mean([quality(:).change_pattern]);
mean_quality.flip=mean([quality(:).flip]);
mean_quality.rat_pure_flip=mean([quality(:).rat_pure_flip]);
mean_quality.rat_mark_all=mean([quality(:).rat_mark_all]);
% mean_quality.size0=mean([quality(:).size0]);
% mean_quality.size1=mean([quality(:).size1]);
mean_quality
% xlsfile='test,xls';
% xlswrite(xlsfile, struct2cell(quality));
save('quality_2.mat','quality');
save('mean_quality_2.mat','mean_quality');
toc;