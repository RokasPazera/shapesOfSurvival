void tree(float x, float y, float z) {
 pushMatrix();
 translate(x, y, z);
 
 pushMatrix();
 fill(101, 67, 33);
 noStroke();
 translate(0, -50, 0);
 box(20, 800, 20);
 popMatrix();
 
 pushMatrix();
 fill(34, 139, 34);
 translate(0, -450, 0);
 sphere(100);
 popMatrix();
 
 popMatrix();
  
}

void block(float x, float y, float z, float s) {
  pushMatrix();
  translate(x, y, z);
  fill(34, 139, 34);
  box(s);
  popMatrix();
}

void ball(float x, float y, float z, float s) {
  pushMatrix();
  translate(x, y, z);
  sphere(s);
  popMatrix();
}
