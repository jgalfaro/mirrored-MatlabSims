% Long-Range Transmission Loss according to Thorp and
% half-power bandwidth for selected frequencies in the ULF band
% Author: Michel Barbeau
% Version: June 16, 2017
%
close all
clear all
f = [ .29 .3 .31 ]; % kHz
% distances
Rkm = logspace(log10(10),log10(400),100);
for j = 1:length(f) % for each frequency
   hpb=zeros(1,length(Rkm)); % init an array
   for i = 1:length(Rkm) % for each distance
      % determine the upper frequency where attenuation is 3 dB down
      g = f(j); % start from a selected frequency
      g2 = g*g; % squared
      % absorption
      alpha = 0.11*g2/(1+g2) + 44*g2/(4100+g2) + 0.000275*g2 + 0.003;
      TL = 2*10*log10(1e3*Rkm(i)) + alpha*Rkm(i);
      dTL = 0; k = 0;
      while dTL<3
         g = g + 0.001; k = k + 1; % increase upper frequency
         g2 = g*g; 
         alpha = 0.11*g2/(1+g2) + 44*g2/(4100+g2) + 0.000275*g2 + 0.003;
         newTL = 2*10*log10(1e3*Rkm(i)) + alpha*Rkm(i);
         dTL = newTL - TL;
      end
      hpb(i) = k; % half-power bandwidth in Hertz
   end
   semilogy(Rkm,hpb);
   hold on;
end
xlabel('Range (km)');
ylabel('Half-power bandwidth (Hertz)')
grid on;
xlim([10 400]);
legend([num2str(f(1)*1000) 'Hz'],[num2str(f(2)*1000) 'Hz'],[num2str(f(3)*1000) 'Hz']);


