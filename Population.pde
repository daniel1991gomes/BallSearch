class Population{

  Dot[] dots;
  float fitnessSum;
  int gen = 1;
  int bestDot = 0;
  int minStep = 400;
  float bestDistance = 10000;
  int mostCheckpoints = 0;
  
  Population(int size) {
    dots = new Dot[size];
    for (int i=0; i < size; i++){
      dots[i] = new Dot();
    }
  }  
  
  //-----------------------------------
  
  void show(){
    for (int i=1; i < dots.length; i++){
      dots[i].show();    
    }
    dots[0].show();
  }
  
  //-----------------------------------
  
  void update(){
    for (int i=0; i < dots.length; i++){
      if(dots[i].brain.step > minStep) {
        dots[i].dead = true;
      }else{
        dots[i].update();
      }
    }
  }


  //-----------------------------------
  
void calculateFitness(){
    for (int i=0; i < dots.length; i++){
      dots[i].calculateFitness(); 
    }
}



//-----------------------------------
  
boolean allDotsDead(){
    for (int i=0; i < dots.length; i++){
      if(!dots[i].dead && !dots[i].reachedGoal){
        return false;
      }
    }
    return true;
}


//-----------------------------------

void naturalSelection(){
  Dot[] newDots = new Dot[dots.length];
  Dot[] newDotsCulled = new Dot[dots.length / 2];
  bubbleSort();
  setBestDot();
  //cull bottom half
  
  for (int i=0; i < dots.length; i++){
    if (i < dots.length / 2){
      newDotsCulled[i] = dots[i];
    }
  }
  calculateFitnessSum(newDotsCulled);
  
  newDots[0] = dots[0].giveBaby();

  newDots[0].isBest = true;
  
  for (int i=1; i < newDots.length; i++){
    //select parent
    Dot parent =  selectParent(newDotsCulled);
    //make babies
    newDots[i] = parent.giveBaby();
  }
  dots = newDots.clone();
  gen++;
  
}

//-----------------------------------

void calculateFitnessSum(Dot[] ds){
  fitnessSum = 0;
  for (int i=0; i < ds.length; i++){
    fitnessSum += ds[i].fitness;
    if(ds[i].bestDistance < bestDistance){
      bestDistance = ds[i].bestDistance;
    }
    if(ds[i].brain.countCheckpoints() > mostCheckpoints){
      mostCheckpoints = ds[i].brain.countCheckpoints();
    }
  }
}
//-----------------------------------


Dot selectParent(Dot[] ds){
  float rand = random(fitnessSum);
  float runningSum = 0;
  
  for (int i=0; i < ds.length; i++){
    runningSum += ds[i].fitness;
    if (runningSum > rand) {
      return ds[i];
    }
  }
  //shoudn't get here
  return null;

}

//-----------------------------------
void mutateBabies(){
  for (int i=1; i < dots.length; i++){
    dots[i].brain.mutate();
  
  }
}

void setBestDot(){
  float max = 0;
  int maxIndex = 0;
  for (int i =0; i < dots.length; i++){
    if (dots[i].fitness > max) {
      max = dots[i].fitness;
      maxIndex = i;
    }
  }
  bestDot = maxIndex;
  
  if(dots[bestDot].reachedGoal){
    minStep = dots[bestDot].brain.step;
  }
  
}

void bubbleSort(){
  int n= dots.length;
  int k;
  for (int m= n; m >=0; m--){
    for (int i= 0; i < n-1; i++){
      k = i+1;
      if(dots[i].fitness < dots[k].fitness){
        swapNumbers(i, k, dots);
      }
    }
  }    
}

void swapNumbers(int i, int k, Dot[] newDots){
  Dot temp;
  temp = newDots[i];
  newDots[i] = newDots[k];
  newDots[k] = temp;
}




}
