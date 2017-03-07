clc, close all, clear all

fileName = 'newA.txt'; %fileName from voiceToText.java
%This will eventually be changed to match the word that is being analyzed

n = 3; %number of interpolated points between control points
%higher mesh sizes will have more data to analyze but will be
%computationally expensive

M = createInterpolation(fileName, 3);

dlmwrite('outFile.txt',M,'delimiter',' ','precision',6)