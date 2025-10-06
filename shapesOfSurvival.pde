import com.jogamp.newt.opengl.GLWindow;
import ddf.minim.*;

FPCamera mainCamera;
GLWindow r;
PGraphics darkLayer;
PImage menuBackground;
PFont horrorFont;
PFont credits;
Minim minim;
AudioPlayer menuMusic;

boolean inMenu=true;
boolean inVolumeMenu = false;
String selectedOption="";

float volume = 0.5;
float sliderX, sliderWidth;

ArrayList<PVector> trees = new ArrayList<PVector>();
PShape gorvekModel;

ArrayList<Gorvek> gorveks = new ArrayList<Gorvek>();

void setup() {
  fullScreen(P3D);

  // MENU ASSETS
  menuBackground = loadImage("menu/menu.jpg");
  horrorFont = loadFont("horrorFont.vlw");
  credits = loadFont("credits.vlw");

  sliderWidth = width * 0.4;
  sliderX = width / 2 - sliderWidth / 2;

  // AUDIO
  minim = new Minim(this);
  menuMusic = minim.loadFile("menu/menuSound.mp3");
  menuMusic.loop();
  menuMusic.setGain(map(volume, 0, 1, -40, 0));

  // GAME
  darkLayer = createGraphics(width, height, P2D);
  darkLayer.smooth();
  mainCamera = new FPCamera();
  r = (GLWindow)surface.getNative();
  placeTrees();
  addGorveks();

  gorvekModel = loadShape("gorvek/gorvek.obj");
}

void draw() {
  if (inMenu) {
    if (inVolumeMenu) drawVolumeMenu();
    else drawMenu();
  } else drawGame();
}

// ------------------     MAIN MENU     ----------------------------
void drawMenu() {
  background(0);
  image(menuBackground, 0, 0, width, height);

  textAlign(CENTER, CENTER);
  textFont(horrorFont);
  textSize(70);
  fill(255);
  text("Shapes Of Survival", width/2, height/4);

  textSize(50);
  drawMenuOptions("Play", width / 2, height / 2 - 50, "play");
  drawMenuOptions("Volume", width / 2, height / 2 + 20, "volume");
  drawMenuOptions("Quit", width / 2, height /2 + 90, "quit");

  textAlign(RIGHT, BOTTOM);
  textFont(credits);
  textSize(25);
  fill(150, 0, 0);
  text("Song by AMIR BAYAT", width - 50, height - 30);
}

void drawMenuOptions(String label, float x, float y, String id) {
  if (selectedOption.equals(id)) fill(255, 0, 0);
  else fill(255);
  text(label, x, y);
}

// ------------------     VOLUME MENU     ----------------------------
void drawVolumeMenu() {
  background(0);
  image(menuBackground, 0, 0, width, height);
  textAlign(CENTER, CENTER);
  textFont(horrorFont);
  textSize(70);
  fill(255, 0, 0);
  text("Volume Settings", width / 2, height / 4);

  float sliderY = height / 2;
  stroke(150);
  strokeWeight(4);
  line(sliderX, sliderY, sliderX + sliderWidth, sliderY);

  float handleX = sliderX + volume * sliderWidth;
  noStroke();
  fill(255, 0, 0);
  ellipse(handleX, sliderY, 25, 25);

  textSize(40);
  fill(255);
  text(int(volume * 100) + "%", width / 2, sliderY + 60);

  textSize(35);
  fill(200);
  text("Press EXC to go back.", width / 2, height - 100);


  textAlign(RIGHT, BOTTOM);
  textFont(credits);
  textSize(25);
  fill(150, 0, 0);
  text("Song by AMIR BAYAT", width - 50, height - 30);

  menuMusic.setGain(map(volume, 0, 1, -40, 0));
}


// ------------------     GAME     ----------------------------
void drawGame() {
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


// ------------------     INTERACTION     ----------------------------
void mouseMoved() {
  if (inMenu) {
    if (abs(mouseY - (height / 2 - 50)) < 20) selectedOption = "play";
    else if (abs(mouseY - (height / 2 +20)) < 20) selectedOption = "volume";
    else if (abs(mouseY - (height / 2 + 90)) < 20) selectedOption = "quit";
    else selectedOption = "";
  }
}

void mousePressed() {
  if (inMenu && !inVolumeMenu) {
    if (selectedOption.equals("play")) {
      inMenu = false;
      menuMusic.pause();
    } else if (selectedOption.equals("volume")) inVolumeMenu = true;
    else if (selectedOption.equals("quit")) exit();
  } else if (inMenu && inVolumeMenu) {
    float sliderY = height / 2;
    if (abs(mouseY - sliderY) < 30 && mouseX > sliderX && mouseX < sliderX + sliderWidth) volume = constrain((mouseX - sliderX) / sliderWidth, 0, 1);
  }
}

void mouseDragged() {
  if (inMenu && inVolumeMenu) {
    float sliderY = height / 2;
    if (abs(mouseY - sliderY) < 30 && mouseX > sliderX && mouseX < sliderX + sliderWidth) {
      volume = constrain((mouseX - sliderX) / sliderWidth, 0, 1);
      menuMusic.setGain(map(volume, 0, 1, -40, 0));
    }
  }
}

void keyPressed() {
  if (inMenu && inVolumeMenu && key == ESC) {
    key = 0;
    inVolumeMenu = false;
  } else if (!inMenu) mainCamera.handleKeyPressed();
}

void keyReleased() {
  if (!inMenu) mainCamera.handleKeyReleased();
}


// ------------------     GAME OBJECTS     ----------------------------
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
  for (int i = 0; i < 2; i++) {
    float x = random(worldArea);
    float z = random(worldArea);
    gorveks.add(new Gorvek(x, height / 3, z));
  }
}

void updateGorveks() {
  for (Gorvek g : gorveks) {
    g.update();
    g.display();
  }
}
