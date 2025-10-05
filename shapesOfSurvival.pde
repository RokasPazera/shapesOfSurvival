import com.jogamp.newt.opengl.GLWindow;

FPCamera mainCamera;
GLWindow r;
PGraphics darkLayer;
ArrayList<PVector> trees = new ArrayList<PVector>();
PShape gorvekModel;

ArrayList<Gorvek> gorveks = new ArrayList<Gorvek>();

void setup() {
  fullScreen(P3D);
  darkLayer = createGraphics(width, height, P2D);
  darkLayer.smooth();
  mainCamera = new FPCamera();
  r = (GLWindow)surface.getNative();
  placeTrees();
  addGorveks();
  
  gorvekModel = loadShape("gorvek/gorvek.obj");
}

void draw() {
  background(255);
  lights();
  mainCamera.canTransformations();

  r.confinePointer(true); //restrict pointer to the window
  r.setPointerVisible(false);
  r.warpPointer(width / 2, height / 2); //recenters cursor position
  renderTrees();
  fence();
  //drawFlashlightHole();
  
  updateGorveks();
}

void placeTrees() {
  for (int i = 0; i < 20; i++) {
    float tx = int(random(0, worldSize)) * 50;
    float tz = int(random(0, worldSize)) * 50;
    trees.add(new PVector(tx, height / 3, tz));
  }
}

void renderTrees() {
  for (PVector t : trees) {
    tree(t.x, t.y, t.z);
  }
}

void drawFlashlightHole() {
  darkLayer.beginDraw();
  darkLayer.clear(); //make PGraphics transparent

  //fill whole screen with darkness
  darkLayer.noStroke();
  darkLayer.fill(0, 260);
  darkLayer.rect(0, 0, width, height);

  darkLayer.endDraw();

  camera();
  image(darkLayer, 0, 0);
}

void addGorveks() {
  for(int i = 0; i < 2; i++){
    float x = random(worldArea);
    float z = random(worldArea);
    gorveks.add(new Gorvek(x, height / 3, z));
  }
}

void updateGorveks() {
  for(Gorvek g: gorveks){
    g.update();
    g.display();
  }
}

void keyPressed() {
  mainCamera.handleKeyPressed();
}

void keyReleased() {
  mainCamera.handleKeyReleased();
}
