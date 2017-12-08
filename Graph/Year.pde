class Year {
  final int year;
  HashMap<String, Integer> colors = new HashMap<String, Integer>();
  HashMap<String, Integer> mutedColors = new HashMap<String, Integer>();
  ArrayList<Genre> genres;
  private final String[] names;
   
  public Year(final int year, final String[] names) {
    this.year = year;
    this.genres = new ArrayList<Genre>();
    this.names = names;
    
     colors.put("Action", color(255,0,0)); //red
     colors.put("Romance", color(255,102,178)); // Hot pink
     colors.put("Drama", color(0,153,153)); //dark teal
     colors.put("Documentary",color(0,204,102));// jade
     colors.put("Adventure", color(255,255,51));;// yellow
     colors.put("Animation", color(255,204,153));// Rose
     colors.put("Biography",color(77, 77, 255)); //dark blue
     colors.put("Family", color(102,255,102));// lime green
     colors.put("Fantasy",color(178,102,255)); // neon purple
     colors.put("Film-Noir", color(64,64,64)); // Charcol
     colors.put("History", color(102,0,51)); // indigo
     colors.put("Western", color(194,203,106));// yellow green
     colors.put("Mystery",color(0,102,102));// blue green
     colors.put("Horror", color(153,0,0));// Eggplant
     colors.put("Sport",color(106,203,197));// light green blue
     colors.put("War", color(0,25,51)); // Dark green
     colors.put("Thriller",color(76,0,153)); //purple
     colors.put("Music", color(255,0,255)); //magenta
     colors.put("Musical", color(192,192,192)); //grey
     colors.put("Crime",color(102,102,0));// olive
     colors.put("Comedy", color(255,153,51));// neon orange
     colors.put("Sci-Fi", color(77,121,255));//Sky Blue 
     
    for(int i = 0; i < names.length; i++) {
      genres.add(new Genre(names[i], 0f, 0f, colors.get(names[i])));
    }
     
  }
  
  public HashMap getColors(){
    return this.colors;
  }
  
  void update(float numMovies) {
    float theta = 0;
    for(Genre genre : genres) {
      float arc_length = map(genre.numMovies, 0f, numMovies, 0, 2 * (float) Math.PI);
      genre.update(width/2, 2*height/6, theta, theta + arc_length, year, false);
      theta = theta + arc_length;
    }
  }
  
  void updateAsMute(float numMovies, String label) {
    float theta = 0;
    for(Genre genre : genres) {
      float arc_length = map(genre.numMovies, 0f, numMovies, 0, 2 * (float) Math.PI);
      genre.update(width/2, 2*height/6, theta, theta + arc_length, year, genre.name.equals(label) ? false : true);
      theta = theta + arc_length;
    }
    fill(#111111);
    textSize(32);
    text(label, mouseX, mouseY);
  }
  
}