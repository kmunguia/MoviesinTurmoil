import de.bezier.guido.*;

TableReader tableReader;
ArrayList<Movie> movies;
HashMap<Integer, Year> years;
HashMap<Integer, Float> moviesPerYear;
HashMap<String, Integer> genreColors;
Integer x = 0;
Boolean mouseOnGenre = false;
String label;
Slider slider;

void setup() {
  size(1000, 850);
  pixelDensity(displayDensity());
  tableReader = new TableReader();
  movies = tableReader.loadData("IMDBdata.csv");
  years = new HashMap<Integer, Year>();
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
      }
    }
    currYearObj.genres = genres;
    years.put(currYear, currYearObj);
  }
  
  Interactive.make(this);
  
  slider = new Slider(0.15*width, 0.69*height, 0.7*width, 15);
}

void draw() {
  
  background(#EEEEDD);
  x = 0;
  slider.update();
  
  Year yearToDraw = years.get(slider.getYear());
  
  genreColors = yearToDraw.getColors();
  
  yearToDraw.update(moviesPerYear.get(yearToDraw.year));
  
  String selectedGenre = mouseOnGenre();
  if(mouseOnGenre) {
    yearToDraw.updateAsMute(moviesPerYear.get(yearToDraw.year), selectedGenre);
  }
  
}

String mouseOnGenre() {
  color rawC = get(mouseX, mouseY);
  label = null;
  for(String key: genreColors.keySet()) {
    if(color(rawC) == genreColors.get(key)) {
      label = key;
      mouseOnGenre = true;
    } 
  }
  if(label == null){
    mouseOnGenre = false;
  }
  return label;
}