class FPCamera {
  PVector cameraPosition;
  float yaw; //left right rotation
  float pitch; //up down rotation
  float sensitivity = 0.002;
  float speed = 7;
  boolean forward = false, right = false, left = false, back = false, shift = false;
  int grassSize = 50;
  float worldMinX = 0;
  float worldMaxX = grassSize * 50;
  float worldMinZ = 0;
  float worldMaxZ = grassSize * 50;

  FPCamera() {
    // Start camera near the center of the screen, slightly above ground
    cameraPosition = new PVector(width / 2, height / 2 - 300, (height / 2) / tan(PI * 30 / 180));
    pitch = 0;
    yaw = 0;
  }

  void canTransformations() {

    float dx = mouseX - width / 2;
    float dy = mouseY - height / 2;
    yaw -= -dx * sensitivity;
    pitch -= -dy * sensitivity;

    pitch = constrain(pitch, -PI/2, PI/2);


    mouseX = width / 2;
    mouseY = height / 2;

    float lookX = cameraPosition.x + cos(pitch)* cos(yaw) * 200;
    float lookZ = cameraPosition.z + sin(yaw) * cos(pitch) * 200;
    float lookY = cameraPosition.y +sin(pitch) * 200;


    // Set the camera view
    camera(cameraPosition.x, cameraPosition.y, cameraPosition.z, // Camera position
      lookX, lookY, lookZ, // Look-at point
      0, 1, 0);                   // Up vector (0,1,0 = world up)

    //calculate movement direction
    PVector nextPos = cameraPosition.copy();

    if (forward) {
      nextPos.x += cos(yaw) * speed;
      nextPos.z += sin(yaw) * speed;
    }
    if (right) {
      nextPos.x += cos(yaw+ HALF_PI) * speed;
      nextPos.z += sin(yaw + HALF_PI) * speed;
    }
    if (left) {
      nextPos.x -= cos(yaw+ HALF_PI) * speed;
      nextPos.z -= sin(yaw + HALF_PI) * speed;
    }
    if (back) {
      nextPos.x -= cos(yaw) * speed;
      nextPos.z -= sin(yaw) * speed;
    }
    if (shift) speed = 15;
    else speed = 7;

    if (nextPos.x < worldMinX || nextPos.x > worldMaxX || nextPos.z < worldMinZ || nextPos.z > worldMaxZ) return;

    boolean collision = false;
    for (PVector t : trees) {
      float distToTree = dist(nextPos.x, nextPos.z, t.x, t.z);
      if (distToTree < 100) {
        collision = true;
        break;
      }
    }

    if (!collision) {
      cameraPosition.set(nextPos);
    }
  }

  void handleKeyPressed() {
    if (key == 'w') forward = true;
    if (key == 'd') right = true;
    if (key == 'a') left = true;
    if (key == 's') back = true;
    if (keyCode == SHIFT) shift = true;
  }
  void handleKeyReleased() {
    if (key == 'w') forward = false;
    if (key == 'd') right = false;
    if (key == 'a') left = false;
    if (key == 's') back = false;
    if (keyCode == SHIFT) shift = false;
  }
}
