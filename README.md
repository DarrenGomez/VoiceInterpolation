# VoiceInterpolation

Requirements:
In order to run this project, you must have:

1.)Matlab

2.)Java Processing

3.)'Minim' Package in Processing

The Idea:
This project is the interpolation of a sound wave. Interpolation of a sound wave is a way of 'enhancing' the audio to make it better than it actually is. This project attempts to bypass the restrictions of the sample rate of the wave. For better explanation of how interpolation works and why it is useful, reference https://alpha-ii.com/Info/AudioInt.html.

Specifically in my algorithm for interpolation, I create a cubic spline meshgrid. By this, I mean that I map a cubic polynomial of (frequency,amplitude) at each fixed time interval and a cubic polynomial of (time, amplitude) at each fixed frequency.

A cubic spline is second derivative piecewise continuous function that maps through each data point x_1 to x_n. 

Finally, in order to find the points in the intesection of each square of cubic spline, I perform finite differences as referenced in:
My eventual goal is to compare different techniques for interpolating the pointes between each square of cubic spline. Currently, I am using a basic 2 dimensional finite difference scheme (specifically central difference) where u(i,j) = [u(i+1,j)+u(i-1,j)+u(i,j+1)+u(i,j-1)]/(4dx^2)

In my next implementation, I play to use the algorithm as specified in: H. S. Hou and H. C. Andrews, “Cubic splines for image interpolation and digital filtering,” IEEE Trans. Acoust., Speech, SignalProcessing, vol. ASSP-26, Dec. 1978.

My goal is to compare the two different interpolation implentations in order to see the difference between them and which is more accurate.
