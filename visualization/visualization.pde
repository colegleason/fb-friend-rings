PImage img, maskImg;

String username = "coleagleason";

void setup() {
   // this grabs the profile picture of the user from the web and masks it.
   String url = "http://graph.facebook.com/"+username+"/picture?width=100&height=100";
   img = loadImage(url, "jpg");
   maskImg = loadImage("circleMask.png");
   size(1000, 700);
   img.mask(maskImg);
}

void draw() {
  background(26,26,26);
  image(img, width/2 - 50, height/2 - 50);
  stroke(255);
  strokeWeight(7);
  fill(0, 0);
  ellipse(width/2, height /2, 100, 100);
}
