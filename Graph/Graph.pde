//TimeParser timeparser = new Timeparser();
TableReader tableReader;
ArrayList<Movie> movies;
HashMap<Integer, Year> years;
HashMap<Integer, Float> maxGrossPerYear;
HashMap<Integer, Float> moviesPerYear;
TimeParser timeParser;

void setup() {
  size(1000, 850);
  pixelDensity(displayDensity());
  tableReader = new TableReader();
  movies = tableReader.loadData("IMDBbdata.csv");
  years = new HashMap<Integer, Year>();
  maxGrossPerYear = new HashMap<Integer, Float>();
  moviesPerYear = new HashMap<Integer, Float>();
  for(Movie movie : movies) {
    Integer currYear = Integer.parseInt(movie.year);
    float tempMoviesPerYear = moviesPerYear.get(currYear) == null ? 0 : moviesPerYear.get(currYear);
    moviesPerYear.put(currYear, tempMoviesPerYear + 1);
    if(!years.containsKey(currYear)){
        years.put(currYear, new Year(currYear.intValue()));
    }
    Year currYearObj = years.get(currYear);
    ArrayList<Genre> genres = currYearObj.genres;
    for(int i = 0; i < genres.size(); i++) {
      Genre genre = genres.get(i);
      if(movie.hasGenre(genre.name)){
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
  timeParser = new TimeParser(1986); 
}

void draw() {
  background(255, 255, 255);
  timeParser.update();
  Year yearToDraw = years.get(timeParser.year);
  yearToDraw.update(maxGrossPerYear.get(yearToDraw.year), moviesPerYear.get(yearToDraw.year));
}