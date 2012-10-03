close all;
clear all;
clc;


% Some ideas on naming conventions:
% * Postfix all variables with unit where applicable. If there is possible
% confusion between whether a value is given in dB or linear scale and
% there is no unit for the linear scale version, postfix with _lin.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Rx Reference Noise Figure (NFrxmin) %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SPEC VALUES
% BER =  10e-3 (taken from the spec for sensitivity) gives the required
% Eb/N0 (using Figure 2.37 on p. 92):
EbN0_dB = 10.5;
% Rx band:
RxBand_Hz = [1900e6 1960e6];
RxBW_Hz = RxBand_Hz(2) - RxBand_Hz(1);
% Bit rate (Rb), taken from the speced data rate:
Rb_bps = 150e3; % bps: bits per second
% Minimum input sensitivity (Sinmin), taken from the speced sensitivity:
Sinmin_dBm = -95;

% DERIVED VALUES
% Minimum allowable SNR at the DAC input (note: Gu refers to the SNR up
% until the DAC input as CNR), SNRmin (Rx Synthesis 1 slides):
SNRmin_dB = EbN0_dB + 10*log10(Rb_bps/RxBW_Hz);
% And finally, the required minimum noise figure of the Rx (Gu p. 232
% and/or Rx Synthesis 1 slides):
NFRxmin_dB = Sinmin_dBm + 174 - 10*log10(RxBW_Hz) - SNRmin_dB

% MARGIN AND TARGET NF
NFRxmargin_dB = 3
NFRxtarget_dB = NFRxmin_dB - NFRxmargin_dB


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Minimum Rx IIP3 (IIP3Rxmin) %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SPEC VALUES
% Desired input signal level Sdesiredin for IIP3 calculation and
% measurement (taken from Sin in the spec for Intermodulation IIP3):
Sdesiredin_dBm = -92;
% Interferer input power (power of each tone, see line 6 from bottom on p.
% 259 in Gu; value taken from spec for Intermodulation IIP3):
Iin_dBm = -43;

% DERIVED VALUES
% Eq. (4.3.46), p. 261 (note: this formula assumes that all the allowed
% degradation is due to IIP3 products, see last two lines on p. 259; the
% maximum allowed degradation is giben by eq. (4.3.37), p. 258):
% MAYBE WE SHOULD USE THE TARGET NF RATHER THAN NFmin HERE???
IIP3Rxmin_dB = 0.5*(3*Iin_dBm - g2dbp(dbp2g(Sdesiredin_dBm - SNRmin_dB) - dbp2g(-174 + NFRxmin_dB + g2dbp(RxBW_Hz))))
% IIP3Rxmin_dB = 0.5*(3*Iin_dBm - 10*log10(10^((Sdesiredin_dBm - SNRmin_dB)/10) - 10^((-174 + NFRxmin_dB + 10*log10(RxBW_Hz))/10)))

% MARGIN AND TARGET IIP3
IIP3Rxmargin_dB = 3
IIP3Rxtarget_dB = IIP3Rxmin_dB + IIP3Rxmargin_dB
