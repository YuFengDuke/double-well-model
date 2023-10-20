function F = signal_sum(pattern,fix_point,p)
% TP=0;
% FP=0;
% FN=0;
% TN=0;
% for i=1:size(signal_1,2)
%         if signal_1(i)==1 && signal_2(i)==1
%             TP=TP+1;
%         end
%         if signal_1(i)==0 && signal_2(i)==0
%             TN=TN+1;
%         end
%         if signal_1(i)==1 && signal_2(i)==0
%             FN=FN+1;
%         end
%         if signal_1(i)==0 && signal_2(i)==1
%             FP=FP+1;
%         end
% end 
% P=TP/(TP+FP);
% R=TP/(TP+FN);
% F=2*P*R/(P+R);
% 
% if isnan(F)
%     F = 0;
% end
% F = 0;
% for i = 1:size(signal_1,2)
%     if (signal_1(i)==signal_2(i))
%         F = F+1;
%     end
% end
% F = F/size(signal_1,2);

M =  size(find(fix_point==1),2);
%N = size(pattern,2);
if M == 0
    F = 0;
else
    F =sum((pattern-p).*fix_point)/(1-p)/M;
end