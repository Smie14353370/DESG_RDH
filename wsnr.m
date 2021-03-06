function ratio = wsnr(orig, dith, nfreq)

%WSNR  Weighted signal to noise ratio.
%	RATIO = WSNR(IM1, IM2, MAXFREQ) computes the weighted signal to noise
%	ratio of IM2 with respect to IM1 and returns the result in dB.
%	A weighting appropriate to the human visual system, as proposed
%	by Mannos and Sakrison (1) and modified by Mitsa and Varkur (2),
%	is used.  MAXFREQ specifies the spatial frequency in cycles per
% 	degree that corresponds to the Nyquist frequency in the x-direction.
%	If MAXFREQ is omitted, it defaults to 60 cyc/deg.
%
%	Refs: (1) J. Mannos and D. Sakrison, "The effects of a visual
%	fidelity criterion on the encoding of images", IEEE Trans. Inf.
%	Theory, IT-20(4), pp. 525-535, July 1974.
%
%	(2) T. Mitsa and K. Varkur, "Evaluation of contrast sensitivity
%	functions for the formulation of quality measures incorporated
%	in halftoning algorithms", IEEE Int. Conference on Acoustics, Speech
%   and Signal Processing '93-V, pp. 301-304.
%
%	See also SNR, PSNR, TSNR, SNRVSF.

% From the Image Quality Assessment Toolbox, N. Damera-Venkata and 
% Prof. Brian L. Evans, released April 28, 2001

% Part of Halftoning Toolbox Version 1.2 released July 2005

% Copyright (c) 1999-2005 The University of Texas
% All Rights Reserved.
 
if nargin==2
  nfreq=60;
end

[x,y]=size(orig);
[xplane,yplane]=meshgrid(-x/2+0.5:x/2-0.5);	% generate mesh
plane=(xplane+i*yplane)/x*2*nfreq;
radfreq=abs(plane);				% radial frequency
 
% According to (2), we modify the radial frequency according to angle.
% w is a symmetry parameter that gives approx. 3 dB down along the
% diagonals.
 
w=0.7;
s=(1-w)/2*cos(4*angle(plane))+(1+w)/2;
radfreq=radfreq./s;

% Now generate the CSF

csf=2.6*(0.0192+0.114*radfreq).*exp(-(0.114*radfreq).^1.1);
f=find(radfreq<7.8909); csf(f)=0.9809+zeros(size(f));
 
% Find weighted SNR in frequency domain.  Note that, because we are not
% weighting the signal, we compute signal power in the spatial domain.
% This requires us to multiply by the image size in pixels to get the
% signal power in the frequency domain for division.

err=orig-dith;
%err_wt=fft2(err).*csf;				% weighted error spectrum
err_wt=fftshift(fft2(err)).*csf;
im=fft2(orig);

mse=sum(sum(err_wt.*conj(err_wt)));		% weighted error power
mss=sum(sum(im.*conj(im)));			% signal power
ratio=10*log10(mss/mse);			% compute SNR



