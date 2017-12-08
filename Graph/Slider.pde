public class Slider
{
    float x, y, width, height;
    float valueX = 0;
    float value; // change this one to type double if you need the extra precision
    
    Slider ( float xx, float yy, float ww, float hh ) 
    {
        x = xx; 
        y = yy; 
        width = ww; 
        height = hh;
        
        valueX = x;
    
        // register it
        Interactive.add( this );
    }
    
    // called from manager
    void mouseDragged ( float mx, float my, float dx, float dy )
    {
        valueX = mx - height/2;
        
        if ( valueX < x ) valueX = x;
        if ( valueX > x+width-height ) valueX = x+width-height;
        
        value = map( valueX, x, x+width-height, 0, 1 );
    }

    void update () 
    {
        noStroke();
        
        fill( 100 );
        rect(x, y, width, height);
        
        fill( 180);
        rect( valueX, y, height, height );
        
    }
    
    Integer getYear() {
      Integer year = round(map(valueX, x, x+width, 1986, 2017));
      textSize(18);
      fill(0,0,0);
      text(year, valueX-10, y-10);
      return year;
    }
}