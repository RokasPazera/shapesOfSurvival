float worldSize = 50;
float worldArea = worldSize * worldSize;

void tree(float x, float y, float z) {
  pushMatrix();
  translate(x, y, z);

  pushMatrix();
  fill(30, 20, 10);
  noStroke();
  translate(0, -50, 0);
  box(70, 800, 70);
  popMatrix();

  pushMatrix();
  fill(10, 50, 10);
  translate(0, -450, 0);
  sphere(150);
  popMatrix();

  popMatrix();
}

void grass(float x, float y, float z) {
  pushMatrix();
  translate(x, y, z);
  fill(34, 139, 34);
  box(50);
  popMatrix();
}

//void rock(float x, float y, float z) {
//}

void fence() {
  float fenceHeight = 500;
  float fenceThickness = 20;

  fill(60, 40, 20);
  stroke(0);

  //front row
  //X axis
  for (int x = 0; x <= worldArea; x +=100) {
    pushMatrix();
    translate(x, height/3 - 50, 0);
    box(100, fenceHeight, fenceThickness);
    pyramid(0, -fenceHeight/2 + 8, 0, 40, 40);
    popMatrix();

    //back row
    pushMatrix();
    translate(x, height/3 - 50, worldArea);
    box(100, fenceHeight, fenceThickness);
    pyramid(0, -fenceHeight/2 + 8, 0, 40, 40);
    popMatrix();
  }

  //Z axis
  for (int z = 0; z <= worldArea; z += 100) {
    pushMatrix();
    translate(0, height/3 - 50, z);
    box(fenceThickness, fenceHeight, 100);
    pyramid(0, -fenceHeight/2 + 8, 0, 40, 40);
    popMatrix();

    //back row
    pushMatrix();
    translate(worldArea, height/3 - 50, z);
    box(fenceThickness, fenceHeight, 100);
    pyramid(0, -fenceHeight/2 + 8, 0, 40, 40);
    popMatrix();
  }
}

void pyramid(float x, float y, float z, float baseSize, float height){
  pushMatrix();
  translate(x, y, z);
  fill(60, 40, 20);
  beginShape(TRIANGLES);
  
  float half = baseSize;
  
  PVector p1 = new PVector(-half, 0, -half);
  PVector p2 = new PVector(half, 0, -half);
  PVector p3 = new PVector(half, 0, half);
  PVector p4 = new PVector(-half, 0, half);
  PVector top = new PVector(0, -height, 0);
  
  vertex(p1.x, p1.y, p1.z); vertex(p2.x, p2.y, p2.z); vertex(top.x, top.y, top.z);
  vertex(p2.x, p2.y, p2.z); vertex(p3.x, p3.y, p3.z); vertex(top.x, top.y, top.z);
  vertex(p3.x, p3.y, p3.z); vertex(p4.x, p4.y, p4.z); vertex(top.x, top.y, top.z);
  vertex(p4.x, p4.y, p4.z); vertex(p1.x, p1.y, p1.z); vertex(top.x, top.y, top.z);
  
  endShape();
  popMatrix();
}
