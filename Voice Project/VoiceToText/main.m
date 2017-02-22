clc, close all, clear all

fileName = 'newA.txt'; %fileName from voiceToText.java
%This will eventually be changed to match the word that is being analyzed

n = 3; %number of interpolated points between control points
%higher mesh sizes will have more data to analyze but will be
%computationally expensive

createInterpolation(fileName, n);