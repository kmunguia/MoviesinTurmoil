class TableReader {
  Table table;
  
  ArrayList<Movie> loadData(String filepath) {
    table = loadTable(filepath, "header");
  
    ArrayList<Movie> movies = new ArrayList<Movie>();
  
    for(int i = 0; i < table.getRowCount(); i++) {
      TableRow row = table.getRow(i);
      String year = row.getString("year");
      String title = row.getString("title");
      String[] genre = row.getString("genre").split(",");
      for(int j = 0; j < genre.length; j++){
        genre[j] = genre[j].trim();
      }
      float gross = row.getFloat("gross");
      Movie movie = new Movie(year, title, genre, gross);
      movies.add(movie);
    }
    
    return movies;
  }

}