void tree(float x, float y, float z) {
 pushMatrix();
 translate(x, y, z);
 
 pushMatrix();
 fill(30, 20 ,10);
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

void grass(float x, float y, float z, float s) {
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
