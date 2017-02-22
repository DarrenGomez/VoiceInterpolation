/**

Darren Gomez

This program uses Processing 3.1.2 and Minim in order to perform the sound analysis

Interpolation of Sound Waves:
This program reads in a sound file (right now since I've only done the word Doctor, it is hard coded)
It processes a fast fourier transform on the file to transform the file to the space of (frequency, time, amplitude)
At every frame, it processes the amplitude of each frequency and writes this to a matrix A
After the completion of the sound file, it writes the Matrix A to a textfile to be read by createInterpolation.m

Right now, this program is using a bufferSize of 512 to create the FFT. This may be changed but increasing 
this value will be computationally expensive for createInterpolation.m

*/ 
import ddf.minim.analysis.*;
import ddf.minim.*;

PrintWriter output;
Minim  minim;
AudioPlayer sound;
FFT fft;
float[][] A;
int counter;
int rowMaxSize;

void setup(){
  rowMaxSize = 50; 
  size(512,200,P3D);
  minim = new Minim(this);
  
  //This will be changed to read in a file of choice.
  sound = minim.loadFile("Doctor/Doctor(Dictionary.com).mp3", 512);
  
  // This will output a file with the WORD.txt
  output = createWriter("newA.txt");
  sound.play();
  counter = 0; //<>//
  fft = new FFT(sound.bufferSize(), sound.sampleRate());
  A = new float[rowMaxSize][fft.specSize()];
}

void draw(){
  counter++;
  background(0);
  stroke(255);
  fft.forward(sound.mix);
  for(int i = 0; i < fft.specSize(); i++){
    line(i, height, i, height - fft.getBand(i) * 8);
    A[counter][i] = fft.getBand(i);
  }
  if(!sound.isPlaying()){
    System.out.println(counter);
    writeA(A);
    exit();
  }
}

//Writing matrix A to a text file with the delimiter of ' '
void writeA(float[][] A){
  for(int row = 0; row < rowMaxSize; row++){
    String line = "";
    for(int col = 0; col < fft.specSize(); col++){
      line += A[row][col] + " ";
    }
    output.println(line);
  }
}