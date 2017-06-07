class Star //note that this class does NOT extend Floater
{
  private int x;
  private int y;
  private int size;
  public Star(){
    x = (int)random(width);
    y = (int)random(height);
    size =(int)random(2,8);
  }
  public void show(){
    ellipse(x,y,size, size);
  }
}
