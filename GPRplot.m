function  GPRplot(twt,GPR11)
%This function plots a trace from one raw inline GPR panel

%Generating random line to isolate for plot (for quality control)
whichinline=randi(length(GPR11(1,:)))
time=twt;
%choosing GPR inline, based on randomly chosen number
y=GPR11(:,whichinline);

%plotting and labelling
plot(time,y)
xlabel('Time (s)')
str1='Trace Amplitude (m) for trace';
str2=num2str(whichinline); 
ylabel(strcat(str1, str2))
title('Raw Trace from Isolated Inline GPR Panel')

end

