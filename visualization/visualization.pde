import org.json.*;

PImage img, maskImg;

String username = "coleagleason";
float friends = 150;
float r = 700;

void setup() {
   // this grabs the profile picture of the user from the web and masks it.
   String url = "http://graph.facebook.com/"+username+"/picture?width=200&height=200";
   img = loadImage(url, "jpg");
   maskImg = loadImage("circleMask.png");
   size(1200, 800);
   img.mask(maskImg);
 }

void draw() {
  background(26,26,26);
  scale(0.5);
  translate(width/2, height/2);
  image(img, width/2 - 100, height/2 - 100);
  stroke(255);
  strokeWeight(7);
  fill(0, 0);
  ellipse(width / 2, height / 2, 200, 200);
  
  noStroke();
  fill(255, 255, 255);
  float theta = 0, sep = TWO_PI/friends;
  for(int i = 0; i < friends; i++) {
    float x = r * cos(theta);
    float y = r * sin(theta);
    ellipse(width/2 + x, height/2 - y, 10, 10);
    theta += sep;
  }

}
