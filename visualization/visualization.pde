import org.json.*;

PImage img, maskImg;

String username = "coleagleason";
float r = 720;

HashMap<String, visualization.Node> friends;
ArrayList<String> messages;

int curr = 0;

void setup() {
  friends = new HashMap();
  messages = new ArrayList<String>();
  loadMessages();
  // this grabs the profile picture of the user from the web and masks it.
  String url = "http://graph.facebook.com/"+username+"/picture?width=200&height=200";
  img = loadImage(url, "jpg");
  maskImg = loadImage("circleMask.png");
  img.mask(maskImg);

  size(1680, 1000);
}

void draw() {
  background(26, 26, 26);
  scale(0.5);
  translate(width/2, height/2);

  drawUser(200);
  drawFriendRings(300, 500, 700);
  drawNodes(r, curr);
  if (curr < messages.size()) {
    String authorId = messages.get(curr);
    Node author = friends.get(authorId);
    if (author != null) {
      author.sentMessage(curr);
    } else {
      print("Error with: " + authorId);
    }
    curr++;
  }
  fill(100, 100, 100, 255);
  textSize(38);
  text("Messages: " + curr + "/" + messages.size(), width / 2 + 700, height / 2 + 700);
}

void drawUser(int imgSize) {
    tint(255,255);
  image(img, width/2 - imgSize/2, height/2 - imgSize/2);
  stroke(255);
  strokeWeight(7);
  fill(0, 0);
  ellipse(width / 2, height / 2, imgSize, imgSize);
}


void drawFriendRings(int ra, int rb, int rc) {
  // friend rings
  fill(0, 0);
  stroke(100, 100, 100);
  strokeWeight(2);
  ellipse(width / 2, height/ 2, 2*ra, 2*ra);
  ellipse(width / 2, height/ 2, 2*rb, 2*rb);
  ellipse(width / 2, height/ 2, 2*rc, 2*rc);
  // friend rings text
  fill(100, 100, 100, 255);
  textSize(32);
  textAlign(CENTER);
  text("close friends", width / 2, height / 2 + ra - 25);
  text("friendly", width / 2, height / 2 + rb - 25);
  text("barely talk", width / 2, height / 2 + rc - 25);
}

void drawNodes(float r, int curr) {
  noStroke();
  fill(255, 255, 255);
  float theta = 0;
  Iterator i = friends.entrySet().iterator();
  while(i.hasNext()) {
    Node node = (Node) ((Map.Entry) i.next()).getValue();
    node.update(curr);
    node.draw(10, curr);
  }
}

void loadMessages() {
  String[] lines = loadStrings("fbmessages.csv");
  for(int i=0; i < lines.length; i++) {
    String[] tokens = splitTokens(lines[i], ",");
    if (friends.get(tokens[1]) == null) {
      Node friend = new Node(tokens[1], TWO_PI/lines.length, r);
      friends.put(tokens[1], friend);
    }
    messages.add(tokens[1]);
  }
  Iterator i = friends.entrySet().iterator();
  int j = 0;
  while(i.hasNext()) {
    Node node = (Node) ((Map.Entry) i.next()).getValue();
    node.theta = j*TWO_PI/friends.size();
    j++;
  }
}
    
