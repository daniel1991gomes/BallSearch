class Brain{
  
  PVector[] directions;
  int step = 0;
  int[] ckpoints;

  Brain(int size) {
    directions = new PVector[size];
    randomize();
    ckpoints = new int[checkpoints.length];
    for (int i=0; i < ckpoints.length; i++){
      ckpoints[i] = 0;
    }


  }
  
int countCheckpoints(){
  int ck= 0;
  for (int i=0; i < ckpoints.length; i++){
      ck += ckpoints[i];
    }
   return ck;
}
  
void randomize(){
  for (int i=0; i < directions.length; i++){
    float randomAngle = random(2*PI);
    directions[i] = PVector.fromAngle(randomAngle);
  }
}

Brain clone(){
  Brain clone = new Brain(directions.length);
  for (int i=0; i < directions.length; i++){
    clone.directions[i] = directions[i].copy();
  }
  return clone;

}

void mutate(){
  float mutationRate = 0.01;
  for (int i=0; i < directions.length; i++){
    float rand = random(1);
    if (rand < mutationRate){
      //set this direction as new direction
      float randomAngle = random(2*PI);
      directions[i] = PVector.fromAngle(randomAngle);

    }
  
  }
  
  
}

  
  
}
