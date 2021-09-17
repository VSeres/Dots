Population test;
PVector goal = new PVector(400, 10);

void setup() {

  size(800, 800);
  test = new Population(1000);
}

void draw() {
  background(255);
  fill(255, 0, 0);
  ellipse(goal.x, goal.y, 10, 10);

  fill(0, 255, 0);
  rect(75, 400, 650, 10);
  rect(200, 400, 10, -250);
  rect(575, 400, 10, -250);



  if (test.allDead()) {
    //generic algorithm
    test.calculateFitness();
    test.naturalSelection();
    test.mutateBaby();
  } else {
    test.update();
    test.show();
  }
}
