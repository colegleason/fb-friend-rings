import org.json.*;
import java.text.SimpleDateFormat;
import java.util.*;

PImage img, maskImg;

String username = "coleagleason";
float r = 720;

SimpleDateFormat formatter;

HashMap<String, visualization.Node> friends;
HashMap<String, Integer> mCounts;
ArrayList<Message> messages;

Node max_author = null;
int curr = 0;

void setup() {
  friends = new HashMap();
  messages = new ArrayList<Message>();
  formatter = new SimpleDateFormat("MMMM yyyy");
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
  Date date = new Date ();

  if (curr < messages.size()) {
    Message m = messages.get(curr);
    mCounts = countMessages(m.timestamp - (30*24*60*60), m.timestamp);
    date.setTime((long)m.timestamp*1000);
    Node author = friends.get(m.author);
    if (author != null) {
      author.sentMessage(curr);
      if (max_author == null || author.messages > max_author.messages)
        max_author = author;
    } else {
      print("Error with: " + m.author);
    }
     curr++;
  }
  drawUser(200);
  drawFriendRings(300, 500, 700);
  drawNodes(r, mCounts);

  fill(100, 100, 100, 255);
  textSize(38);
  textAlign(CENTER);
  text(formatter.format(date), width / 2 + 700, height / 2 + 600);
  int percent = (int)(100*float(curr)/messages.size());
  text("Messages: " + curr + "/" + messages.size() + " ("+ percent + "%)", width / 2 + 700, height / 2 + 700);
}

void drawUser(int imgSize) {
  tint(255,255);
  image(img, width/2 - imgSize/2, height/2 - imgSize/2);
  stroke(100);
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

void drawNodes(float r, HashMap<String, Integer> mCounts) {
  noStroke();
  fill(255, 255, 255);
  float theta = 0;
  Iterator i = friends.entrySet().iterator();
  while(i.hasNext()) {
    Node node = (Node) ((Map.Entry) i.next()).getValue();
    float freq;
    Object count = mCounts.get(node.id);
    if (count != null) {
      freq = float((Integer) count) / getMaxCount(mCounts);
    } else {
      freq = 0.0;
    }
    node.update(freq);
    node.draw(curr);
  }
}

HashMap<String, Integer> countMessages(int timestart, int timeend) {
  HashMap<String, Integer> hm = new HashMap<String, Integer>();
  for(int i = 0; i < curr; i++) {
    Message m = messages.get(i);
    if (m.inRange(timestart, timeend)) {
      if (hm.containsKey(m.author)) {
        hm.put(m.author, (Integer) hm.get(m.author) + 1);
      }
      else {
        hm.put(m.author, 1);
      }
    }
  }
  return hm;
}

int getMaxCount(HashMap<String, Integer> hm) {
  Iterator i = hm.entrySet().iterator();
  int max_count = 1;
  while(i.hasNext()) {
    Integer count = (Integer) ((Map.Entry) i.next()).getValue();
    if (count > max_count) {
      max_count = count;
    }
  }
  return max_count;
}

void loadMessages() {
  String[] lines = loadStrings("fbmessages.csv");
  for(int i=0; i < lines.length; i++) {
    String[] tokens = splitTokens(lines[i], ",");
    if (friends.get(tokens[1]) == null) {
      Node friend = new Node(tokens[1], TWO_PI/lines.length, r, 10);
      friends.put(tokens[1], friend);
    }
    messages.add(new Message(tokens[1], int(tokens[0])));
  }
  Iterator i = friends.entrySet().iterator();
  int j = 0;
  while(i.hasNext()) {
    Node node = (Node) ((Map.Entry) i.next()).getValue();
    node.theta = j*TWO_PI/friends.size();
    j++;
  }
}


