# VoiceInterpolation

This project is the interpolation of a sound wave. Interpolation of a sound wave is a way of 'enhancing' the audio to make it better than it actually is. This project attempts to bypass the restrictions of the sample rate of the wave. For better explanation of how interpolation works and why it is useful, reference https://alpha-ii.com/Info/AudioInt.html.

Specifically in my algorithm for interpolation, I create a bicubic spline mesh. This means that I map a cubic polynomial of (frequency,amplitude) at each fixed time interval and a cubic polynomial of (time, amplitude) at each fixed frequency.

A cubic spline is second derivative piecewise continuous function that maps through each data point x_1 to x_n. 

Finally, in order to find the points in the intesection of each square of cubic spline, I perform finite differences as referenced in:

H. S. Hou and H. C. Andrews, “Cubic splines for image interpolation and digital filtering,” IEEE Trans. Acoust., Speech, SignalProcessing, vol. ASSP-26, Dec. 1978.

My finite difference scheme has not currently been completed, but I should be finished with it rather soon.
