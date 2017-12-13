class Genre {
   String name;
   float totalGross;
   float numMovies;
   color colour;

   
   public Genre(String name, float totalGross, float numMovies, color colour) {
     this.name = name;
     this.totalGross = totalGross;
     this.numMovies = numMovies;
     this.colour = colour;

   }
   
   void update(int x, int y, float startTheta, float endTheta, int year, boolean muted) {
     noStroke();
     fill(muted ? #999999 : colour, muted ? 140 : 255);
     float averageGross = numMovies == 0 ? 0 : totalGross/numMovies;
     float gross = map((float) Math.pow(0.97,(year-1985))*averageGross, 0, 130, 0, 600);
     arc(x, y, gross, gross, startTheta, endTheta);
   }
   
}