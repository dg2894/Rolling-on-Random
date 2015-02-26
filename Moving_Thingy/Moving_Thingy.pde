PImage background;
color b1, b2, b3, b4;

float time = 0.0;
float follow = 0;
float vary;

PImage submarine;
PImage scope;
float scopePos;
float bubbleSize;
float bubbleXPos;
float bubbleYPos;
color bubbleOpacity;

Fish fishy;
color fishColor;

float[] positionX = new float[5];
float[] positionY = new float[5];

void setup()
{
  size(800, 600, P2D);
  smooth();

  submarine = loadImage("submarine.png");
  scope = loadImage("periscope.png");

  b1 = color(112, 180, 188);
  b2 = color(37, 54, 57);

  fishy = new Fish();

  for (int i = 0; i < positionX.length; i++)
  {
    fishColor = color(random(255), random(255), random(255));
    positionX[i] = random(0, width);
    positionY[i] = random(20, height/2);
  }
}

void draw() {
  makeGradient(0, 0, width, 400, b1, b2);

  noFill();
  vary = time;

  makeMountains();

  makeFish();

  for (int i = 0; i < positionX.length; i++)
  {
    fishy.drawFish(positionX[i]+width, positionY[i], fishColor);
    fishy.moveFish();
  }

  makeGround();

  pushMatrix();
  translate(0, map(follow - 100, 0, height, follow - 20, follow - 200));
  image(scope, width/2 + 175, scopePos, 68, 171);
  popMatrix();

  image(submarine, width/2, follow+100, 300, 200);
  fill(0);
  ellipseMode(CENTER);
  fill(75, 75, 75, 40);
  ellipse(width/2 + 165, follow+350, 175, 50);

  makeBubbles();

  time += 0.004;
}

void makeGround()
{
  beginShape();
  for (int i = 0; i < width; i++) {
    float n = noise(vary); 
    float y = map(n, 0, 1, 0, height/2);
    if ( i == width/2 ) follow = y;
    vary += 0.001;
    stroke(color(193, 186, 166));
    vertex(i, y+200);
    vertex(i, height);
  }
  endShape();
}

void makeMountains()
{
  beginShape();
  strokeWeight(2);
  for (int i = 0; i < width; i++) {
    float n = noise(vary); 
    float y = map(n, 0, 1, 0, height/2);
    vary += 0.0099;
    stroke(color(41, 52, 62));
    vertex(i, y);
    vertex(i, y+400);
  }
  endShape();
}

void makeFish()
{
  if (frameCount%(width * 2) == 0)
  {
    fishy.x = 0;
    for (int i = 0; i < positionX.length; i++)
    {
      fishColor = color(random(255), random(255), random(255));
      positionX[i] = random(0, width);
      positionY[i] = random(20, height/2);
    }
  }
}

void makeBubbles()
{
  for (int i = 0; i < random (0, 10); i++)
  {
    bubbleSize = random(10, 80);
    bubbleXPos = random(0, width/2 - 30);
    bubbleYPos = random(follow + 150, follow + 250);
    fill(255, random(20, 80));
    ellipse(bubbleXPos, bubbleYPos, bubbleSize, bubbleSize);
  }
}

void makeGradient(int x, int y, float w, float h, color c1, color c2)
{
  for (int i = 0; i < h; i++) {
    float inter = map(i, 0, h, 0, 1);
    color c = lerpColor(b1, b2, inter);
    stroke(c);
    line(x, i, x+w, i);
  }
}

