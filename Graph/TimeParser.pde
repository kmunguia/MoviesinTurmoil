class TimeParser {
  
  int year;
  final float xCoordinateTimeparser = 0.15*width;
  final float yCoordinateTimeparser = 0.69*height;
  
  TimeParser(int year) {
    this.year = year;
  }
  
  void update() {
    fill(200, 200, 200);
    rect(xCoordinateTimeparser, yCoordinateTimeparser, 0.7*width, 15);
    
    this.year = (int) map(mouseX, 0, width, 1986, 2017);
    fill(0,0,0);
    textSize(40);
    text(year, 0.08*width, 0.1*height);
  }

}