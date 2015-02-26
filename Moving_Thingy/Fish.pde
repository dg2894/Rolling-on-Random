class Fish {

  PShape fish, body, tail;
  float fishW = 50;
  float fishH = 30;
  float x;
  float y;

  Fish() {
    fish = createShape(GROUP);
    body = createShape(ELLIPSE, 0, 5, fishW, fishH);
    tail = createShape(TRIANGLE, fishW, fishH/2+5, fishW + 10, 5, fishW + 10, 35); 
    fish.addChild(body);
    fish.addChild(tail);
  }

  void drawFish(float x_, float y_, color c)
  {
    pushMatrix();
    translate(x+x_, y+y_);
    shape(fish);
    fish.setFill(c);
    popMatrix();
  }

  void moveFish()
  {
    x-= 0.3;
  }
}

