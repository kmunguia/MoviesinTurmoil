import de.bezier.guido.*;

TableReader tableReader;
ArrayList<Movie> movies;
HashMap<Integer, Year> years;
HashMap<Integer, Float> moviesPerYear;
HashMap<String, Integer> genreColors;
protected ArrayList<Integer> yearNoPic = new ArrayList<Integer>();

Integer x = 0;
Boolean mouseOnGenre = false;
String label;
Slider slider;
void setup() {
  size(1100, 850);
  //pixelDensity(displayDensity());
  tableReader = new TableReader();
  movies = tableReader.loadData("IMDBdata.csv");
  years = new HashMap<Integer, Year>();
  moviesPerYear = new HashMap<Integer, Float>();
  
  yearNoPic.add(1988);
  yearNoPic.add(1990);
  yearNoPic.add(1992);
  yearNoPic.add(1993);
  yearNoPic.add(1994);
  yearNoPic.add(1996);
  yearNoPic.add(1997);
  yearNoPic.add(1998);
  yearNoPic.add(2002);
  yearNoPic.add(2004);
  yearNoPic.add(2006);
  yearNoPic.add(2007);
  yearNoPic.add(2009);
  yearNoPic.add(2010);
  yearNoPic.add(2013);
  yearNoPic.add(2014);
  
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
//}
void draw() {
  background(#EEEEDD);
   fill(0,0,0);
  textSize(48);
  text("Movies in Turmoil?!", 30,65);
  String info = "Explore around and see what has happened" +
  "\nin the movie world in the past 30 years." + 
  "\nThe radius represents genre's revenue." +
  "\nThe width of the arc represents the mount of movie made." +
  "\nFeel free to hover and get more information!";
  textSize(13);
  text(info, 30, 100);
  
  x = 0;
  slider.update();
  
  Year yearToDraw = years.get(slider.getYear()); //current year that the slider is one 

  if (!yearNoPic.contains(slider.getYear())){
    image(yearToDraw.placeImage(slider.getYear()),(slider.getValueX())-width/7,610,width/3.5, height/2.5);
  }
  genreColors = yearToDraw.getColors();
  
 //legend colors
  genreColors = yearToDraw.getColors();
  for (String key: genreColors.keySet()){
  fill(genreColors.get(key));
  rect(950,x+30,15,10);
  textSize(12);
  fill(0,0,0);
  text(key,975, x+40);
  x+=25;
  
  yearToDraw.update(moviesPerYear.get(yearToDraw.year));
  //String selectedGenre = mouseOnGenre();
  
  //if(mouseOnGenre) {
  //  yearToDraw.updateAsMute(moviesPerYear.get(yearToDraw.year), selectedGenre);
  //   textSize(20);
     
  //}
  
}
  String selectedGenre = mouseOnGenre();
  
  if(mouseOnGenre) {
    yearToDraw.updateAsMute(moviesPerYear.get(yearToDraw.year), selectedGenre);
     textSize(20);
     fill(#111111);
  }
  fill(#111111);
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