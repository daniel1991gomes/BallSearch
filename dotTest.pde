Population test;
PVector goal;
Obstacle[] obstacles = new Obstacle[4];
Checkpoint[] checkpoints = new Checkpoint[3];


void setup(){
  size(400,400);
  goal = new PVector(width / 2,10);
  float step1 = 0.2;
  float step2 = 0.4;
  float step3 = 0.6;
  float step4 = 0.8;
  float wToFill = 0.7;
  
  test = new Population(600);
  
  obstacles[0] = new Obstacle(0, width*wToFill, height*step1, height*step1+10);
  obstacles[1] = new Obstacle(width *(1-wToFill), width, height*step2, height*step2+10);
  obstacles[2] = new Obstacle(0, width*wToFill, height*step3,  height*step3+10);
  obstacles[3] = new Obstacle(width*(1-wToFill), width,  height*step4,  height*step4+10);
  
  checkpoints[0] = new Checkpoint(width*wToFill, width*wToFill+15, height*step1+12, height*step2-2, 0);
  checkpoints[1] = new Checkpoint(width*(1-wToFill), width*(1-wToFill)+15, height*step2+12, height*step3-2, 1);
  checkpoints[2] = new Checkpoint(width*wToFill, width*wToFill+15, height*step3+12, height*step4-2, 2);

  

}

void draw(){
  background(255);
  fill(255,0,0);
  ellipse(goal.x, goal.y, 10, 10);
  fill(50);
  text("gen: " + String.valueOf(test.gen), 10, 10, 70);
  text("dist: " + String.valueOf(test.bestDistance), 10, 25, 70);
  text("ckp: " + String.valueOf(test.mostCheckpoints), 10, 40, 70);
  
  for (Checkpoint cp: checkpoints) {
    fill (214, 215, 216);
    rect(cp.start_x, cp.start_y, cp.width1, cp.height1);
  
  }
  
   for (Obstacle ob: obstacles) {
    fill (122, 128, 137);
    rect(ob.start_x, ob.start_y, ob.width1, ob.height1);
  
  }
  
  if (test.allDotsDead()){
    //genetic algorithm
    test.calculateFitness(); //<>//
    test.naturalSelection(); //<>//
    test.mutateBabies();
    
    fill(0);
    noStroke();
    rect(0,0, width, 50);
    
    
    
  } else {
    test.update();
    test.show();
  
  
  }


}
