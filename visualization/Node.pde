public class Node {
  public String id;
  public float theta;
  public float r;
  public int messages = 0;
  public int first_time = 0;
  public int last_time = 0;
  
  public Node(String id, float theta, float r) {
    this.theta = theta;
    this.r = r;
    this.id = id;
  }

  public void draw(int d, int curr) {
    noStroke();
    fill(255);
    float x = r*(1 - messages/float(curr-first_time)) * cos(theta);
    float y = r*(1 - messages/float(curr-first_time)) * sin(theta);
    ellipse(width/2 + x, height/2 - y, d, d);
    
    // pulse
    stroke(255, 140, 0);
    fill(0,0);
    int weight = 3*Math.max(0, 5 - (curr - last_time));
    if (weight == 0) {
      noStroke();
    } else{
      strokeWeight(weight);
    }
    ellipse(width/2 + x, height/2 - y, d + weight, d + weight);
  }
  
  public void sentMessage(int curr) {
    messages++;
    if (first_time == 0) {
      first_time = curr;
    }
    last_time = curr;
  }
  
}
