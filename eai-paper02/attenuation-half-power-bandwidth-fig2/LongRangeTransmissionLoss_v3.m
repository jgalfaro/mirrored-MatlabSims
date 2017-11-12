% Long-Range Transmission Loss according to Thorp and
% half-power bandwidth for selected frequencies in the ULF band
% Author: Michel Barbeau
% Version: June 16, 2017
%
close all
clear all
%%% Plot attenuation
%
% selected frequencies
f = [.3 .9 1.5 2.1 2.7 ]; % kHz
f2 = f.*f; % squared frequencies
% distances
Rkm = logspace(log10(1),log10(5000),100);
% absorption
alpha = 0.11*f2./(1+f2) + 44*f2./(4100+f2) + 0.000275*f2 + 0.003; 
for j = 1:length(f) % for each frequency
     % calculate the transmission loss
     TL = 2*10*log10(1e3*Rkm) + alpha(j)*Rkm;
     % plot
     semilogy(Rkm,TL);
     hold on;
     % label
     text(Rkm(55),TL(55)+1,['f = ' num2str(1e3*f(j)) 'Hz']); 
end
xlabel('Range (km)');
ylabel('Transmission Loss (dB)')
axis ij;
grid on;
axis([1 1e3 75 150]);
figure;
%%% plot half-power bandwidth
%
% selected frequencies
f = [ .3 1.5 2.7 ]; % kHz
% distances
Rkm = logspace(log10(10),log10(40),100);
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
   text(Rkm(10),hpb(10)+1,['f = ' num2str(1e3*f(j)) 'Hz']);
end
xlabel('Range (km)');
ylabel('Half-power bandwidth (Hertz)')
grid on;
axis([10 40 0 1e4]);


