class Gorvek {
  PVector pos;
  PVector target;
  float speed = 1.5;
  float wanderRadius = 500;
  float scale = 60;
  float groundY;

  Gorvek(float x, float y, float z) {
    pos = new PVector(x, y, z);
    groundY = y;
    pickNewTarget();
  }
  
  void pickNewTarget(){
    target = new PVector(
    pos.x + random(-wanderRadius, wanderRadius),
    groundY,
    pos.z + random(-wanderRadius, wanderRadius)
    );
  }

  void update() {
    PVector dir = PVector.sub(target, pos);
    if (dir.mag() < 10) {
      pickNewTarget();
      return;
    }
      dir.normalize();
      
      //predict next position
      PVector nextPos = PVector.add(pos, PVector.mult(dir, speed));
      
      boolean collision = false;
      
      for(PVector t: trees){
        float distToTree = dist(nextPos.x, nextPos.z, t.x, t.z);
        if(distToTree < 120){
          collision = true;
          break;
      }
      }
      
      if(nextPos.x < 0 || nextPos.x > worldArea || nextPos.z < 0 || nextPos.z > worldArea) collision = true;
      
      if(!collision)pos.set(nextPos);
      else pickNewTarget();
        
  }

  void display() {
    pushMatrix();
    translate(pos.x, groundY + 300, pos.z);
    float angle = atan2(target.x - pos.x, target.z - pos.z);
    rotateY(angle);  
    rotateZ(PI);
    
    fill(255);
    scale(scale);
    shape(gorvekModel);
    
    popMatrix();
  }
  
}
