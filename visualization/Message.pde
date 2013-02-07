public class Message {
  int timestamp;
  String author;
  
  public Message(String author, int timestamp) {
    this.author = author;
    this.timestamp = timestamp;
  }
  
  public boolean inRange(int time1, int time2) {
    return (time1 <= timestamp) && (timestamp <= time2);
  }
}
