class Movie {
  String year;
  String title;
  String[] genres;
  Float gross;
  
  Movie(String year, String title, String[] genres, Float gross) {
    this.year = year;
    this.title = title;
    this.genres = genres;
    this.gross = gross;
  }
  
  boolean hasGenre(String genre) {
    for(int i = 0; i < genres.length; i++) {
      if(genres[i].equals(genre)){
        return true;
      }
    }
    return false;
  }
}