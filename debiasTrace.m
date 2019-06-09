function  debiased = debiasTrace(offset,GPR11,twt)
%This function plots the trace average, as a function of offset
%as well as a plot of all debiased traces

%finding mean of each trace
traceaverage=mean(GPR11);
%subtracting trace average
debiased=GPR11-traceaverage;

%plotting and labelling my figures
figure()
subplot(2,1,1)
plot(offset,traceaverage)
xlabel('Offset (m)')
ylabel('Average Trace Amplitude (m)')
title('Trace Average, as a Function of Offset')

subplot(2,1,2)
imagesc(offset,twt,debiased)
c=colorbar()
c.Label.String='Signal Amplitude'
caxis([-1.05e-7 1.05e-7])
xlabel('Offsets (m)')
ylabel('Time (s)')
title('Debiased and Clipped GPR Data')
end

