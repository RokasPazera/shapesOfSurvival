
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

void cylinder(float r, float h){
  int sides = 24;
  float angle = TWO_PI / sides;
  beginShape(QUAD_STRIP);
  for(int i = 0; i <= sides; i++){
    float x = cos(angle * i) * r;
    float z = sin(angle * i) * r;
    vertex(x, -h/2, z);
  }
  
  endShape();
  
  beginShape(TRIANGLE_FAN);
  vertex(0, -h/2, 0);
  for(int i = 0; i <= sides; i++){
    float x = cos(angle * i) * r;
    float z = sin(angle * i) * r;
    vertex(x, -h/2, z);
  }
  
  endShape();
  
    beginShape(TRIANGLE_FAN);
  vertex(0, h/2, 0);
  for(int i = 0; i <= sides; i++){
    float x = cos(angle * i) * r;
    float z = sin(angle * i) * r;
    vertex(x, h/2, z);
  }
  
  endShape();
}

void cone(float r, float h){
  int sides = 24;
  float angle = TWO_PI / sides;
  
    beginShape(TRIANGLE_FAN);
  vertex(0, -h/2, 0);
  for(int i = 0; i <= sides; i++){
    float x = cos(angle * i) * r;
    float z = sin(angle * i) * r;
    vertex(x, -h/2, z);
  }
  endShape();
  
    beginShape(TRIANGLE_FAN);
  vertex(0, h/2, 0);
  for(int i = 0; i <= sides; i++){
    float x = cos(angle * i) * r;
    float z = sin(angle * i) * r;
    vertex(x, -h/2, z);
  }
  
  endShape();
  
}

void octahedron(float s){
  float h = s;
  PVector top = new PVector(0, h, 0);
  PVector bottom = new PVector(0, -h, 0);
  PVector[] base = {
  new PVector(-s, 0, 0),
  new PVector(0, 0, s),
  new PVector(s, 0, 0),
  new PVector(0, 0, -s)
};
beginShape(TRIANGLES);
for(int i = 0; i < 4; i++){
  PVector a = base[i];
  PVector b = base[(i+1)%4];
  vertex(top.x, top.y, top.z);
  vertex(a.x, a.y, a.z);
  vertex(b.x, b.y, b.z);
}

for(int i = 0; i < 4; i++){
  PVector a = base[i];
  PVector b = base[(i+1)%4];
  vertex(bottom.x, bottom.y, bottom.z);
  vertex(b.x, b.y, b.z);
  vertex(a.x, a.y, a.z);
  endShape();
}


}
