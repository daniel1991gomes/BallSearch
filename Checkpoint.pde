class Checkpoint {
  
  float start_x;
  float end_x;
  float width1;
  float start_y;
  float end_y;
  float height1;
  int checkpointNr;
  
  Checkpoint(float sX, float eX, float sY, float eY, int nr){
    start_x = sX;
    end_x = eX;
    width1 = end_x - start_x;
    start_y = sY;
    end_y = eY;
    height1 = end_y - start_y;
    checkpointNr = nr;
  }
  
  boolean pass(float pos_x, float pos_y) {
    if (pos_x > start_x && pos_x < end_x && pos_y > start_y && pos_y < end_y){
      return true;
    }
    return false;
  }
  
  //  rect(100,300,600,10);

  
}
