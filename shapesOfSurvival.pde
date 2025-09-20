import com.jogamp.newt.opengl.GLWindow;

FPCamera mainCamera;
GLWindow r;
ArrayList<PVector> trees = new ArrayList<PVector>();

void setup() {
  fullScreen(P3D);
  mainCamera = new FPCamera();
  r = (GLWindow)surface.getNative();
  placeTrees();
}

void draw() {
  background(245, 242, 151);
  lights();
  mainCamera.canTransformations();

  r.confinePointer(true); //restrict pointer to the window
  r.setPointerVisible(false);
  r.warpPointer(width / 2, height / 2); //recenters cursor position

  renderEnvironment();
  renderTrees();
}

void renderEnvironment() {
  int grassSize = 50;

  fill(105, 88, 114);

  // Draw the elevated layer of boxes
  for (int z = 0; z < grassSize; z++) {
    for (int x = 0; x < grassSize; x++) {
      block(x * 50, height / 3 + 20, z * 50, 50);
    }
  }

  tree(500, height / 3, 500);
}

void placeTrees() {
  for (int i = 0; i < 20; i++) {
    float tx = int(random(0, 50)) * 50;
    float tz = int(random(0, 50)) * 50;
    trees.add(new PVector(tx, height / 3, tz));
  }
}

void renderTrees() {
  for (PVector t : trees) {
    tree(t.x, t.y, t.z);
  }
}

void keyPressed() {
  mainCamera.handleKeyPressed();
}

void keyReleased() {
  mainCamera.handleKeyReleased();
}
