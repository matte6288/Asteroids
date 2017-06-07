Spaceship player;
Star[] stars = new Star[50];
ArrayList<Asteroid> asteroids = new ArrayList <Asteroid>();
ArrayList<Bullet> bullets = new ArrayList <Bullet>();
ArrayList<Integer> highScores= new ArrayList<Integer>();
int lives;
int score;
int gameMode; 
boolean pressingW = false;
boolean pressingA = false;
boolean pressingS = false;
boolean pressingD = false;
public void setup() 
{
  size(900, 900);
  player= new Spaceship();
  makeStars();
  for (int i=0; i<10; i++) {
    makeAsteroid();
  }
  lives=3;
  score=0;
  highScores.add(0);
}

public void draw() 
{
  if (gameMode == 0) {
    background(0, 0, 70);
    showStars();
    textSize(80);
    String s = "Asteroids";
    float tw= textWidth(s);
    text(s, width/2-tw/2, 300);
    textSize(40);
    String g= "Press X to start";
    float gw = textWidth(g);
    text(g, width/2-gw/2, 800);
    textSize(20);
    String instruction1="WASD to Move";
    String instruction2="Space to Shoot";
    String instruction3="Z for Hypespace";
    float inst1= textWidth(instruction1);
    float inst2= textWidth(instruction2);
    float inst3= textWidth(instruction3);
    text(instruction1, width/2-inst1/2, 600);
    text(instruction2, width/2-inst2/2, 650);
    text(instruction3, width/2-inst3/2, 700);
  } else if (gameMode==1) {
    background(0, 0, 70);
    showStars();
    showAsteroids();

    for (Asteroid i : asteroids) {
      i.move();
    }
    if (pressingW) { 
      player.accelerate(.05);
    }
    if (pressingA) { 
      player.turn(-10);
    }
    if (pressingD) { 
      player.turn(10);
    }
    if (pressingS) { 
      player.accelerate(-.05);
    }
    player.move();
    player.show();
    showBullets();
    textSize(20);
    text("lives:"+lives, 40, 40);
    text("score:"+score, 40, 80);
  } else if (gameMode==2) {
    background(0, 0, 70);
    showStars();
    textSize(80);
    String s = "Game Over!";
    float tw= textWidth(s);
    text(s, width/2-tw/2, 2500);
    textSize(40);
    String g= "Score "+ score;
    float gw = textWidth(g);
    text(g, width/2-gw/2, 350);
    String k= "Press X to play again!";
    float kw = textWidth(k);
    text(k, width/2-kw/2, 800);
    int i=asteroids.size()-1;
    String scoreopen="High Scores:";
    float sow=textWidth(scoreopen);
    text(scoreopen, width/2-sow/2, 500);
    textSize(30);
    if (highScores.size()>=2) {
      String score1="1: "+highScores.get(0);
      float s1w=textWidth(score1);
      text(score1, width/2-s1w/2, 550);
    }
    if (highScores.size()>=3) {
      String score2="2: "+highScores.get(1);
      float s2w=textWidth(score2);
      text(score2, width/2-s2w/2, 600);
    }
    if (highScores.size()>=4) {
      String score3="3: "+highScores.get(2);
      float s3w=textWidth(score3);
      text(score3, width/2-s3w/2, 650);
    }

    while (asteroids.size()>9) {
      asteroids.remove(i);
      i--;
    }
    int p=bullets.size()-1;
    while (bullets.size()>0) {
      bullets.remove(p);
      p--;
    }
    player.setX(width/2);
    player.setY(height/2);
  }
}

public void keyPressed() {
  if (key =='x'&& gameMode==0) {
    gameMode=1;
  }
  if (key == 'x' && gameMode==2) {
    gameMode=0;
    lives=3;
    score=0;
  }
  if (key == 'w')
  {
    pressingW = true;
  }
  if (key == 'a')
  {
    pressingA= true;
  }
  if (key == 's')
  {
    pressingS=true;
  }
  if (key == 'd') {
    pressingD=true;
  }
  if (key == 'z') {
    hyperspace();
  }
  if (key ==' ') {
    if (!pressingW && !pressingA && !pressingS && !pressingD)
      bullets.add(new Bullet(player));
  }
}
public void keyReleased() {
  if (key == 'w')
  {
    pressingW = false;
  }
  if (key == 'a')
  {
    pressingA = false;
  }
  if (key == 'd')
  {
    pressingD = false;
  }
  if (key == 's') {
    pressingS = false;
  }
}
public void hyperspace() {
  player.setX((int)random(width));
  player.setY((int)random(height));
  player.setDirectionX(0);
  player.setDirectionY(0);
  player.setPointDirection((int)random(360));
}
public void makeStars() {
  for (int i=0; i<stars.length; i++) {
    stars[i]= new Star();
  }
}
public void showStars() {
  for (int i=0; i<stars.length; i++) {
    stars[i].show();
  }
}
public void makeAsteroid() {
  asteroids.add(new Asteroid());
}

public void showAsteroids() {
  for (int i=0; i< asteroids.size(); i++) {
    asteroids.get(i).show();
    boolean collided = asteroids.get(i).checkCollision(player.getX(), player.getY());
    if (collided) {
      lives--;
      if (lives<=0) {
        gameMode=2;
        int highScoresSize=(highScores.size());
        if (highScoresSize>0) {
          for (int j=0; j<highScoresSize; j++) {
            if (score>highScores.get(j)) {
              highScores.add(j, score);
              break;
            }
          }
        } 
        else {
          highScores.add(score);
        }
      }
      hyperspace();
    }
  }
}
public void showBullets() {
  for (int i=bullets.size()-1; i>=0; i--) {
    bullets.get(i).show();
    bullets.get(i).move();
    int x = bullets.get(i).getX();
    int y = bullets.get(i).getY();
    if (x>width || x<0 || y>height || y<0) {
      bullets.remove(i);
      break;
    }
    for (int j = asteroids.size()-1; j>=0; j--) {
      boolean collided = bullets.get(i).checkCollision(asteroids.get(j).getX(), asteroids.get(j).getY());
      if (collided) {
        asteroids.remove(j);
        bullets.remove(i);
        score++;
        makeAsteroid();
        makeAsteroid();
        break;
      }
    }
  }
}
