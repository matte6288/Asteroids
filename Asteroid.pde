class Asteroid extends Floater {
  public Asteroid() {
    corners=9;
    xCorners=new int[corners];
    yCorners=new int[corners];
    float radius=20;
    float angle=TWO_PI/corners; 
    for (int i=0; i< xCorners.length; i++) {
      xCorners[i]= (int)((radius +random(-5,5)) * sin(angle*i));
      yCorners[i]=(int)((radius +random(-5,5)) * cos(angle*i));
    }
    myColor=255;
    if (random(1)<.5) {
      myCenterX= random(width);
      myCenterY=0;
    } else {
      myCenterX=0;
      myCenterY=random(height);
    }

    myDirectionX=(int)random(-3, 3);
    if (abs((float)myDirectionX)<.5) {
      myDirectionX=.5;
    }
    myDirectionY=(int)random(-3, 3);
    myPointDirection=0;
  }
  public void setX(int x) {
    myCenterX=x;
  }
  public int getX() {
    return (int)myCenterX;
  }
  public void setY(int y) {
    myCenterY=y;
  }
  public int getY() {
    return (int)myCenterY;
  }
  public void setDirectionX(double x) {
    myDirectionX=x;
  }
  public double getDirectionX() {
    return myDirectionX;
  }
  public void setDirectionY(double y) {
    myDirectionY=y;
  }
  public double getDirectionY() {
    return myDirectionY;
  }
  public void setPointDirection(int degrees) {
    myPointDirection=degrees;
  }
  public double getPointDirection() {
    return myPointDirection;
  }

  public boolean checkCollision(int x, int y) {
    double distance = dist(x, y, getX(), getY());
    float collisonThreshhold = 15+16;
    return (collisonThreshhold>distance);
  }
}