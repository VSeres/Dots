class Brain {
  PVector[] dir;
  int step = 0;

  Brain(int size) {
    dir = new PVector[size];
    randomize();
  }


  //random direction
  void randomize() {
    for (int i = 0; i < dir.length; i++) {
      float randomAngle = random(2*PI);
      dir[i] = PVector.fromAngle(randomAngle);
    }
  }
  //clone a dot brain
  Brain clone() {
    Brain clone = new Brain(dir.length);
    for (int i =0; i < dir.length; i++) {
      clone.dir[i]= dir[i].copy();
    }
    return clone;
  }
  //mutate dots brain
  void mutate() {
    float rate = 0.1f;
    for (int i =0; i < dir.length; i++) {
      float rand = random(1);
      if (rand < rate) {
        float randomAngle = random(2*PI);
        dir[i] = PVector.fromAngle(randomAngle);
      }
    }
  }
}
