%-----------------------------------------------------------------
% Darren Gomez
%
% Interpolation of a sound wave:
% This function reads in a text file containing a sound wave
% Creates a spline of time, amplitude at every fixed freq.
% Creates a spline of freq, amplitude at every fixed time interval.
% Plots n spline points between each intersecting spline
%
% Uses a basic centered difference in 2 dimensions to compute the
% interpolation between each square of splines
%
% Eventually will also use interpolation for splines as stated in [1] H. S. Hou and H. C. 
%   Andrews, �Cubic splines for image interpolation and digital filtering,� 
%   IEEE Trans. Acoust., Speech, SignalProcessing, vol. ASSP-26, Dec. 1978.
%
%
% The Hou and Andrews interpolation part has not been added yet but will be
% soon. Right now, each intersection of spline is only being interpolated
% by the centered difference scheme
%-----------------------------------------------------------------

%Matrix of data where M[time][freq] = amplitude
%reads in a file as created by processing file VoiceToText

function S_surf = createInterpolation(fileName, n)
    M = dlmread(fileName, ' ');

    surf(M);
    figure
    S_surf = createKnots(M, n);
    
    surf(S_surf)
    
    colormap default
end

%Expansions the matrix (wavelet) M by a factor of n using splines
% n is the number of interpolated points between i and i+1. also j and j+1 because square mesh

function S_surf = createKnots(M, n)
    global maxRows maxCols
    sizeM = size(M); %sizeM(1) = #rows; sizeM(2) = #cols;
    maxRows = sizeM(1); %time
    maxCols = sizeM(2); %freq; usually sizeM(2); 

    %splines with fixed time
    x = (1:1:maxCols);
    global xx yy
    xx = linspace(1,maxCols,maxCols*(n+1)-n); 

    %manually create last entry to preallocate memory for the whole S_freq
    %global S_freq S_time
    S_freq(maxRows) = spline(x, M(maxRows,1:maxCols));

    %manually allocate memory for surface of S
    S_surf = zeros(maxRows*(n+1)-n , maxCols*(n+1)-n);
    S_surf(maxRows*(n+1)-n,:) = ppval(S_freq(maxRows), xx);

    %create splines 1:maxRows-1;
    for i = 1:maxRows-1
        S_freq(i) = spline(x, M(i,1:maxCols));
        S_surf(i*(n+1)-n,:) = ppval(S_freq(i), xx);
    end


    %splines with fixed frequency
    y = (1:1:maxRows);
    yy = linspace(1,maxRows,maxRows*(n+1)-n);

    %manually create last entry to preallocate memory for whole S_time
    S_time(maxCols) = spline(y, M(1:maxRows, maxCols));
    S_surf(:,maxCols*(n+1)-n) = ppval(S_time(maxCols), yy);

    %create splines 1:maxCols-1;
    for i = 1:maxCols-1
        S_time(i) = spline(y, M(1:maxRows, i));
        S_surf(:,i*(n+1)-n) = ppval(S_time(i), yy);
    end
    S_surf(S_surf<0) = 0;
    S_surf = finiteDifference(S_surf, n);
end

function S_surf = finiteDifference(S_surf, n)
    global maxRows maxCols
  
    for j = 0:maxRows-2 %time
        for i = 0:maxCols-2 %freq
            %This line of code is an abomination but what its doing is that
            %its going through each "square" in the mesh and performing
            %finite differences as stated in centeredDifference
            S_surf(j*(n+1)+1:(j+1)*(n+1)+ 1, i*(n+1)+1:(i+1)*(n+1)+1) = centeredDifference(n+2, S_surf(j*(n+1)+1:(j+1)*(n+1)+ 1, i*(n+1)+1:(i+1)*(n+1)+1));
        end
    end
end

