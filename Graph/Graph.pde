import de.bezier.guido.*;

TableReader tableReader;
ArrayList<Movie> movies;
HashMap<Integer, Year> years;
HashMap<Integer, Float> moviesPerYear;
HashMap<String, Integer> genreColors;
protected ArrayList<Integer> yearNoPic = new ArrayList<Integer>();
ArrayList<Genre> genres2;

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
  ArrayList<String> topTempMovies = new ArrayList<String>();
  
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
        topTempMovies.add(movie.title);
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
  String info = "Explore around and see what has" + "\nhappened in the movie world" + "\nin the past 30 years";
  textSize(20);
  text(info, 30, 100);
  
  x = 0;
  slider.update();
  
  Year yearToDraw = years.get(slider.getYear()); //current year that the slider is one 
  //System.out.println(yearToDraw);
  if (!yearNoPic.contains(slider.getYear())){
    image(yearToDraw.placeImage(slider.getYear()),(slider.getValueX())-width/7,610,width/3.5, height/2.5);
  }
  genreColors = yearToDraw.getColors();
  
  //for (Genre genre: genres2){
  //System.out.println(genre.name);
  //}
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
  //System.out.println(moviesPerYear.get(yearToDraw.year));
  genres2= yearToDraw.getGenres();
  //System.out.println(genres2);

  String selectedGenre = mouseOnGenre();
  //System.out.println(selectedGenre);
  //ndex= genres2.indexOf(selectedGenre);
  //System.out.println(index);
  if(mouseOnGenre) {
    yearToDraw.updateAsMute(moviesPerYear.get(yearToDraw.year), selectedGenre);
     textSize(20);
     //fill(#458B74);
     //textSize(24);
     //text(genres2.get(genres2.indexOf(label)).totalGross, mouseX, mouseY+20);
  }
  
  fill(0,0,0);
  textSize(48);
  text("Movies in Turmoil?!", 30,65);
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