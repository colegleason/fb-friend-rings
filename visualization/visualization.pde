import org.json.*;

PImage img, maskImg;

String username = "coleagleason";
float friends = 150;
float r = 720;

void setup() {
   // this grabs the profile picture of the user from the web and masks it.
   String url = "http://graph.facebook.com/"+username+"/picture?width=200&height=200";
   img = loadImage(url, "jpg");
   maskImg = loadImage("circleMask.png");
   img.mask(maskImg);

   size(1680, 1000);
 }

void draw() {
  background(26,26,26);
  scale(0.5);
  translate(width/2, height/2);

  drawUser(200);
  drawFriendRings(300, 500, 700);
  drawNodes(r);
}

void drawUser(int imgSize) {
  image(img, width/2 - imgSize/2, height/2 - imgSize/2);
  stroke(255);
  strokeWeight(7);
  fill(0, 0);
  ellipse(width / 2, height / 2, imgSize, imgSize);
}
  

void drawFriendRings(int ra, int rb, int rc) {
  // friend rings
  fill(0,0);
  stroke(100, 100, 100);
  strokeWeight(2);
  ellipse(width / 2, height/ 2, 2*ra, 2*ra);
  ellipse(width / 2, height/ 2, 2*rb, 2*rb);
  ellipse(width / 2, height/ 2, 2*rc, 2*rc);
  // friend rings text
  fill(100,100,100,255);
  textSize(32);
  textAlign(CENTER);
  text("every day", width / 2, height / 2 + ra - 25);
  text("once a week", width / 2, height / 2 + rb - 25);
  text("once a month", width / 2, height / 2 + rc - 25);
}

void drawNodes(float r) {
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
