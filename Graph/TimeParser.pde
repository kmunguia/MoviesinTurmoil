class TimeParser {
  
  int year;
  
  TimeParser(int year) {
    this.year = year;
  }
  
  void update() {
    this.year = (int) map(mouseX, 0, width, 1986, 2017);
    fill(0,0,0);
    textSize(40);
    text(year, 0.08*width, 0.1*height);
  }

}