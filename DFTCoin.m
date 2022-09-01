function D = DFTCoin()
% DFTCOIN is a utility function which returns the matrix representation of
% the 4-dimensional discrete Fourier transform

D = 1/2*[
    1 1 1 1;
    1 1i -1 -1i;
    1 -1 1 -1;
    1 -1i -1 1i];
end

