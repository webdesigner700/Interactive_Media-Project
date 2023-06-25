import processing.video.*;
import beads.*;

int width = 1400;
int height = 800;
int x1 = width/4;
int x2 = width/3 + 75;
int y = height - 350;
int Yline = height - 325;
int buttonx = 50;
int buttony = 50;
int buttonsize = 75;
int particleX;
int particleY;
boolean buttonchecker;
boolean keychecker;
boolean keychecker1;
boolean keychecker2;
boolean keychecker3;
boolean keychecker4;
boolean moviechecker1;
boolean moviechecker2;
boolean moviechecker3;
boolean moviechecker4;
boolean soundchecker;
int mouseClicks = 0;
PImage background; // Declaring an image object for the background
Movie movie; //Declaring the movie object
AudioContext ac;
int resolution;
int xInc;
int yInc;


ArrayList<Particle> particles = new ArrayList<Particle>(); //creating an array list of particles

float circleX;
float circleY;
float xspeed = 10;
float yspeed = 2;


//Create an array of many particles
//create a push function and call it on teh array in the draw function

void setup() {
  
  size(1400, 800);
  
  //Load and play the video in a loop
  movie = new Movie(this, "Background.mp4"); //Initialising the movie objct with the video file
  movie.loop();
  
  background = loadImage("pattern.png"); // Loading the image into the program
  
  //Audio code for car
  ac = AudioContext.getDefaultContext(); 
  // A new Audio context is created which is a link to the audio hardware on your computer
  SamplePlayer player = new SamplePlayer(SampleManager.sample(dataPath("Synthwave.mp3")));
  //put the sample into the sample player
  Gain g = new Gain(ac, 2, 0.6);
  //create a gain object to control the sound
  g.addInput(player);
  //add the sample player object into the gain object for controlling the player
  ac.out.addInput(g);
  //add the gain object to the audio input
  
}

void draw() {
  
  
  background(0);
  
  line(700, height - 150, 700, height);
  textSize(20);
  fill(255);
  text("Click Mouse odd times - retro pixel block effect", 20, height - 130);
  text("Click Mouse even times - retro pixel dot effect", 20, height - 100);
  
  if (moviechecker1 == true) {
    fill(0, 255, 0);
    text("Press 1 - Background video speed becomes 3x slower", 20, height - 70); 
  }
  else {
    fill(255);
    text("Press 1 - Background video speed becomes 3x slower", 20, height - 70); 
  }
  
  if (moviechecker2 == true) {
    fill(0, 255, 0);
    text("Press 2 - Background video speed becomes 1x slower", 20, height - 40); 
  }
  else {
    fill(255);
    text("Press 2 - Background video speed becomes 1x slower", 20, height - 40); 
  }
  
  if (moviechecker3 == true) {
    fill(0, 255, 0);
    text("Press 3 - Background video speed becomes 1x faster", 20, height - 10);
  }
  else {
    fill(255);
    text("Press 3 - Background video speed becomes 1x faster", 20, height - 10);
  }

  if (moviechecker4 == true) {
    fill(0, 255, 0);
    text("Press 4 - Background video speed becomes 3x faster", 720, height - 130); 
  }
  else {
    fill(255);
    text("Press 4 - Background video speed becomes 3x faster", 720, height - 130); 
  }
  
  if (keychecker1 == true) {
    fill(0, 255, 0);
    text("Press q - exhaust particles move very slowly", 720, height - 100); 
  }
  else {
    fill(255);
    text("Press q - exhaust particles move very slowly", 720, height - 100);
  }
  
  if (keychecker2 == true) {
    fill(0, 255, 0);
    text("Press w - exhaust particles move a bit faster", 720, height - 70); 
  }
  else {
    fill(255);
    text("Press w - exhaust particles move a bit faster", 720, height - 70); 
  }
  
  if (keychecker3 == true) {
    fill(0, 255, 0);
    text("Press e - exhaust particles move at a fast rate", 720, height - 40); 
  }
  else {
    fill(255);
    text("Press e - exhaust particles move at a fast rate", 720, height - 40);
  }
  
  if (keychecker4 == true) {
    fill(0, 255, 0);
    text("Press r - exhaust particles move rapidly", 720, height - 10); 
  }
  else {
    fill(255);
    text("Press r - exhaust particles move rapidly", 720, height - 10); 
  }
  
  image(movie, 0, 0, width, Yline); // movie is being played (background video)
  if (is_movie_finished(movie)) {
    movie.jump(0);
  }
  
  image(background, 0, Yline, width, height - Yline - 150); //TO INCREASE BOTTOM AREA CHANGE "- 100" VALUE TO SOMETHING ELSE
 
  stroke(255); //all the line outlines are white
  
  //Code for the button
  fill(0); // Black colour for the rectangle
  rect(0, 0, buttonsize, buttonsize);
  fill(0, 0, 255); //blue colour for the triangle
  triangle(10, 5, 70, 37.5, 10, 70);
  
  //code for showing amount of mouse clicks
  fill(255);
  text("Button Clicks -", width - buttonsize - 150, 40);
  fill(0);
  rect(width - buttonsize, 0, buttonsize, buttonsize);
  fill(0, 255, 0);
  textSize(62);
  text(mouseClicks, (width - buttonsize) + 2, buttonsize/2 + 20);
  
  noFill(); // blue colour and black colour are gonna be dropped
  
  //Code for the ground line
  line(0, Yline, width, Yline);
  
 
  
  particles.add(new Particle(x1 - 60, y));
  
  if (soundchecker == true) {
     ac.start();
  }

  //Car and boost is drawn when button is pressed
  if (buttonchecker == true) {
    
    soundchecker = true;
    
    if (moviechecker1 == true) {
      movie.speed(-2);
    }
    else if (moviechecker2 == true) {
      movie.speed(-1);
    }
    else if (moviechecker3 == true) {
      movie.speed(2);
    }
    else if (moviechecker4 == true) {
      movie.speed(3);
    }
    
    stroke(191, 64, 191); // sets a purple outline for the car
    strokeWeight(6);  //sets the outline thickness for the car
    strokeCap(ROUND); // makes the outline rounded
    fill(#240132); // sets the colour of the car
    drawCar();
    fill(#212121); // fills the colour of the particles
    stroke(#3D3D3D); // outlines teh colour of the particles
    strokeWeight(4);
    for (Particle particle : particles) {
      
      if (keychecker1 == true) {
        particle.updateParticles1();
        particle.show();
      }
      else if (keychecker2 == true) {
        particle.updateParticles2();
        particle.show();
      }
      else if (keychecker3 == true) {
        particle.updateParticles3();
        particle.show();
      }
      else if (keychecker4 == true) {
        particle.updateParticles4();
        particle.show();
      }

    }
    
    if (mouseClicks % 2 == 0) { // for even number
      
      loadPixels();
      for (int x = 0; x < width; x++) { //random pixelated color effect
        for (int y = Yline; y < height - 150; y++) {
          pixels[(y * width) + x] = color(random(0, 255), random(0, 255), random(0, 255)); 
        }
      }
      updatePixels();
    }
    else if (mouseClicks % 2 != 0) { // for odd number
      
      resolution = 100; // retro pixel block effect
      xInc = width/resolution;
      yInc = height/resolution;
      for (int y = Yline; y < height - 150; y += yInc) {
        for (int x = 0; x < width; x += xInc) {
          fill(random(0, 255), random(0, 255), random(0, 255));
          rect(x, y, xInc, yInc); 
        }
      }
    }
  }
  
}     

class Particle {
  
  //Global variables fo class
  float x;
  float y;
  float velocityX; // determines the velovity of particle in x direction
  float velocityY; // determines the velocity of particle in y direction
  float alpha = 255;
  
  // constructor of the class
  Particle(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  //have four methods for different speeds of particles
  
  //this method change the (x,y) coordinate of the particle with the random numbers of velocityX and velocityY  
  void updateParticles1() { //happens when 1 is pressed on key
    this.velocityX = random(-5, -1);
    this.velocityY = random(-5, -0.1);
    this.alpha = 255;
    this.x += this.velocityX;
    this.y += this.velocityY;
    this.alpha -= 5;
  }
  
  void updateParticles2() {
    this.velocityX = random(-40, -20);
    this.velocityY = random(-10, -2);
    this.alpha = 255;
    this.x += this.velocityX;
    this.y += this.velocityY;
    this.alpha -= 5;
  }
  
  void updateParticles3() {
    this.velocityX = random(-60, -40);
    this.velocityY = random(-15, -5);
    this.alpha = 255;
    this.x += this.velocityX;
    this.y += this.velocityY;
    this.alpha -= 5;
  }
  
  void updateParticles4() {
    this.velocityX = random(-80, -60);
    this.velocityY = random(-20, -10);
    this.alpha = 255;
    this.x += this.velocityX;
    this.y += this.velocityY;
    this.alpha -= 5;
  }
  
  
  
  //show method to display the particles
  void show() {
    ellipse(this.x, this.y, 15, 15); //last two parameters determine width and height - can be changed by user input or audio input
  }
  
}

void drawCar() { // can eventually put drawCar() in the draw function
  
  circle(x1, y, 50); 
  circle(x2, y, 50);
  circle(x1, y, 25);
  circle(x2, y, 25);
  rect(x1 - 50, y - 50, x2 + 50 - (x1 - 50), 50);
  quad(x1 - 25, y - 100, x2 - 25, y - 100, x2, y - 50, x1, y - 50);
  //stroke(0, 255, 0);
  line(x1 - 75, y - 100, x1 - 50, y - 50);

  
}

// creating button functions

boolean overButton() {
  
  if (mouseX > 0 && mouseX <= 75 && mouseY > 0 && mouseY <= 75) {
    return true;
  }
  else {
    return false;
  }
  
}

void mouseClicked() { // called if mouse is clicked

    if (overButton() == true) {
      buttonchecker = true;
      mouseClicks = mouseClicks - 1;
    }
    
    if ((mouseButton == LEFT) || (mouseButton == RIGHT)) {
      mouseClicks++; 
    }

}

// New frames from the movie are read
void movieEvent(Movie movie) {
  movie.read();
}

void keyPressed() {
  
  if (key == 'q') {
    keychecker1 = true;
  }
  else if (key == 'w') {
    keychecker2 = true;
  }
  else if (key == 'e') {
    keychecker3 = true;
  }
  else if (key == 'r') {
    keychecker4 = true;
  }
  else if (key == '1') {
    moviechecker1 = true;
  }
  else if (key == '2') {
    moviechecker2 = true;
  }
  else if (key == '3') {
    moviechecker3 = true;
  }
  else if (key == '4') {
    moviechecker4 = true;
  }
}

boolean is_movie_finished(Movie movie) {
  
  return movie.duration() - movie.time() < 0.05;
}
