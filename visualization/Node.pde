public class Node {
  private float x;
  private float y;
  public String id;
  public int d;
  public int popup_transparency = 0;
  public float theta;
  public float r;
  public int messages = 0;
 public int pulse = 0;
  
  public Node(String id, float theta, float r, int d) {
    this.theta = theta;
    this.r = r;
    this.id = id;   
    this.d = d;
  }
  
  public void draw(int curr) {
    noStroke();
    fill(255);
    ellipse(x, y, d, d);
    
    // pulse
    stroke(255, 140, 0);
    fill(0,0);
    int weight = 3*Math.max(0, pulse);
    pulse--;
    if (weight == 0) {
      noStroke();
    } else{
      strokeWeight(weight);
    }
    ellipse(x, y, d + weight, d + weight);
    
    // popup
    
    fill(255, popup_transparency);
    noStroke();
    rect(x, y, Math.max(20*id.length(),270), 100);
    fill(0, popup_transparency);
    textSize(32);
    textAlign(LEFT);
    text(id, x + 10, y + 40);
    text("messages: "+ messages, x + 10, y + 70);
  }
  
  public void sentMessage(int curr) {
    messages++;
    pulse = 5;
  }
  
  public void update(float freq) {
    float a = constrain(100, r*(1 - freq), r);
    x = width/2 +  a * cos(theta);
    y = height/2 - a * sin(theta);
    if (dist(mouseX/0.5 - width/2, mouseY/0.5 - height/2, x, y) < float(d)*0.75) {
      popup_transparency = 255;
    } else {
      popup_transparency -= 7;
    }
    popup_transparency = constrain(0, popup_transparency, 255);
  }
    
}
