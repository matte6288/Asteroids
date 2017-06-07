class Bullet extends Floater{
  public Bullet(Spaceship player){
    corners=4;
    xCorners=new int[corners];
    yCorners=new int[corners];
    xCorners[0]=-3;
    yCorners[0]=-1;
    xCorners[1]=-3;
    yCorners[1]=1;
    xCorners[2]=3;
    yCorners[2]=1;
    xCorners[3]=3;
    yCorners[3]=-1;
    //for (int i=0; i< xCorners.length; i++){
    //  xCorners[i]= (int)random(300,350);
    //  yCorners[i]= (int)random(300,350);
    //}
    myColor=255;

    myCenterX=player.getX();
    myCenterY=player.getY();
    myPointDirection= player.getPointDirection();
    myDirectionX=10*Math.cos(myPointDirection*(Math.PI/180));
    myDirectionY=10*Math.sin(myPointDirection*(Math.PI/180));
    
  }
  public void setX(int x){
    myCenterX=x;
  }
  public int getX(){
    return (int)myCenterX;
  }
  public void setY(int y){
    myCenterY=y;
  }
  public int getY(){
    return (int)myCenterY;
  }
  public void setDirectionX(double x){
    myDirectionX=x;
  }
  public double getDirectionX(){
    return myDirectionX;
  }
  public void setDirectionY(double y){
    myDirectionY=y;
  }
  public double getDirectionY(){
    return myDirectionY;
  }
  public void setPointDirection(int degrees){
    myPointDirection=degrees;
  }
  public double getPointDirection(){
    return myPointDirection; 
  }
  
  public boolean checkCollision(int x, int y){
    double distance = dist(x,y, getX(),getY());
    float collisonThreshhold = 4+16;
     return (collisonThreshhold>distance);
  }
  public void move(){
    myCenterX+= myDirectionX;
    myCenterY+= myDirectionY;
 }
}