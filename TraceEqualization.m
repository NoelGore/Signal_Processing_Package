function normalized_debiased = TraceEqualization(debiased,offset)
%TraceEqualization normalizes the total energy of each individual trace in the data set 

%calculating trace energies
energy=debiased.^2;
Trace_energy=sum(energy);

%finding coefficient for energy
m=1./(Trace_energy);

%plugging in coefficient to normalize energy
normalized_debiased=m.*debiased;
normalized_energy=sum(m.*energy);


%plotting and labelling
figure()
subplot(2,1,1)
plot(offset,Trace_energy)
title('Energy per Trace (Pre Equalization)')
ylabel('Energy (J)')



subplot(2,1,2)
plot(offset,normalized_energy)
xlabel('Offset (m)')
ylabel('Normalized Energy (J)')
title('Energy per Trace (Post Trace Equalization)')
ylim([-1,2])
end

