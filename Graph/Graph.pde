//TimeParser timeparser = new Timeparser();
TableReader tableReader;
ArrayList<Movie> movies;
HashMap<Integer, Year> years;
HashMap<Integer, Float> maxGrossPerYear;
HashMap<Integer, Float> moviesPerYear;
HashMap<String,Integer> genreColors;
TimeParser timeParser;
Button button;
Integer x = 0;


void setup() {
  size(1000, 850);
  pixelDensity(displayDensity());
  tableReader = new TableReader();
  movies = tableReader.loadData("IMDBdata.csv");
  years = new HashMap<Integer, Year>();
  maxGrossPerYear = new HashMap<Integer, Float>();
  moviesPerYear = new HashMap<Integer, Float>();
  String[] names = {"Action", "Adventure", "Animation", "Biography", "Comedy", "Crime",
                    "Documentary", "Drama", "Family", "Fantasy", "Film-Noir", "History",
                    "Horror", "Music", "Musical", "Mystery", "Romance", "Sci-Fi",
                    "Sport", "Thriller", "War", "Western"};
  
  for(Movie movie : movies) {
    Integer currYear = Integer.parseInt(movie.year);
    float tempMoviesPerYear = moviesPerYear.get(currYear) == null ? 0 : moviesPerYear.get(currYear);
    if(!years.containsKey(currYear)){
        years.put(currYear, new Year(currYear.intValue(), names));
    }
    Year currYearObj = years.get(currYear);
    ArrayList<Genre> genres = currYearObj.genres;
   
    for(int i = 0; i < genres.size(); i++) {
      Genre genre = genres.get(i);
      if(movie.hasGenre(genre.name)){
        moviesPerYear.put(currYear, ++tempMoviesPerYear);
        genre.numMovies += 1f;
        genre.totalGross += movie.gross;
        genres.set(i, genre);
        float temp = maxGrossPerYear.get(currYear) != null ? maxGrossPerYear.get(currYear) : 0f;
        maxGrossPerYear.put(currYear, temp < genre.totalGross ? genre.totalGross : temp);
      }
    }
    currYearObj.genres = genres;
    years.put(currYear, currYearObj);

  }
  //for(Integer year : years.keySet()) {
  //  Year currYear = years.get(year);
  //  for(Genre genre : currYear.genres) {
  //    System.out.println("The total gross for " + genre.name + " in " + year + " was " + genre.totalGross + " and the number of Movies was " + genre.numMovies);
  //  }
  //}
  timeParser = new TimeParser(1986); 
  button = new Button(0.15*width);
}

void draw() {
  background(255, 255, 255);
  x =0;
  timeParser.update();
  button.update();
  Year yearToDraw = years.get(timeParser.year);
  yearToDraw.update(maxGrossPerYear.get(yearToDraw.year), moviesPerYear.get(yearToDraw.year));
  
  //Button Dragging
  
  
  //Color lengend
  genreColors = yearToDraw.getColors();
  for(String key: genreColors.keySet()){
    fill(genreColors.get(key));
    rect(900,x+30, 10,10);
    textSize(12);
    fill(0,0,0);
    text(key, 920, x+40);
    x+=30;
  }
}