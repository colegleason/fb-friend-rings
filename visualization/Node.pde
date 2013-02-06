public class Node {
  private float x;
  private float y;
  public String id;
  public String name = "Unknown";
  public int popup_transparency = 0;
  public float theta;
  public float r;
  public int messages = 0;
  public int first_time = 0;
  public int last_time = 0;
  
  public Node(String id, float theta, float r) {
    this.theta = theta;
    this.r = r;
    this.id = id;   
    name = id;
  }
  
  public void draw(int d, int curr) {
    noStroke();
    fill(255);
    ellipse(x, y, d, d);
    
    // pulse
    stroke(255, 140, 0);
    fill(0,0);
    int weight = 3*Math.max(0, 5 - (curr - last_time));
    if (weight == 0) {
      noStroke();
    } else{
      strokeWeight(weight);
    }
    ellipse(x, y, d + weight, d + weight);
    // popup
    
    fill(255, popup_transparency);
    noStroke();
    rect(x, y, Math.max(20*name.length(),270), 100);
    fill(0, popup_transparency);
    textSize(32);
    textAlign(LEFT);
    text(name, x + 10, y + 40);
    text("messages: "+ messages, x + 10, y + 70);

    tint(255, popup_transparency);    
  }
  
  public void sentMessage(int curr) {
    messages++;
    if (first_time == 0) {
      first_time = curr;
    }
    last_time = curr;
  }
  
  public void update(int curr) {
    float a = constrain(200, r*(1 - messages/float(curr-first_time)), r);
    x = width/2 +  a * cos(theta);
    y = height/2 - a * sin(theta);
    if (dist(mouseX/0.5 - width/2, mouseY/0.5 - height/2, x, y) < 15) {
      popup_transparency += 20;
    } else {
      popup_transparency -= 3;
    }
    popup_transparency = constrain(0, popup_transparency, 255);
  }
    
  
}
