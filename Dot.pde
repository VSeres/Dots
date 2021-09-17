class Dot {
  PVector pos;
  PVector vel;
  PVector acc;

  Brain brain;
  boolean isBest = false;
  Boolean dead = false;
  boolean reachedGoal = false;
  float fitness = 0f;

  //set up dot
  Dot() {
    brain = new Brain(400);

    pos = new PVector(width/2, height-10);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }
  void show() {
    if (isBest) {
      fill(0, 255, 0);
      ellipse(pos.x, pos.y, 8, 8);
    } else {
      fill(0);
      ellipse(pos.x, pos.y, 4, 4);
    }
  }

  void move() {

    if (brain.dir.length > brain.step) {
      acc = brain.dir[brain.step];
      brain.step++;
    } else {
      dead=true;
    }
    vel.add(acc);
    vel.limit(5);
    pos.add(vel);
  }

  void update() {
    if (!dead && !reachedGoal) {
      move();
      if (pos.x<2 || pos.y<2 || pos.x>width-2 || pos.y>height-2) {
        dead = true;
      } else if (dist(pos.x, pos.y, goal.x, goal.y) < 5) {
        reachedGoal = true;
      } else if (pos.x > 75 && pos.y > 400 && pos.x < 725 && pos.y < 410) {
        // wall
        dead = true;
      } else if (pos.x > 200 && pos.y < 400 && pos.x < 210 && pos.y > 150) {
        dead = true;
      } else if (pos.x > 575 && pos.y < 400 && pos.x < 585 && pos.y > 150) {
        dead = true;
      }
    }
  }
  void calculateFitness() {
    fitness = 0;
    if (reachedGoal) {
      fitness = 1.0/16.0 + 1000/(float)(brain.step * brain.step);
    } else {
      float distanceToGoal = dist(pos.x, pos.y, goal.x, goal.y);
      //To a larger step in fitnes score
      fitness = 1.0/(distanceToGoal * distanceToGoal);
    }
  }


  Dot getBabyFromEbay() {
    Dot baby = new Dot();
    baby.brain = brain.clone();
    return baby;
  }
}
