class Year {
  final int year;
  HashMap<String, Integer> colors = new HashMap<String, Integer>();
  ArrayList<Genre> genres;
  private final String[] genreNames = {"Action", "Adventure", "Animation", "Biography", "Comedy", "Crime"
     , "Documentary", "Drama", "Family", "Fantasy", "Film-Noir", "History", "Horror", "Music", "Musical"
   , "Mystery", "Romance", "Sci-Fi", "Sport", "Thriller", "War", "Western"};
   
  public Year(final int year) {
    this.year = year;
    this.genres = new ArrayList<Genre>();
    
       colors.put("Action", color(255,0,0)); //red
       colors.put ("Romance", color(255,102,178)); //neon purple
       colors.put( "Drama", color(0,153,153)); //dark teal
       colors.put("Documentary",color(0,204,102));// green
       colors.put("Adventure", color(255,255,51));;// yellow
       colors.put("Animation", color(255,204,153));//
       colors.put("Biography",color(102,178,255));
       colors.put("Family", color(102,255,102));
       colors.put("Fantasy",color(178,102,255));
       colors.put("Film-Noir", color(64,64,64));
       colors.put("History", color(102,0,51));
       colors.put("Western", color(194,203,106));
       colors.put("Mystery",color(0,102,102));
       colors.put("Horror", color(153,0,0));
       colors.put("Sport",color(106,203,197));
       colors.put("War", color(0,25,51));
       colors.put("Thriller",color(76,0,153));
       colors.put("Music", color(255,0,255));
       colors.put("Musical", color(192,192,192));
       colors.put("Crime",color(102,102,0));
       colors.put("Comedy", color(255,153,51));
       colors.put("Sci-Fi", color(0,0,153));

    
    for(int i = 0; i < genreNames.length; i++) {
      float R = random(255);
      float G = random(255);
      float B = random(255);
      color colour = color(R, G, B);
      genres.add(new Genre(genreNames[i], 0f, 0f, colors.get(genreNames[i])));
    }
  }
  
  void update(float maxGross, float numMovies) {
    float theta = 0;
    for(Genre genre : genres) {
      float arc_length = map(genre.numMovies, 0f, numMovies, 0, 2 * (float) Math.PI);
      genre.update(width/2, 2*height/5, theta, theta + arc_length, maxGross);
      theta = theta + arc_length;
    }
  }
  
}