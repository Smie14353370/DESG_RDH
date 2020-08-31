function [ deco, deco_final ] = Huffman_ex( dict,enco,x)
 %% ����
%  dict = huffmandict(k,P); 
 deco = huffmandeco(enco,dict); %����
 ans_now=1;
 de_ans=zeros(1,(length(deco)-1)*8);
 ans_bin=zeros((length(deco)-1),8);
 for i=1:length(deco)-1
     k=8;
     b=deco(i);
     while (b>0)
         ans_bin(i,k)=mod(b,2);
         b=fix(b/2);
         k=k-1;
     end
 end
 if deco(length(deco))==0
     ans_final=(reshape(ans_bin',1,((length(deco)-1)*8)));
 else
     ans_bin=(reshape(ans_bin',1,((length(deco)-1)*8)));
     ans_final=ans_bin(1:(length(ans_bin)-deco(length(deco))));
 end
%  ans_final
% bool=0;
%      for i=1:length(x)
%          if ans_final(i)~=x(i)
%              bool=1;
%              break;
%          end
%      end
%  
%  if bool==0
%      disp('yes');
%      deco_final=ans_final(1:length(x));
%  end
deco_final=ans_final(1:length(x));