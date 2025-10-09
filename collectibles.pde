class Collectibles {
  PVector pos;
  String type;
  boolean collected = false;

  Collectibles(float x, float y, float z, String t) {
    pos = new PVector(x, y, z);
    type = t;
  }

  void display() {
    if (collected) return;

    float d = dist(mainCamera.cameraPosition.x, mainCamera.cameraPosition.z, pos.x, pos.z);


    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    if (d < 500) {
      if (type.equals("cube")) {
        fill(0, 255, 0);
        box(60);
      } else if (type.equals("sphere")) {
        fill(0, 255, 0);
        sphere(40);
      } else if (type.equals("cylinder")) {
        noStroke();
        fill(0, 255, 0);
        cylinder(30, 60);
      } else if (type.equals("cone")) {
        fill(0, 255, 0);
        cone(30, 80);
      } else if (type.equals("octahedron")) {
        fill(0, 255, 0);
        octahedron(50);
      }
    }
    popMatrix();
  }


  void checkCollected() {
    if (collected) return;
    float d = dist(mainCamera.cameraPosition.x, mainCamera.cameraPosition.z, pos.x, pos.z);
    if (d < 100) collected = true;
  }
}
