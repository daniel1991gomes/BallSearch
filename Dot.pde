class Dot implements Comparable{
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;
  boolean dead = false;
  float fitness = 0;
  float bestDistance = 10000;
  boolean reachedGoal = false;
  boolean isBest = false;
  
  
Dot(){
  brain = new Brain(height + width * 4);
  
  pos = new PVector(width/2, height - 30);
  vel = new PVector(0,0);
  acc = new PVector(0,0);

}


//-----------------------------------------------------------------

void show() {
  if(isBest){
    fill(19, 165, 80);
    ellipse(pos.x, pos.y, 8, 8);
  } else {
    fill(0);
    ellipse(pos.x, pos.y, 4, 4);
  }
}


//-----------------------------------------------------------------

void move(){
   
   if(brain.directions.length > brain.step) {
     acc = brain.directions[brain.step];
     brain.step++;
   } else {
     dead = true;
   }
   
   vel.add(acc);
   vel.limit(5); 
   pos.add(vel);

}

//-----------------------------------------------------------------


void update(){
  if (!dead && !reachedGoal){
    move();
    for (Checkpoint cp: checkpoints){
      if (cp.pass(pos.x, pos.y)){
        brain.ckpoints[cp.checkpointNr] = 1;
      }
    }
    for (Obstacle ob: obstacles){
      if (ob.collide(pos.x, pos.y)){
        dead = true;
      }
    }
    if (pos.x < 2 || pos.y < 2 || pos.x > width - 2 || pos.y > height - 2){
      dead = true;
    } else if (dist(pos.x, pos.y, goal.x, goal.y) < 5) {
      //if reached goal
      reachedGoal = true;
    }
  }

}

//-----------------------------------------------------------------

void calculateFitness(){
  if (reachedGoal) {
    fitness = 1.0/5.0 + 100.0 / (float)(brain.step * brain.step);
  
  } else {
    float distanceToGoal = dist(pos.x, pos.y, goal.x, goal.y);
    bestDistance = distanceToGoal;
    fitness = brain.countCheckpoints() * 0.05 + 10.0 / (distanceToGoal * distanceToGoal);
  }
}

//-----------------------------------------------------------------
Dot giveBaby(){
  Dot baby = new Dot();
  baby.brain = brain.clone();
  return baby;
}

int compareTo(Object o){
  Dot d = (Dot)o;
  return int(fitness - d.fitness);
}

}
