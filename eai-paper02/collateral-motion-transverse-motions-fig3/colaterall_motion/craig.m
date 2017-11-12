% See Fig 6.20 of Urick's book.
% Curves fit by Ron Kessel.
% Original curves est +/- 6 dB.
% 2 Dec 2016

close all
clear all

f = [.02 .04 .1 .2]; % kHz
f2 = f.*f;  f3 = f2.*f;  f4 = f3.*f;
Rkm = logspace(log10(1),log10(5000),100);

% frequency-dependent attenuation of sound by absorption by sea water [Ref: equation (1.1) in M. Ainslie, Principles of Sonar Performance Modelling, Springer-Verlag, Berlin, 2010];
alpha = 0.11* f2./(1+f2) + 44*f2./(4100+f2) + 0.0003*f2 ; % dB/km
% additional frequency-dependent term to be determined for Arctic attenuation (?); such that
beta = -0.00354 + 0.775875*f + 2.427174*f2 - 1.04795*f3 + 0.072161 * f4; % dB/km

for j = 1:length(f)
   TL = 10*log10(1e3*Rkm) + 30 + alpha(j)*Rkm + beta(j)*Rkm;
   semilogx(Rkm,TL);hold on;
   text(Rkm(55),TL(55)-.5,['f = ' num2str(1e3*f(j)) 'Hz'])
end

TLs = 20*log10(1e3*Rkm);
TLc = 10*log10(1e3*Rkm)+30;
semilogx(Rkm,TLc,'--');text(max(Rkm),max(TLc),'Cylindrical');
semilogx(Rkm,TLs,'--');text(max(Rkm),max(TLs),'Spherical');
xlabel('Range (km)');
ylabel('Transmission Loss (dB)')
axis ij
grid on
axis([1 10e3 60 160])