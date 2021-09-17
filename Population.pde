class Population {
  Dot[] dots;
  float fitnessSum;
  int gen = 1;
  int bestDot = 0;
  int minStep = 400;
  //pop size
  Population(int size) {
    dots = new Dot[size];
    for (int i =0; i < size; i++) {
      dots[i] = new Dot();
    }
  }

  void show() {
    for (int i = 1; i < dots.length; i++) {
      dots[i].show();
    }
    dots[0].show();
  }

  void update() {
    for (int i = 0; i < dots.length; i++) {
      if (dots[i].brain.step > minStep) {
        dots[i].dead = true;
      } else {
        dots[i].update();
      }
    }
  }

  void calculateFitness() {
    for (int i = 0; i < dots.length; i++) {
      dots[i].calculateFitness();
    }
  }


  boolean allDead() {
    for (int i = 0; i< dots.length; i++) {
      if (!dots[i].dead && !dots[i].reachedGoal) {
        return false;
      }
    }
    return true;
  }

  void naturalSelection() {
    Dot[] newDot = new Dot[dots.length];
    setBestDot();
    caluclateFitness();
    newDot[0] = dots[bestDot].getBabyFromEbay();
    newDot[0].isBest = true;
    for (int i = 1; i < newDot.length; i++) {
      Dot parent = selectParent();

      //get baby
      newDot[i] = parent.getBabyFromEbay();
    }
    dots = newDot.clone();
    gen++;
  }

  void caluclateFitness() {
    fitnessSum = 0;
    for (int i =0; i < dots.length; i++) {
      fitnessSum += dots[i].fitness;
    }
  }


  Dot selectParent() {
    float rand = random(fitnessSum);
    float runningSum = 0;
    for (int i =0; i < dots.length; i++) {
      runningSum += dots[i].fitness;
      if (runningSum > rand) {

        return dots[i];
      }
    }
    return null;
  }


  void mutateBaby() {
    for (int i =1; i < dots.length; i++) {
      dots[i].brain.mutate();
    }
  }


  void setBestDot() {
    float max = 0;
    int maxIndex = 0;
    for (int i =0; i < dots.length; i++) {
      if (dots[i].fitness > max) {
        max = dots[i].fitness;
        maxIndex = i;
      }
    }
    bestDot = maxIndex;
    println("Steps: ", dots[bestDot].brain.step);
    if (dots[bestDot].reachedGoal) {
      minStep = dots[bestDot].brain.step;
    }
  }
}
