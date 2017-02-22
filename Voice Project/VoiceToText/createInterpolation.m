%-----------------------------------------------------------------
% Darren Gomez
%
% Interpolation of a sound wave:
% This function reads in a text file containing a sound wave
% Creates a spline of time, amplitude at every fixed freq.
% Creates a spline of freq, amplitude at every fixed time interval.
% Plots n spline points between each intersecting spline
%
% Uses finite difference for splines as stated in H. S. Hou and H. C. 
%   Andrews, “Cubic splines for image interpolation and digital filtering,” 
%   IEEE Trans. Acoust., Speech, SignalProcessing, vol. ASSP-26, Dec. 1978.
%
%
% The Finite Differences part has not been added yet but will be soon.
% Right now, each intersection of spline has a blank square of nxn grid
% points between them. They will be filled in.
%-----------------------------------------------------------------

%Matrix of data where M[time][freq] = amplitude
%reads in a file as created by processing file VoiceToText

function createInterpolation(fileName, n)
    M = dlmread(fileName, ' ');
    sizeM = size(M); %sizeM(1) = #rows; sizeM(2) = #cols;
    maxRows = sizeM(1); %time
    maxCols = sizeM(2); %freq; usually sizeM(2); 
 

    % n is the number of interpolated points between i and i+1. also j and j+1 because square mesh

    %splines with fixed time
    x = (1:1:maxCols);
    xx = linspace(1,maxCols,maxCols*n); 

    %manually create last entry to preallocate memory for the whole S_freq
    S_freq(maxRows) = spline(x, M(maxRows,1:maxCols));

    %manually allocate memory for surface of S
    S_surf = zeros(maxRows*n , maxCols*n);
    S_surf(maxRows*n,:) = ppval(S_freq(maxRows), xx);

    %create splines 1:maxRows-1;
    for i = 1:maxRows-1
        S_freq(i) = spline(x, M(i,1:maxCols));
        S_surf(i*n,:) = ppval(S_freq(i), xx);
    end


    %splines with fixed frequency
    y = (1:1:maxRows);
    yy = linspace(1,maxRows,maxRows*n);

    %manually create last entry to preallocate memory for whole S_time
    S_time(maxCols) = spline(y, M(1:maxRows, maxCols));
    S_surf(:,maxCols*n) = ppval(S_time(maxCols), yy);

    %create splines 1:maxCols-1;
    for i = 1:maxCols-1
        S_time(i) = spline(y, M(1:maxRows, i));
        S_surf(:,i*n) = ppval(S_time(i), yy);
    end

    %for i = 1:maxCols
    %plot the sizeM(1) splines
    surf(S_surf)
    colormap default
end


