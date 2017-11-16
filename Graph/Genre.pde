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
   
   void update(int x, int y, float startTheta, float endTheta, float maxGross) {
     noStroke();
     fill(colour);
     float gross = map(totalGross, 0, maxGross, 0, 600);
     arc(x, y, gross, gross, startTheta, endTheta);
   }
}