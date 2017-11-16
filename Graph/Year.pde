class Year {
  final int year;
  ArrayList<Genre> genres;
  private final String[] genreNames = {"Action", "Adventure", "Animation", "Biography", "Comedy", "Crime"
     , "Documentary", "Drama", "Family", "Fantasy", "Film-Noir", "History", "Horror", "Music", "Musical"
   , "Mystery", "Romance", "Sci-Fi", "Sport", "Thriller", "War", "Western"};
  public Year(final int year) {
    this.year = year;
    this.genres = new ArrayList<Genre>();
    for(int i = 0; i < genreNames.length; i++) {
      float R = random(255);
      float G = random(255);
      float B = random(255);
      color colour = color(R, G, B);
      genres.add(new Genre(genreNames[i], 0f, 0f, colour));
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