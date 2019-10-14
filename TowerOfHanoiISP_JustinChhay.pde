//NAME: Justin Chhay
//DATE: 13.01.2019
//TEACHER: Mr. Rosen (ICS2O)
//DESCRIPTION: The ancient "Tower of Hanoi" puzzle game, recreated in Processing. (FINAL VERSION of ISP for ICS2O6)
//MAKE SURE YOU ADD THE MINIM LIBRARY, for music and effects - MR ROSEN

/*
 TRY AND CATCH Citation:
 Author: Rangi Lin
 Date Published: March 21, 2012
 Platform Found On: StackOverflow 
 Explanation:   Essentially, “Catch” checks whatever code 
 is inside “Try,” for the specified Error message. If it 
 detects that error, it will run whatever code is inside 
 “catch.” I used this to ensure that my program won't crash 
 when the user types in the wrong input, or clicks the cancel button. 
 
 MINIM Citation:
 Author: John Park
 Date Published: February 9, 2016
 Platform Found On: YouTube
 Explanation:   MINIM is a library that allows me use sound 
 in my program, just like the Sound library in Processing. 
 The code in the Sound library, to manipulate the sound 
 (stop, play, loop), is similar to the code used for MINIM.
 I have already learned how to use the code for Sound on the
 Processing References page, so I can just apply that same 
 knowledge to MINIM. I used this to introduce background music 
 to fit the theme of my puzzle game. I also used this, to 
 trigger certain sound effects, when certain actions were
 performed.
 */

//Imported Libraries
import ddf.minim.*;

//GLOBAL VARIABLES
//General Program Variables
String screen, userName;
int levelSelection; 
int movesTaken = 0;

//Cursor and Button Variables
float cursorX, cursorY, cursorRad;
float introButtonX, introButtonY, introRad;
float mMInstructionsButtonX, mMInstructionsButtonY, mMInstructionsRad;
float mMExitButtonX, mMExitButtonY, mMExitRad;
float mMLevelSelectButtonX, mMLevelSelectButtonY, mMLevelSelectRad;
float iSReturnButtonX, iSReturnButtonY, iSReturnRad;
float gBExitButtonX, gBExitButtonY, gBExitRad;
float lSReturnButtonX, lSReturnButtonY, lSReturnRad;
float lSChooseButtonX, lSChooseButtonY, lSChooseRad;
float dPReturnButtonX, dPReturnButtonY, dPReturnRad;
float eTButtonX, eTButtonY, eTRad;
float cGLevelSelectButtonX, cGLevelSelectButtonY, cGLevelSelectRad;
float cGMenuButtonX, cGMenuButtonY, cGMenuRad;

//Animation Variables
float moonStop = 95;
float moonStart = 445;
float pagodaX = 400;
float pagodaY = 700;
float pagodaSpdY = 1.8;
float textX = 400;
float textY = 380;
float textXReverse = 400;
float cGAnimationY1 = 500;
float cGAnimationY2 = 500;
float cGAnimationY3 = 500;
float cGAnimationY4 = 500;
float cGAnimationY5 = 500;
float lvlBgY = 400;
float lvlBgY2 = 600;
float lvlBgY3 = 800;
float lvlBgY4 = 1000;

//Game Mechanics Variables
int levelIndicatorX = 650;
float postX1 = 150;
float postX2 = 400;
float postX3 = 650;
float postY = 450;
float lv1B1X, lv1B1Y, lv1B2X, lv1B2Y, lv1B3X, lv1B3Y;
float lv2B1X, lv2B1Y, lv2B2X, lv2B2Y, lv2B3X, lv2B3Y, lv2B4X, lv2B4Y;
int clickCountA = 0; 
int clickCountB = 0;
int clickCountC = 0;
boolean blockSelectedA = false; 
boolean blockSelectedB = false;
boolean blockSelectedC = false;

//General Visual Variables
PFont title, general, subTitle, splash, level;
PImage background, splashPagoda;

//Sound Variables
Minim minim;
AudioPlayer splashScrn, mainMenu, game;
AudioPlayer advance, goBack, win, error, place, select;

void setup() {
  
  size(800,500);

  //Button Coordinates and Size
  introButtonX = 650;
  introButtonY = 350;
  introRad = 100;

  mMInstructionsButtonX = 170;
  mMInstructionsButtonY = 350;
  mMInstructionsRad = 110;
  mMLevelSelectButtonX = 420;
  mMLevelSelectButtonY = 350;
  mMLevelSelectRad = 95;
  mMExitButtonX = 640;
  mMExitButtonY = 350;
  mMExitRad = 80;

  iSReturnButtonX = 85;
  iSReturnButtonY = 75;
  iSReturnRad = 55;

  gBExitButtonX = 700;
  gBExitButtonY = 400;
  gBExitRad= 75;

  lSReturnButtonX = 85;
  lSReturnButtonY = 75;
  lSReturnRad = 55;
  lSChooseButtonX = 400;
  lSChooseButtonY = 225;
  lSChooseRad = 100;

  dPReturnButtonX = 85;
  dPReturnButtonY = 75;
  dPReturnRad = 55;

  eTButtonX = 400;
  eTButtonY = 350;
  eTRad = 100;

  cGLevelSelectButtonX = 460;
  cGLevelSelectButtonY = 380;
  cGLevelSelectRad = 85;

  cGMenuButtonX = 675;
  cGMenuButtonY = 380;
  cGMenuRad = 85;

  lv1B1X = 150;
  lv1B1Y = 425;
  lv1B2X = 150;
  lv1B2Y = 395;
  lv1B3X = 150;
  lv1B3Y = 365;

  lv2B1X = 150;
  lv2B1Y = 425;
  lv2B2X = 150;
  lv2B2Y = 395;
  lv2B3X = 150;
  lv2B3Y = 365;
  lv2B4X = 150;
  lv2B4Y = 335;

  //Cursor Size
  cursorRad = 10;

  //Fonts
  title = loadFont("SFMoviePoster-48.vlw");
  general = loadFont("Roboto-Thin-28.vlw");
  subTitle = loadFont("Roboto-Thin-38.vlw");
  splash = loadFont("CopperplateGothic-Bold-70.vlw");
  level = loadFont("Playbill-48.vlw");

  //Sound Music and Effects
  minim = new Minim(this);
  splashScrn = minim.loadFile("splash.mp3");
  mainMenu = minim.loadFile("menuMusic.wav");
  goBack = minim.loadFile("return.wav");
  advance = minim.loadFile("advance.wav");
  win = minim.loadFile("win.wav");
  game = minim.loadFile("game.mp3");
  error = minim.loadFile("error.mp3");
  place = minim.loadFile("place.mp3");
  select = minim.loadFile("select.mp3");

  //Images
  background = loadImage("background.png");
  splashPagoda = loadImage("pagoda.png");

  //Starts the program HERE
  splashScrn();
  splashScrn.play();
}

void myBackground() {
  background(255);
}

void title() {
  textFont(title);
  fill(0, 0, 0, 60);
  noStroke();
  rectMode(RADIUS);
  rect(0, 50, 800, 50);
  fill(0);
  textAlign(CENTER);
  text("Tower of Hanoi", 330, 70);
}

void splashScrn() {
  screen = "splashScreen";
  background(255, 219, 212);
  fill(216, 141, 130);
  arc(400, 150, 240, 240, radians(90), radians(moonStop), PIE);
  arc(400, 150, 240, 240, radians(moonStart), radians(450), PIE);
  rectMode(RADIUS);
  fill(255);
  stroke(0);
  image(splashPagoda, pagodaX - 115, pagodaY, 225, 275);
  fill(0);
  textAlign(CENTER);
  textFont(splash);
  textSize(32);
  text("TOWER OF HANOI\nThe legend, turned into a game.", 400, 380);
  text("Press SPACE BAR to CONTINUE.", 400, 450);
  fill(255, 219, 212);
  noStroke();
  quad(textX-100, textY+100, textX, textY+25, textX-100, textY-50, textX+450, textY+25);
  rect(textX+400, textY+25, 300, 75);
  quad(textXReverse+100, textY+100, textXReverse, textY+25, textXReverse+100, textY-50, textXReverse-450, textY+25);
  rect(textXReverse-400, textY+25, 300, 75);
}

void intro() {
  screen = "intro";
  title(); 
  fill(0, 0, 0, 100);
  rectMode(CORNERS);
  rect(0, 100, 500, 500);
  textFont(splash);
  textSize(28);
  textAlign(CENTER);
  fill(255);
  text("Let's visit", 250, 150);
  text("the Tower of Hanoi!", 250, 185);
  textSize(24);
  text("Take a crack at this ancient", 250, 230);
  text("puzzle and play a game inspired", 250, 265);
  text("by a Vietnamese legend, about", 250, 300);
  text("a few monks and a temple.", 250, 335);
  text("For enhanced gaming experience,", 250, 405);
  text("turn up your VOLUME.", 250, 440);

  //Continue Btn
  fill(0, 0, 0, 180);
  ellipseMode(RADIUS);
  ellipse(introButtonX, introButtonY, introRad, introRad);
  textAlign(CENTER);
  fill(255);
  textSize(30);
  textFont(general);
  text("CONTINUE", introButtonX, introButtonY+10);

  //Cursor
  noFill();
  strokeWeight(5);
  stroke(0, 0, 0, 180);
  ellipse(cursorX, cursorY, cursorRad, cursorRad);
}

void mainMenu() {
  screen = "mainMenu";
  title();
  textFont(subTitle);
  text("MAIN MENU", 620, 70);
  rectMode(CORNERS);
  fill(80, 80, 80, 120);
  rect(0, 0, 175, 100);
  textFont(general);
  textAlign(LEFT);
  fill(255);
  text("Welcome,\n"+userName+"!", 20, 45);

  //Instructions Btn
  textFont(general);
  fill(0, 0, 0, 200);
  ellipse(mMInstructionsButtonX, mMInstructionsButtonY, mMInstructionsRad, mMInstructionsRad);
  textAlign(CENTER);
  fill(255);
  text("GAME\nINSTRUCTIONS", mMInstructionsButtonX, mMInstructionsButtonY-10);

  //Level Select Btn
  fill(0, 0, 0, 200);
  ellipse(mMLevelSelectButtonX, mMLevelSelectButtonY, mMLevelSelectRad, mMLevelSelectRad);
  fill(255);
  text("LEVEL\nSELECTION", mMLevelSelectButtonX, mMLevelSelectButtonY-10);

  //Exit Btn
  fill(0, 0, 0, 200);
  ellipse(mMExitButtonX, mMExitButtonY, mMExitRad, mMExitRad);
  fill(255);
  text("EXIT", mMExitButtonX, mMExitButtonY+15);

  //Cursor
  noFill();
  strokeWeight(5);
  stroke(0, 0, 0, 180);
  ellipse(cursorX, cursorY, cursorRad, cursorRad);
}

void levelSelection() {
  screen = "levelSelection";
  title();
  textFont(subTitle);
  text("LEVEL SELECTION", 620, 70);
  rectMode(CORNERS);
  textFont(general);
  fill(0);
  rect(150, 350, 650, 400);
  fill(255);
  text("There are two levels.", 400, 383);

  //Choose Level Btn
  fill(0, 0, 0, 180);
  ellipse(lSChooseButtonX, lSChooseButtonY, lSChooseRad, lSChooseRad);
  textAlign(CENTER);
  fill(255);
  text("CHOOSE\nLEVEL", lSChooseButtonX, lSChooseButtonY);

  //Return Btn
  fill(0);
  ellipse(lSReturnButtonX, lSReturnButtonY, lSReturnRad, lSReturnRad);
  fill(255);
  text("GO\nBACK", lSReturnButtonX, lSReturnButtonY-10);

  //Cursor
  noFill();
  strokeWeight(5);
  stroke(0, 0, 0, 180);
  ellipse(cursorX, cursorY, cursorRad, cursorRad);
}

void display() {
  if (levelSelection == 1) {
    screen = "levelOne";

    //Animated Background
    rectMode(CORNERS);
    fill(210);
    rect(0, lvlBgY, 800, lvlBgY+100);
    rect(0, lvlBgY2, 800, lvlBgY2+50);
    rect(0, lvlBgY3, 800, lvlBgY3+90);
    rect(0, lvlBgY4, 800, lvlBgY4+75);

    //Top Bar (Game Info)
    rectMode(RADIUS);
    fill(203, 163, 109);
    noStroke();
    rect(postX1, postY, 100, 10 );
    rect(postX2, postY, 100, 10 );
    rect(postX3, postY, 100, 10 );
    rect(postX1, postY-100, 10, 110 );
    rect(postX2, postY-100, 10, 110 );
    rect(postX3, postY-100, 10, 110 );
    fill(50);
    rect(500, 0, 300, 140);
    textFont(title);
    fill(255);
    textSize(40);
    text("MINIMUM MOVES:  7", 350, 100);
    quad(495, 120, 515, 53, 520, 53, 500, 120);
    text("MOVES TAKEN:  "+movesTaken, 645, 100);
    fill(0);
    textFont(general);
    textSize(15);
    text("Click on a post to select, then click on another post to place disk. Or click on the same post to de-select.", 400, 485);
    textFont(level);
    textSize(30);
    fill(255);
    text("LEVEL ONE", levelIndicatorX, 40);
    textSize(26);
    text("RESET by re-entering level.", 320, 40);

    //Game Pieces
    fill(75, 162, 0);
    rect(lv1B1X, lv1B1Y, 70, 15);
    fill(116, 211, 77);
    rect(lv1B2X, lv1B2Y, 40, 15);
    fill(165, 222, 141);
    rect(lv1B3X, lv1B3Y, 25, 15);

    //Return Btn
    textFont(general);
    fill(0);
    stroke(0);
    ellipse(dPReturnButtonX, dPReturnButtonY, dPReturnRad, dPReturnRad);
    textAlign(CENTER);
    fill(255);
    text("GO\nBACK", dPReturnButtonX, dPReturnButtonY-10);

    //Cursor
    noFill();
    strokeWeight(5);
    stroke(0, 0, 0, 180);
    ellipse(cursorX, cursorY, cursorRad, cursorRad);
  } else if (levelSelection == 2) {
    screen = "levelTwo";

    //Animated Background
    rectMode(CORNERS);
    fill(210);
    rect(0, lvlBgY, 800, lvlBgY+100);
    rect(0, lvlBgY2, 800, lvlBgY2+50);
    rect(0, lvlBgY3, 800, lvlBgY3+90);
    rect(0, lvlBgY4, 800, lvlBgY4+75);

    //Top Bar (Game Info)
    rectMode(RADIUS);
    fill(203, 163, 109);
    noStroke();
    rect(postX1, postY, 100, 10 );
    rect(postX2, postY, 100, 10 );
    rect(postX3, postY, 100, 10 );
    rect(postX1, postY-100, 10, 110 );
    rect(postX2, postY-100, 10, 110 );
    rect(postX3, postY-100, 10, 110 );
    fill(50);
    rect(500, 0, 300, 140);
    textFont(title);
    fill(255);
    textSize(40);
    text("MINIMUM MOVES:  15", 350, 100);
    quad(495, 120, 515, 53, 520, 53, 500, 120);
    text("MOVES TAKEN:  "+movesTaken, 645, 100);
    fill(0);
    textFont(general);
    textSize(15);
    text("Click on a post to select, then click on another post to place disk. Or click on the same post to de-select.", 400, 485);
    fill(255);
    textFont(level);
    textSize(30);
    text("LEVEL TWO", levelIndicatorX, 40);
    textSize(26);
    text("RESET by re-entering level.", 310, 40);

    //Game Pieces
    fill(0, 96, 153);
    rect(lv2B1X, lv2B1Y, 90, 15);
    fill(0, 112, 204);
    rect(lv2B2X, lv2B2Y, 70, 15);
    fill(0, 138, 255);
    rect(lv2B3X, lv2B3Y, 50, 15);
    fill(0, 171, 252);
    rect(lv2B4X, lv2B4Y, 25, 15);

    //Return Btn
    textFont(general);
    fill(0);
    ellipse(dPReturnButtonX, dPReturnButtonY, dPReturnRad, dPReturnRad);
    textAlign(CENTER);
    fill(255);
    text("GO\nBACK", dPReturnButtonX, dPReturnButtonY-10);

    //Cursor
    noFill();
    strokeWeight(5);
    stroke(0, 0, 0, 180);
    ellipse(cursorX, cursorY, cursorRad, cursorRad);
  }
}

void congrats() {
  screen = "congrats";
  fill(0, 0, 0, 60);
  noStroke();
  rectMode(RADIUS);
  rect(0, 50, 800, 50);
  textFont(title);
  fill(0);
  textAlign(CENTER);
  text("Tower of Hanoi", 230, 70);
  textFont(subTitle);
  textSize(32);
  text("CONGRATULATIONS", 520, 70);
  textFont(general);
  text("It took you "+movesTaken+" moves.", 570, 180);
  text("Congratulations "+userName+"!", 570, 215);

  //Congrats Animation
  stroke(0);
  strokeWeight(2);
  fill(255, 0, 0, 100);
  quad(50, 500, 70, cGAnimationY5, 260, cGAnimationY5, 280, 500);
  fill(245, 0, 0, 100);
  quad(65, 500, 85, cGAnimationY4, 245, cGAnimationY4, 265, 500);
  fill(235, 0, 0, 100);
  quad(80, 500, 100, cGAnimationY3, 230, cGAnimationY3, 250, 500);
  fill(225, 0, 0, 100);
  quad(95, 500, 115, cGAnimationY2, 215, cGAnimationY2, 235, 500);
  fill(215, 0, 0, 100);
  quad(110, 500, 130, cGAnimationY1, 200, cGAnimationY1, 220, 500);
  noStroke();

  //Reset variables
  lv1B1X = 150;
  lv1B1Y = 425;
  lv1B2X = 150;
  lv1B2Y = 395;
  lv1B3X = 150;
  lv1B3Y = 365;
  lv2B1X = 150;
  lv2B1Y = 425;
  lv2B2X = 150;
  lv2B2Y = 395;
  lv2B3X = 150;
  lv2B3Y = 365;
  lv2B4X = 150;
  lv2B4Y = 335;
  clickCountA = 0;
  clickCountB = 0;
  clickCountC = 0;
  blockSelectedA = false;
  blockSelectedB = false;
  blockSelectedC = false;

  //Level Selection Btn
  textFont(general);
  fill(0, 0, 0, 180);
  ellipse(cGLevelSelectButtonX, cGLevelSelectButtonY, cGLevelSelectRad, cGLevelSelectRad);
  textAlign(CENTER);
  fill(255);
  text("LEVEL\nSELECTION", cGLevelSelectButtonX, cGLevelSelectButtonY-10);

  //Main Menu Btn
  fill(0, 0, 0, 180);
  ellipse(cGMenuButtonX, cGMenuButtonY, cGMenuRad, cGMenuRad );
  fill(255);
  text("MAIN\nMENU", cGMenuButtonX, cGMenuButtonY);

  //Cursor
  noFill();
  strokeWeight(5);
  stroke(0, 0, 0, 180);
  ellipse(cursorX, cursorY, cursorRad, cursorRad);
}

void instructions() {
  screen = "instructions";
  title();
  textFont(subTitle);
  text("INSTRUCTIONS", 620, 70);
  textFont(title);
  textAlign(LEFT);
  rectMode(CORNERS);
  fill(0, 0, 0, 170);
  rect(0, 145, 800, 470);
  fill(255);
  textSize(36);
  text("OBJECTIVE:", 30, 195);
  text("RULES:", 430, 195);
  noStroke();
  rect(403, 172, 407, 440);

  //Objective Text
  textSize(32);
  text("   Transfer all the disks from", 40, 240);
  text("the first post to the third post,", 40, 272);
  text("in order from the smallest disk", 40, 304);
  text("on top, to biggest on the bottom.", 40, 336);
  text("There are 3 posts in total, and", 40, 368);
  text("depending on the level, there", 40, 400);
  text("will be more or less disks.", 40, 432);

  //Rules Text
  text("1) You can only move ONE disk", 450, 240);
  text("   at a time.", 450, 270);
  text("2) You cannot place a larger", 450, 310);
  text("   disk over a smaller disk.", 450, 340);
  text("3) All disks must be on a", 450, 380);
  text("   post, except for the one", 450, 410);
  text("   being moved.", 450, 440);

  //Return Btn
  textFont(general);
  fill(0);
  stroke(0);
  ellipse(iSReturnButtonX, iSReturnButtonY, iSReturnRad, iSReturnRad);
  textAlign(CENTER);
  fill(255);
  text("GO\nBACK", iSReturnButtonX, iSReturnButtonY-10);

  //Cursor
  noFill();
  strokeWeight(5);
  stroke(0, 0, 0, 180);
  ellipse(cursorX, cursorY, cursorRad, cursorRad);
}

void goodBye() {
  screen = "goodBye";
  title();
  rectMode(CORNERS);
  fill(80, 80, 80, 120);
  rect(0, 0, 100, 500);
  fill(0);
  textFont(subTitle);
  text("Good Bye", 620, 70);
  textFont(general);
  text("Thanks for playing, "+userName+"!", 350, 150); 
  text("Programmed by: Justin Chhay", 350, 460);
  textSize(21);
  text("Tower of Hanoi is an ancient puzzle", 350, 190);
  text("game, that actually comes from a", 350, 215);
  text("variation of a legend. According to", 350, 240);
  text("the Vietnamese variation of the legend,", 350, 265);
  text("there exists a temple that holds a room  ", 350, 290);
  text("with three worn-out posts, with 64 golden ", 350, 315);
  text("disks laying next to them. And to this day,", 350, 340);
  text("Vietnamese monks are rumoured to be solving", 350, 365);
  text("this puzzle. Once the last move of ", 350, 390);
  text("the puzzle is finished, the WORLD will end...", 350, 415);

  //FINAL Exit Btn
  textFont(title);
  fill(216, 109, 109, 180);
  ellipse(gBExitButtonX, gBExitButtonY, gBExitRad, gBExitRad);
  textAlign(CENTER);
  fill(255);
  text("FINAL", gBExitButtonX, gBExitButtonY);
  text("EXIT", gBExitButtonX, gBExitButtonY+50);

  //Cursor
  noFill();
  strokeWeight(5);
  stroke(0, 0, 0, 180);
  ellipse(cursorX, cursorY, cursorRad, cursorRad);
}

void eTIntro() {
  screen = "eTIntro";
  title();
  textFont(subTitle);
  text("ERROR", 620, 70);
  textFont(general);
  text("Please enter a username\nthat is 10 characters or less.", 400, 175);

  //Return Btn
  fill(0);
  stroke(0);
  ellipse(eTButtonX, eTButtonY, eTRad, eTRad);
  textAlign(CENTER);
  fill(255);
  text("GO BACK", eTButtonX, eTButtonY);

  //Cursor
  noFill();
  strokeWeight(5);
  stroke(0, 0, 0, 180);
  ellipse(cursorX, cursorY, cursorRad, cursorRad);
}

void eTLevelSelection() {
  screen = "eTLevelSelection";
  title();
  textFont(subTitle);
  text("ERROR", 620, 70);
  textFont(general);
  text("Please enter 1 or 2 to\nproceed to the chosen level.", 400, 175);

  //Return Btn
  fill(0);
  stroke(0);
  ellipse(eTButtonX, eTButtonY, eTRad, eTRad);
  textAlign(CENTER);
  fill(255);
  text("GO BACK", eTButtonX, eTButtonY);

  //Cursor
  noFill();
  strokeWeight(5);
  stroke(0, 0, 0, 180);
  ellipse(cursorX, cursorY, cursorRad, cursorRad);
}

void draw() {
  myBackground();
  if (keyPressed == true) {
    if (key==' ') {
      if (screen == "splashScreen") {
        intro();
       advance.play(1);
      }
    }
  } 
  if (screen == "splashScreen") { 
    //If statement animates orange moon
    if (moonStop < 270 ) {
      moonStop += 1.5;
    }    
    if (moonStart > 270) {
      moonStart -= 1.5;
    }

    //If statement animates appearing text
    if (textX < 775) {
      textX++;
    }
    if (textXReverse > 25) {
      textXReverse--;
    }

    //If statement animates pagoda
    if (pagodaY > 50) {
      pagodaY -= pagodaSpdY;
    }
    splashScrn();
  } else if (screen == "intro") {
   splashScrn.pause();
    intro();
  } else if (screen == "mainMenu") {
    image(background, 75, 125, 650, 400);
    mainMenu();
  } else if (screen == "instructions") {
    image(background, 75, 125, 650, 400);
    instructions();
  } else if (screen == "levelSelection") {
    image(background, 75, 125, 650, 400);
    levelSelection();
  } else if (screen == "levelOne") {

    //Animation
    background(230);

    //If statement animates moving level indicator
    if (levelIndicatorX <= 775 && levelIndicatorX >= 445) {
      levelIndicatorX -= 0.5;
    } else if (levelIndicatorX <= 445) {
      levelIndicatorX = 775;
    }

    //If statement animates moving level background
    if (lvlBgY > -100) {
      lvlBgY--;
    } else {
      lvlBgY = 500;
    }
    if (lvlBgY2 > - 100) {
      lvlBgY2--;
    } else {
      lvlBgY2 = 500;
    }
    if (lvlBgY3 > - 100) {
      lvlBgY3--;
    } else {
      lvlBgY3 = 500;
    }
    if (lvlBgY4 > - 100) {
      lvlBgY4--;
    } else {
      lvlBgY4 = 500;
    }

    //Game Mechanic LevelOne Block Y-COORDINATES (formats order of blocks depending on amount and quantity)
    //If POST #1 has 3 DISKS
    if (lv1B1X == 150 && lv1B2X == 150 && lv1B3X == 150) {
      if (lv1B3Y == 175) { 
        lv1B2Y = 395;
        lv1B1Y = 425;
      } else if (lv1B3Y != 175) {
        lv1B1Y = 425;
        lv1B2Y = 395;
        lv1B3Y = 365;
      }
    }
    //If POST #1 has 2 DISKS
    else if (lv1B1X == 150 && lv1B2X == 150 && lv1B3X != 150 ) {
      if (lv1B2Y == 175 ) {
        lv1B1Y = 425;
      } else if (lv1B2Y != 175 ) {
        lv1B1Y = 425;
        lv1B2Y = 395;
      }
    } else if (lv1B1X == 150 && lv1B2X != 150 && lv1B3X == 150) {
      if (lv1B3Y == 175) {
        lv1B1Y = 425;
      } else if (lv1B3Y != 175) {
        lv1B1Y = 425;
        lv1B3Y = 395;
      }
    } else if (lv1B1X != 150 && lv1B2X == 150 && lv1B3X == 150) {
      if (lv1B3Y == 175) {
        lv1B2Y = 425;
      } else if ( lv1B3Y != 175) {
        lv1B2Y = 425;
        lv1B3Y = 395;
      }
    }
    //If POST #1 has 1 DISK
    else if (lv1B1X == 150 && lv1B2X != 150 && lv1B3X != 150 ) {
      if (lv1B1Y == 175 ) {
      } else if (lv1B1Y != 175 ) {
        lv1B1Y = 425;
      }
    } else if (lv1B1X != 150 && lv1B2X == 150 && lv1B3X != 150) {
      if (lv1B2Y == 175) {
      } else if (lv1B2Y != 175) {
        lv1B2Y = 425;
      }
    } else if (lv1B1X != 150 && lv1B2X != 150 && lv1B3X == 150) {
      if (lv1B3Y == 175) {
      } else if ( lv1B3Y != 175) {
        lv1B3Y = 425;
      }
    }
    //If POST #2 has 3 DISKS
    if (lv1B1X == 400 && lv1B2X == 400 && lv1B3X == 400) {
      if (lv1B3Y == 175) { 
        lv1B2Y = 395;
        lv1B1Y = 425;
      } else if (lv1B3Y != 175) {
        lv1B1Y = 425;
        lv1B2Y = 395;
        lv1B3Y = 365;
      }
    }
    //If POST #2 has 2 DISKS
    else if (lv1B1X == 400 && lv1B2X == 400 && lv1B3X != 400 ) {
      if (lv1B2Y == 175 ) {
        lv1B1Y = 425;
      } else if (lv1B2Y != 175 ) {
        lv1B1Y = 425;
        lv1B2Y = 395;
      }
    } else if (lv1B1X == 400 && lv1B2X != 400 && lv1B3X == 400) {
      if (lv1B3Y == 175) {
        lv1B1Y = 425;
      } else if (lv1B3Y != 175) {
        lv1B1Y = 425;
        lv1B3Y = 395;
      }
    } else if (lv1B1X != 400 && lv1B2X == 400 && lv1B3X == 400) {
      if (lv1B3Y == 175) {
        lv1B2Y = 425;
      } else if ( lv1B3Y != 175) {
        lv1B2Y = 425;
        lv1B3Y = 395;
      }
    }
    //If POST #2 has 1 DISK
    else if (lv1B1X == 400 && lv1B2X != 400 && lv1B3X != 400 ) {
      if (lv1B1Y == 175 ) {
      } else if (lv1B1Y != 175 ) {
        lv1B1Y = 425;
      }
    } else if (lv1B1X != 400 && lv1B2X == 400 && lv1B3X != 400) {
      if (lv1B2Y == 175) {
      } else if (lv1B2Y != 175) {
        lv1B2Y = 425;
      }
    } else if (lv1B1X != 400 && lv1B2X != 400 && lv1B3X == 400) {
      if (lv1B3Y == 175) {
      } else if ( lv1B3Y != 175) {
        lv1B3Y = 425;
      }
    }
    //If POST #3 has 3 DISKS
    if (lv1B1X == 650 && lv1B2X == 650 && lv1B3X == 650) {
      if (lv1B3Y == 175) { 
        lv1B2Y = 395;
        lv1B1Y = 425;
      } else if (lv1B3Y != 175) {
        lv1B1Y = 425;
        lv1B2Y = 395;
        lv1B3Y = 365;
      }
    }
    //If POST #3 has 2 DISKS
    else if (lv1B1X == 650 && lv1B2X == 650 && lv1B3X != 650 ) {
      if (lv1B2Y == 175 ) {
        lv1B1Y = 425;
      } else if (lv1B2Y != 175 ) {
        lv1B1Y = 425;
        lv1B2Y = 395;
      }
    } else if (lv1B1X == 650 && lv1B2X != 650 && lv1B3X == 650) {
      if (lv1B3Y == 175) {
        lv1B1Y = 425;
      } else if (lv1B3Y != 175) {
        lv1B1Y = 425;
        lv1B3Y = 395;
      }
    } else if (lv1B1X != 650 && lv1B2X == 650 && lv1B3X == 650) {
      if (lv1B3Y == 175) {
        lv1B2Y = 425;
      } else if ( lv1B3Y != 175) {
        lv1B2Y = 425;
        lv1B3Y = 395;
      }
    }
    //If POST #3 has 1 DISK
    else if (lv1B1X == 650 && lv1B2X != 650 && lv1B3X != 650 ) {
      if (lv1B1Y == 175 ) {
      } else if (lv1B1Y != 175 ) {
        lv1B1Y = 425;
      }
    } else if (lv1B1X != 650 && lv1B2X == 650 && lv1B3X != 650) {
      if (lv1B2Y == 175) {
      } else if (lv1B2Y != 175) {
        lv1B2Y = 425;
      }
    } else if (lv1B1X != 650 && lv1B2X != 650 && lv1B3X == 650) {
      if (lv1B3Y == 175) {
      } else if ( lv1B3Y != 175) {
        lv1B3Y = 425;
      }
    }
    display();
    noStroke();
    fill(50);
    rectMode(RADIUS);
    rect(450, 15, 50, 40);
    rect(765, 15, 38, 40);

    //WIN IF STATEMENT
    if (lv1B1X == 650 && lv1B2X == 650 && lv1B3X == 650) {
      win.play(1);
      congrats();
    }
  } else if (screen == "levelTwo") {

    //Animation
    background(230);

    //If statement animates moving level indicator 
    if (levelIndicatorX <= 775 && levelIndicatorX >= 445) {
      levelIndicatorX -= 0.5;
    } else if (levelIndicatorX <= 445) {
      levelIndicatorX = 775;
    }

    //If statement animates moving level background
    if (lvlBgY > -100) {
      lvlBgY--;
    } else {
      lvlBgY = 500;
    }
    if (lvlBgY2 > - 100) {
      lvlBgY2--;
    } else {
      lvlBgY2 = 500;
    }
    if (lvlBgY3 > - 100) {
      lvlBgY3--;
    } else {
      lvlBgY3 = 500;
    }
    if (lvlBgY4 > - 100) {
      lvlBgY4--;
    } else {
      lvlBgY4 = 500;
    }

    //Game Mechanic LevelTwo  Block Y-COORDINATES (formats order of blocks depending on amount and quantity)
    //If POST #1 has 4 DISKS
    if (lv2B1X == 150 && lv2B2X == 150 && lv2B3X == 150 && lv2B4X == 150) {
      if (lv2B4Y == 175) { 
        lv2B3Y = 365;
        lv2B2Y = 395;
        lv2B1Y = 425;
      } else if (lv2B4Y != 175) {
        lv2B4Y = 335;
        lv2B3Y = 365;
        lv2B2Y = 395;
        lv2B1Y = 425;
      }
    }
    //If POST #1 has 3 DISKS
    if (lv2B1X == 150 && lv2B2X == 150 && lv2B3X == 150 && lv2B4X != 150) {
      if (lv2B3Y == 175) { 
        lv2B2Y = 395;
        lv2B1Y = 425;
      } else if (lv2B3Y != 175) {
        lv2B3Y = 365;
        lv2B2Y = 395;
        lv2B1Y = 425;
      }
    } else if (lv2B1X == 150 && lv2B2X == 150 && lv2B3X != 150 && lv2B4X == 150) {
      if (lv2B4Y == 175) {
        lv2B2Y = 395;
        lv2B1Y = 425;
      } else if (lv2B4Y != 175) {
        lv2B4Y = 365;
        lv2B2Y = 395;
        lv2B1Y = 425;
      }
    } else if (lv2B1X == 150 && lv2B2X != 150 && lv2B3X == 150 && lv2B4X == 150) {
      if (lv2B4Y == 175) {
        lv2B3Y = 395;
        lv2B1Y = 425;
      } else if (lv2B4Y != 175) {
        lv2B4Y = 365;
        lv2B3Y = 395;
        lv2B1Y = 425;
      }
    } else if (lv2B1X != 150 && lv2B2X == 150 && lv2B3X == 150 && lv2B4X == 150) {
      if (lv2B4Y == 175) {
        lv2B3Y = 395;
        lv2B2Y = 425;
      } else if (lv2B4Y != 175) {
        lv2B4Y = 365;
        lv2B3Y = 395;
        lv2B2Y = 425;
      }
    }
    //If POST #1 has 2 DISKS
    else if (lv2B1X == 150 && lv2B2X == 150 && lv2B3X != 150 && lv2B4X != 150) {
      if (lv2B2Y == 175 ) {
        lv2B1Y = 425;
      } else if (lv2B2Y != 175 ) {
        lv2B2Y = 395;
        lv2B1Y = 425;
      }
    } else if (lv2B1X == 150 && lv2B2X != 150 && lv2B3X == 150 && lv2B4X != 150) {
      if (lv2B3Y == 175) {
        lv2B1Y = 425;
      } else if (lv2B3Y != 175) {
        lv2B3Y = 395;
        lv2B1Y = 425;
      }
    } else if (lv2B1X == 150 && lv2B2X != 150 && lv2B3X != 150 && lv2B4X == 150) {
      if (lv2B4Y == 175) {
        lv2B1Y = 425;
      } else if ( lv2B4Y != 175) {
        lv2B4Y = 395;
        lv2B1Y = 425;
      }
    } else if (lv2B1X != 150 && lv2B2X == 150 && lv2B3X == 150 && lv2B4X != 150) {
      if (lv2B3Y == 175) {
        lv2B2Y = 425;
      } else if (lv2B3Y != 175) {
        lv2B3Y = 395;
        lv2B2Y = 425;
      }
    } else if (lv2B1X != 150 && lv2B2X == 150 && lv2B3X != 150 && lv2B4X == 150) {
      if (lv2B4Y == 175) {
        lv2B2Y = 425;
      } else if (lv2B4Y != 175) {
        lv2B4Y = 395;
        lv2B2Y = 425;
      }
    } else if (lv2B1X != 150 && lv2B2X != 150 && lv2B3X == 150 && lv2B4X == 150) {
      if (lv2B4Y == 175) {
        lv2B3Y = 425;
      } else if (lv2B4Y != 175) {
        lv2B4Y = 395;
        lv2B3Y = 425;
      }
    }
    //If POST #1 has 1 DISK
    else if (lv2B1X != 150 && lv2B2X != 150 && lv2B3X != 150 && lv2B4X == 150) {
      if (lv2B4Y == 175 ) {
      } else if (lv2B4Y != 175 ) {
        lv2B4Y = 425;
      }
    } else if (lv2B1X != 150 && lv2B2X != 150 && lv2B3X == 150 && lv2B4X != 150) {
      if (lv2B3Y == 175) {
      } else if (lv2B3Y != 175) {
        lv2B3Y = 425;
      }
    } else if (lv2B1X != 150 && lv2B2X == 150 && lv2B3X != 150 && lv2B4X != 150) {
      if (lv2B2Y == 175) {
      } else if ( lv2B2Y != 175) {
        lv2B2Y = 425;
      }
    } else if (lv2B1X == 150 && lv2B2X != 150 && lv2B3X != 150 && lv2B4X != 150) {
      if (lv2B1Y == 175) {
      } else if (lv2B1Y != 175) {
        lv2B1Y = 425;
      }
    }
    //If POST #2 has 4 DISKS
    if (lv2B1X == 400 && lv2B2X == 400 && lv2B3X == 400 && lv2B4X == 400) {
      if (lv2B4Y == 175) { 
        lv2B3Y = 365;
        lv2B2Y = 395;
        lv2B1Y = 425;
      } else if (lv2B4Y != 175) {
        lv2B4Y = 335;
        lv2B3Y = 365;
        lv2B2Y = 395;
        lv2B1Y = 425;
      }
    }
    //If POST #2 has 3 DISKS
    if (lv2B1X == 400 && lv2B2X == 400 && lv2B3X == 400 && lv2B4X != 400) {
      if (lv2B3Y == 175) { 
        lv2B2Y = 395;
        lv2B1Y = 425;
      } else if (lv2B3Y != 175) {
        lv2B3Y = 365;
        lv2B2Y = 395;
        lv2B1Y = 425;
      }
    } else if (lv2B1X == 400 && lv2B2X == 400 && lv2B3X != 400 && lv2B4X == 400) {
      if (lv2B4Y == 175) {
        lv2B2Y = 395;
        lv2B1Y = 425;
      } else if (lv2B4Y != 175) {
        lv2B4Y = 365;
        lv2B2Y = 395;
        lv2B1Y = 425;
      }
    } else if (lv2B1X == 400 && lv2B2X != 400 && lv2B3X == 400 && lv2B4X == 400) {
      if (lv2B4Y == 175) {
        lv2B3Y = 395;
        lv2B1Y = 425;
      } else if (lv2B4Y != 175) {
        lv2B4Y = 365;
        lv2B3Y = 395;
        lv2B1Y = 425;
      }
    } else if (lv2B1X != 400 && lv2B2X == 400 && lv2B3X == 400 && lv2B4X == 400) {
      if (lv2B4Y == 175) {
        lv2B3Y = 395;
        lv2B2Y = 425;
      } else if (lv2B4Y != 175) {
        lv2B4Y = 365;
        lv2B3Y = 395;
        lv2B2Y = 425;
      }
    }
    //If POST #2 has 2 DISKS
    else if (lv2B1X == 400 && lv2B2X == 400 && lv2B3X != 400 && lv2B4X != 400) {
      if (lv2B2Y == 175 ) {
        lv2B1Y = 425;
      } else if (lv2B2Y != 175 ) {
        lv2B2Y = 395;
        lv2B1Y = 425;
      }
    } else if (lv2B1X == 400 && lv2B2X != 400 && lv2B3X == 400 && lv2B4X != 400) {
      if (lv2B3Y == 175) {
        lv2B1Y = 425;
      } else if (lv2B3Y != 175) {
        lv2B3Y = 395;
        lv2B1Y = 425;
      }
    } else if (lv2B1X == 400 && lv2B2X != 400 && lv2B3X != 400 && lv2B4X == 400) {
      if (lv2B4Y == 175) {
        lv2B1Y = 425;
      } else if ( lv2B4Y != 175) {
        lv2B4Y = 395;
        lv2B1Y = 425;
      }
    } else if (lv2B1X != 400 && lv2B2X == 400 && lv2B3X == 400 && lv2B4X != 400) {
      if (lv2B3Y == 175) {
        lv2B2Y = 425;
      } else if (lv2B3Y != 175) {
        lv2B3Y = 395;
        lv2B2Y = 425;
      }
    } else if (lv2B1X != 400 && lv2B2X == 400 && lv2B3X != 400 && lv2B4X == 400) {
      if (lv2B4Y == 175) {
        lv2B2Y = 425;
      } else if (lv2B4Y != 175) {
        lv2B4Y = 395;
        lv2B2Y = 425;
      }
    } else if (lv2B1X != 400 && lv2B2X != 400 && lv2B3X == 400 && lv2B4X == 400) {
      if (lv2B4Y == 175) {
        lv2B3Y = 425;
      } else if (lv2B4Y != 175) {
        lv2B4Y = 395;
        lv2B3Y = 425;
      }
    }
    //If POST #2 has 1 DISK
    else if (lv2B1X != 400 && lv2B2X != 400 && lv2B3X != 400 && lv2B4X == 400) {
      if (lv2B4Y == 175 ) {
      } else if (lv2B4Y != 175 ) {
        lv2B4Y = 425;
      }
    } else if (lv2B1X != 400 && lv2B2X != 400 && lv2B3X == 400 && lv2B4X != 400) {
      if (lv2B3Y == 175) {
      } else if (lv2B3Y != 175) {
        lv2B3Y = 425;
      }
    } else if (lv2B1X != 400 && lv2B2X == 400 && lv2B3X != 400 && lv2B4X != 400) {
      if (lv2B2Y == 175) {
      } else if ( lv2B2Y != 175) {
        lv2B2Y = 425;
      }
    } else if (lv2B1X == 400 && lv2B2X != 400 && lv2B3X != 400 && lv2B4X != 400) {
      if (lv2B1Y == 175) {
      } else if (lv2B1Y != 175) {
        lv2B1Y = 425;
      }
    }
    //If POST #3 has 4 DISKS
    if (lv2B1X == 650 && lv2B2X == 650 && lv2B3X == 650 && lv2B4X == 650) {
      if (lv2B4Y == 175) { 
        lv2B3Y = 365;
        lv2B2Y = 395;
        lv2B1Y = 425;
      } else if (lv2B4Y != 175) {
        lv2B4Y = 335;
        lv2B3Y = 365;
        lv2B2Y = 395;
        lv2B1Y = 425;
      }
    }
    //If POST #3 has 3 DISKS
    if (lv2B1X == 650 && lv2B2X == 650 && lv2B3X == 650 && lv2B4X != 650) {
      if (lv2B3Y == 175) { 
        lv2B2Y = 395;
        lv2B1Y = 425;
      } else if (lv2B3Y != 175) {
        lv2B3Y = 365;
        lv2B2Y = 395;
        lv2B1Y = 425;
      }
    } else if (lv2B1X == 650 && lv2B2X == 650 && lv2B3X != 650 && lv2B4X == 650) {
      if (lv2B4Y == 175) {
        lv2B2Y = 395;
        lv2B1Y = 425;
      } else if (lv2B4Y != 175) {
        lv2B4Y = 365;
        lv2B2Y = 395;
        lv2B1Y = 425;
      }
    } else if (lv2B1X == 650 && lv2B2X != 650 && lv2B3X == 650 && lv2B4X == 650) {
      if (lv2B4Y == 175) {
        lv2B3Y = 395;
        lv2B1Y = 425;
      } else if (lv2B4Y != 175) {
        lv2B4Y = 365;
        lv2B3Y = 395;
        lv2B1Y = 425;
      }
    } else if (lv2B1X != 650 && lv2B2X == 650 && lv2B3X == 650 && lv2B4X == 650) {
      if (lv2B4Y == 175) {
        lv2B3Y = 395;
        lv2B2Y = 425;
      } else if (lv2B4Y != 175) {
        lv2B4Y = 365;
        lv2B3Y = 395;
        lv2B2Y = 425;
      }
    }
    //If POST #3 has 2 DISKS
    else if (lv2B1X == 650 && lv2B2X == 650 && lv2B3X != 650 && lv2B4X != 650) {
      if (lv2B2Y == 175 ) {
        lv2B1Y = 425;
      } else if (lv2B2Y != 175 ) {
        lv2B2Y = 395;
        lv2B1Y = 425;
      }
    } else if (lv2B1X == 650 && lv2B2X != 650 && lv2B3X == 650 && lv2B4X != 650) {
      if (lv2B3Y == 175) {
        lv2B1Y = 425;
      } else if (lv2B3Y != 175) {
        lv2B3Y = 395;
        lv2B1Y = 425;
      }
    } else if (lv2B1X == 650 && lv2B2X != 650 && lv2B3X != 650 && lv2B4X == 650) {
      if (lv2B4Y == 175) {
        lv2B1Y = 425;
      } else if ( lv2B4Y != 175) {
        lv2B4Y = 395;
        lv2B1Y = 425;
      }
    } else if (lv2B1X != 650 && lv2B2X == 650 && lv2B3X == 650 && lv2B4X != 650) {
      if (lv2B3Y == 175) {
        lv2B2Y = 425;
      } else if (lv2B3Y != 175) {
        lv2B3Y = 395;
        lv2B2Y = 425;
      }
    } else if (lv2B1X != 650 && lv2B2X == 650 && lv2B3X != 650 && lv2B4X == 650) {
      if (lv2B4Y == 175) {
        lv2B2Y = 425;
      } else if (lv2B4Y != 175) {
        lv2B4Y = 395;
        lv2B2Y = 425;
      }
    } else if (lv2B1X != 650 && lv2B2X != 650 && lv2B3X == 650 && lv2B4X == 650) {
      if (lv2B4Y == 175) {
        lv2B3Y = 425;
      } else if (lv2B4Y != 175) {
        lv2B4Y = 395;
        lv2B3Y = 425;
      }
    }
    //If POST #3 has 1 DISK
    else if (lv2B1X != 650 && lv2B2X != 650 && lv2B3X != 650 && lv2B4X == 650) {
      if (lv2B4Y == 175 ) {
      } else if (lv2B4Y != 175 ) {
        lv2B4Y = 425;
      }
    } else if (lv2B1X != 650 && lv2B2X != 650 && lv2B3X == 650 && lv2B4X != 650) {
      if (lv2B3Y == 175) {
      } else if (lv2B3Y != 175) {
        lv2B3Y = 425;
      }
    } else if (lv2B1X != 650 && lv2B2X == 650 && lv2B3X != 650 && lv2B4X != 650) {
      if (lv2B2Y == 175) {
      } else if ( lv2B2Y != 175) {
        lv2B2Y = 425;
      }
    } else if (lv2B1X == 650 && lv2B2X != 650 && lv2B3X != 650 && lv2B4X != 650) {
      if (lv2B1Y == 175) {
      } else if (lv2B1Y != 175) {
        lv2B1Y = 425;
      }
    }
    display();
    noStroke();
    fill(50);
    rectMode(RADIUS);
    rect(450, 15, 50, 40);
    rect(765, 15, 38, 40);

    //WIN IF STATEMENT
    if (lv2B1X == 650 && lv2B2X == 650 && lv2B3X == 650 && lv2B4X == 650) {
      win.play(1);
      congrats();
    }
  } else if (screen == "congrats") {
    congrats();
    game.pause();

    //If statement animates rising tower
    if (cGAnimationY1 >= 220 && cGAnimationY2 < 355) {
      cGAnimationY1 -= 6;
    }
    if (cGAnimationY2 >= 270 && cGAnimationY3 < 400) {
      cGAnimationY2 -= 6;
    }
    if (cGAnimationY3 >= 325 && cGAnimationY4 < 460) {
      cGAnimationY3 -= 6;
    }
    if (cGAnimationY4 >= 385 && cGAnimationY5 < 495) {
      cGAnimationY4 -= 6;
    }
    if (cGAnimationY5 >= 450) {
      cGAnimationY5 -= 6;
    }
  } else if (screen == "eTIntro") {
    eTIntro();
  } else if (screen == "eTLevelSelection") {
    eTLevelSelection();
  } else if (screen == "goodBye") {
    myBackground();
    goodBye();
    mainMenu.pause();
    if (mousePressed == true) {
      if (dist(cursorX, cursorY, gBExitButtonX, gBExitButtonY) <= (cursorRad+gBExitRad)) {
        exit();
      }
    }
  }
  //Updates position of cursor based on coordinates of user's mouse
  cursorX = mouseX;
  cursorY = mouseY;
}

void mouseReleased() {
  if (screen == "intro") {
    if (dist(cursorX, cursorY, introButtonX, introButtonY) <= (cursorRad+introRad)) {
      mainMenu();
      mainMenu.loop(1);
     advance.play(1);
      try {
        userName = getString("What is your name? MAX 10 CHARACTERS ");
        if (userName.length() > 10) { 
          eTIntro();
        }
      }
      catch (NullPointerException error) {
        goBack.play(1);
        mainMenu.pause();
        intro();
      }
    }
  } else if (screen == "eTIntro") {
    if (dist(cursorX, cursorY, eTButtonX, eTButtonY) <= (cursorRad+eTRad)) {
      intro();
      mainMenu.pause();
      goBack.play(1);
    }
  } else if (screen == "mainMenu") {
    if (dist(cursorX, cursorY, mMInstructionsButtonX, mMInstructionsButtonY) <= (cursorRad+mMInstructionsRad)) {
      instructions();
      advance.play(1);
    }
    if (dist(cursorX, cursorY, mMExitButtonX, mMExitButtonY) <= (cursorRad+mMExitRad)) {
      goodBye();
      advance.play(1);
    }
    if (dist(cursorX, cursorY, mMLevelSelectButtonX, mMLevelSelectButtonY) <= (cursorRad+mMLevelSelectRad)) {
      levelSelection();
      advance.play(1);
    }
  } else if (screen == "instructions") {
    if (dist(cursorX, cursorY, iSReturnButtonX, iSReturnButtonY) <= (cursorRad+iSReturnRad)) {
      mainMenu();
      goBack.play(1);
    }
  } else if (screen == "levelSelection") {
    if (dist(cursorX, cursorY, lSReturnButtonX, lSReturnButtonY) <= (cursorRad+lSReturnRad)) {
      mainMenu();
      goBack.play(1);
    }
    if (dist(cursorX, cursorY, lSChooseButtonX, lSChooseButtonY) <= (cursorRad+lSChooseRad)) {
      advance.play(1);
      mainMenu.pause();
      try {
        levelSelection = getInt(" 1  for Level One  ||  2  for Level Two");
        if (levelSelection == 1 || levelSelection == 2) {
          display();
          game.loop();
        } else {
          eTLevelSelection();
        }
      }
      catch (NumberFormatException error) {
        goBack.play(1);
        eTLevelSelection();
        mainMenu.play(1);
      }
    }
  } else if (screen == "eTLevelSelection") {
    if (dist(cursorX, cursorY, eTButtonX, eTButtonY) <= (cursorRad+eTRad)) {
      levelSelection();
      mainMenu.play(1);
      goBack.play(1);
    }
  } else if (screen == "levelOne") {
    //User Input for Level One
    if (cursorX >= 50 && cursorX < 250 && cursorY < 455 && cursorY >= 225) {
      if (blockSelectedB == true || blockSelectedC == true) {
        blockPlacement();
      } else if (blockSelectedB == false || blockSelectedC == false) {
        clickCountA++;
        //If POST #1 has 3 DISKS
        if (lv1B1X == 150 && lv1B2X == 150 && lv1B3X == 150) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv1B3Y = 175;
            blockSelectedA = true;
            select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv1B3Y = 365;
            clickCountA = 0;
            blockSelectedA = false;
            place.play(1);
          }
        }
        //If POST #1 has 2 DISKS
        else if (lv1B1X == 150 && lv1B2X == 150 && lv1B3X != 150 ) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv1B2Y = 175; 
            blockSelectedA = true;
            select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv1B2Y = 395;
            clickCountA = 0;
            blockSelectedA = false;
            place.play(1);
          }
        } else if (lv1B1X == 150 && lv1B2X != 150 && lv1B3X == 150) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv1B3Y = 175;
            blockSelectedA = true;
            select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv1B3Y = 395;
            clickCountA = 0;
            blockSelectedA = false;
           place.play(1);
          }
        } else if (lv1B1X != 150 && lv1B2X == 150 && lv1B3X == 150) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv1B3Y = 175;
            blockSelectedA = true;
            select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv1B3Y = 395;
            clickCountA = 0;
            blockSelectedA = false;
            place.play(1);
          }
        }
        //If POST #1 has 1 DISK
        else if (lv1B1X == 150 && lv1B2X != 150 && lv1B3X != 150 ) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv1B1Y = 175;
            blockSelectedA = true;
            select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv1B1Y = 425;
            clickCountA = 0;
            blockSelectedA = false;
            place.play(1);
          }
        } else if (lv1B1X != 150 && lv1B2X == 150 && lv1B3X != 150) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv1B2Y = 175;
            blockSelectedA = true;
            select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv1B2Y = 425;
            clickCountA = 0;
            blockSelectedA = false;
            place.play(1);
          }
        } else if (lv1B1X != 150 && lv1B2X != 150 && lv1B3X == 150) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv1B3Y = 175;
            blockSelectedA = true;
            select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv1B3Y = 425;
            clickCountA = 0;
            blockSelectedA = false;
            place.play(1);
          }
        }
        //If post has no DISK
        if (lv1B1X != 150 && lv1B2X != 150 && lv1B3X != 150) {
          clickCountA = 0; //THIS IS IF THERE ARE NO DISKS, BUT USER CLICKS ON EMPTY POST
          blockSelectedA = false;
        }
      }
    } else if (cursorX >= 300 && cursorX < 500 && cursorY < 455 && cursorY >= 225) {
      if (blockSelectedA == true || blockSelectedC == true) {
        blockPlacement();
      } else if (blockSelectedA == false || blockSelectedC == false) {
        clickCountB++;
        //If POST #2 has 3 DISKS
        if (lv1B1X == 400 && lv1B2X == 400 && lv1B3X == 400) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv1B3Y = 175;
            blockSelectedB = true;
            select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv1B3Y = 365;
            clickCountB = 0;
            blockSelectedB = false;
            place.play(1);
          }
        }
        //If POST #2 has 2 DISKS
        else if (lv1B1X == 400 && lv1B2X == 400 && lv1B3X != 400 ) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv1B2Y = 175; 
            blockSelectedB = true;
            select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv1B2Y = 395;
            clickCountB = 0;
            blockSelectedB = false;
            place.play(1);
          }
        } else if (lv1B1X == 400 && lv1B2X != 400 && lv1B3X == 400) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv1B3Y = 175;
            blockSelectedB = true;
            select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv1B3Y = 395;
            clickCountB = 0;
            blockSelectedB = false;
            place.play(1);
          }
        } else if (lv1B1X != 400 && lv1B2X == 400 && lv1B3X == 400) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv1B3Y = 175;
            blockSelectedB = true;
            //select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv1B3Y = 395;
            clickCountB = 0;
            blockSelectedB = false;
            //place.play(1);
          }
        }
        //If POST #2 has 1 DISK
        else if (lv1B1X == 400 && lv1B2X != 400 && lv1B3X != 400 ) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv1B1Y = 175;
            blockSelectedB = true;
            //select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv1B1Y = 425;
            clickCountB = 0;
            blockSelectedB = false;
            //place.play(1);
          }
        } else if (lv1B1X != 400 && lv1B2X == 400 && lv1B3X != 400) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv1B2Y = 175;
            blockSelectedB = true;
            //select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv1B2Y = 425;
            clickCountB = 0;
            blockSelectedB = false;
            //place.play(1);
          }
        } else if (lv1B1X != 400 && lv1B2X != 400 && lv1B3X == 400) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv1B3Y = 175;
            blockSelectedB = true;
            //select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv1B3Y = 425;
            clickCountB = 0;
            blockSelectedB = false;
            //place.play(1);
          }
        }
        //If post has no DISK
        if (lv1B1X != 400 && lv1B2X != 400 && lv1B3X != 400) {
          clickCountB = 0; //THIS IS IF THERE ARE NO DISKS, BUT USER CLICKS ON EMPTY POST
          blockSelectedB = false;
        }
      }
    } else if (cursorX >= 550 && cursorX < 750 && cursorY < 455 && cursorY >= 225) {
      if (blockSelectedA == true || blockSelectedB == true) {
        blockPlacement();
      } else if (blockSelectedA == false || blockSelectedB == false) {
        clickCountC++;
        //If POST #3 has 3 DISKS, WIN CONDITION IS MET (skips to if statement for win, in draw)

        //If POST #3 has 2 DISKS
        if (lv1B1X == 650 && lv1B2X == 650 && lv1B3X != 650 ) {
          if (clickCountC == 1 && blockSelectedC == false) {
            lv1B2Y = 175; //HERE CHANGE VARIABLES FOR REST
            blockSelectedC = true;
            //select.play(1);
          } else if (clickCountC == 2 && blockSelectedC == false) {
            clickCountC = 0;
          } else if (clickCountC == 2 && blockSelectedC == true) { //if pressed twice in same spot
            lv1B2Y = 395;
            clickCountC = 0;
            blockSelectedC = false;
            //place.play(1);
          }
        } else if (lv1B1X == 650 && lv1B2X != 650 && lv1B3X == 650) {
          if (clickCountC == 1 && blockSelectedC == false) {
            lv1B3Y = 175;
            blockSelectedC = true;
            //select.play(1);
          } else if (clickCountC == 2 && blockSelectedC == false) {
            clickCountC = 0;
          } else if (clickCountC == 2 && blockSelectedC == true) { //if pressed twice in same spot
            lv1B3Y = 395;
            clickCountC = 0;
            blockSelectedC = false;
            //place.play(1);
          }
        } else if (lv1B1X != 650 && lv1B2X == 650 && lv1B3X == 650) {
          if (clickCountC == 1 && blockSelectedC == false) {
            lv1B3Y = 175;
            blockSelectedC = true;
            //select.play(1);
          } else if (clickCountC == 2 && blockSelectedC == false) {
            clickCountC = 0;
          } else if (clickCountC == 2 && blockSelectedC == true) { //if pressed twice in same spot
            lv1B3Y = 395;
            clickCountC = 0;
            blockSelectedC = false;
            //place.play(1);
          }
        }
        //If POST #3 has 1 DISK
        else if (lv1B1X == 650 && lv1B2X != 650 && lv1B3X != 650 ) {
          if (clickCountC == 1 && blockSelectedC == false) {
            lv1B1Y = 175;
            blockSelectedC = true;
            //select.play(1);
          } else if (clickCountC == 2 && blockSelectedC == false) {
            clickCountC = 0;
          } else if (clickCountC == 2 && blockSelectedC == true) { //if pressed twice in same spot
            lv1B1Y = 425;
            clickCountC = 0;
            blockSelectedC = false;
            //place.play(1);
          }
        } else if (lv1B1X != 650 && lv1B2X == 650 && lv1B3X != 650) {
          if (clickCountC == 1 && blockSelectedC == false) {
            lv1B2Y = 175;
            blockSelectedC = true;
            //select.play(1);
          } else if (clickCountC == 2 && blockSelectedC == false) {
            clickCountC = 0;
          } else if (clickCountC == 2 && blockSelectedC == true) { //if pressed twice in same spot
            lv1B2Y = 425;
            clickCountC = 0;
            blockSelectedC = false;
            //place.play(1);
          }
        } else if (lv1B1X != 650 && lv1B2X != 650 && lv1B3X == 650) {
          if (clickCountC == 1 && blockSelectedC == false) {
            lv1B3Y = 175;
            blockSelectedC = true;
            //select.play(1);
          } else if (clickCountC == 2 && blockSelectedC == false) {
            clickCountC = 0;
          } else if (clickCountC == 2 && blockSelectedC == true) { //if pressed twice in same spot
            lv1B3Y = 425;
            clickCountC = 0;
            blockSelectedC = false;
            //place.play(1);
          }
        }
        //If post has no DISK
        if (lv1B1X != 650 && lv1B2X != 650 && lv1B3X != 650) {
          clickCountC = 0; //THIS IS IF THERE ARE NO DISKS, BUT USER CLICKS ON EMPTY POST
          blockSelectedC = false;
        }
      }
    }
    if (dist(cursorX, cursorY, dPReturnButtonX, dPReturnButtonY) <= (cursorRad+dPReturnRad)) {
      levelSelection();
      //game.pause();
      //goBack.play(1);
      //mainMenu.loop();

      //Resets variables
      lv1B1X = 150;
      lv1B1Y = 425;
      lv1B2X = 150;
      lv1B2Y = 395;
      lv1B3X = 150;
      lv1B3Y = 365;
      clickCountA = 0;
      clickCountB = 0;
      clickCountC = 0;
      movesTaken = 0;
      blockSelectedA = false;
      blockSelectedB = false;
      blockSelectedC = false;
    }
  } else if (screen == "levelTwo") {
    //User Input for GAME
    if (cursorX >= 50 && cursorX < 250 && cursorY < 455 && cursorY >= 225) {
      if (blockSelectedB == true || blockSelectedC == true) {
        blockPlacement();
      } else if (blockSelectedB == false || blockSelectedC == false) {
        clickCountA++;
        //If POST #1 has 4 DISKS
        if (lv2B1X == 150 && lv2B2X == 150 && lv2B3X == 150 && lv2B4X == 150) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv2B4Y = 175;
            blockSelectedA = true;
            //select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv2B4Y = 335;
            clickCountA = 0;
            blockSelectedA = false;
            //place.play(1);
          }
        }
        //If POST #1 has 3 DISKS
        if (lv2B1X == 150 && lv2B2X == 150 && lv2B3X == 150 && lv2B4X != 150) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv2B3Y = 175;
            blockSelectedA = true;
            //select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv2B3Y = 365;
            clickCountA = 0;
            blockSelectedA = false;
            //place.play(1);
          }
        } else if (lv2B1X == 150 && lv2B2X == 150 && lv2B3X != 150 && lv2B4X == 150) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv2B4Y = 175;
            blockSelectedA = true;
            //select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv2B4Y = 365;
            clickCountA = 0;
            blockSelectedA = false;
            //place.play(1);
          }
        } else if (lv2B1X == 150 && lv2B2X != 150 && lv2B3X == 150 && lv2B4X == 150) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv2B4Y = 175;
            blockSelectedA = true;
            //select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv2B4Y = 365;
            clickCountA = 0;
            blockSelectedA = false;
            //place.play(1);
          }
        } else if (lv2B1X != 150 && lv2B2X == 150 && lv2B3X == 150 && lv2B4X == 150) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv2B4Y = 175;
            blockSelectedA = true;
            //select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv2B4Y = 365;
            clickCountA = 0;
            blockSelectedA = false;
            //place.play(1);
          }
        }
        //If POST #1 has 2 DISKS
        else if (lv2B1X == 150 && lv2B2X == 150 && lv2B3X != 150 && lv2B4X != 150) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv2B2Y = 175;
            blockSelectedA = true;
            //select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv2B2Y = 395;
            clickCountA = 0;
            blockSelectedA = false;
            //place.play(1);
          }
        } else if (lv2B1X == 150 && lv2B2X != 150 && lv2B3X == 150 && lv2B4X != 150) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv2B3Y = 175;
            blockSelectedA = true;
            //select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv2B3Y = 395;
            clickCountA = 0;
            blockSelectedA = false;
            //place.play(1);
          }
        } else if (lv2B1X == 150 && lv2B2X != 150 && lv2B3X != 150 && lv2B4X == 150) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv2B4Y = 175;
            blockSelectedA = true;
            //select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv2B4Y = 395;
            clickCountA = 0;
            blockSelectedA = false;
           // place.play(1);
          }
        } else if (lv2B1X != 150 && lv2B2X == 150 && lv2B3X == 150 && lv2B4X != 150) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv2B3Y = 175;
            blockSelectedA = true;
     //       select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv2B3Y = 395;
            clickCountA = 0;
            blockSelectedA = false;
         //   place.play(1);
          }
        } else if (lv2B1X != 150 && lv2B2X == 150 && lv2B3X != 150 && lv2B4X == 150) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv2B4Y = 175;
            blockSelectedA = true;
     //       select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv2B4Y = 395;
            clickCountA = 0;
            blockSelectedA = false;
     //       place.play(1);
          }
        } else if (lv2B1X != 150 && lv2B2X != 150 && lv2B3X == 150 && lv2B4X == 150) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv2B4Y = 175;
            blockSelectedA = true;
      //      select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv2B4Y = 395;
            clickCountA = 0;
            blockSelectedA = false;
   //         place.play(1);
          }
        }
        //If POST #1 has 1 DISK
        else if (lv2B1X != 150 && lv2B2X != 150 && lv2B3X != 150 && lv2B4X == 150) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv2B4Y = 175;
            blockSelectedA = true;
        //    select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv2B4Y = 425;
            clickCountA = 0;
            blockSelectedA = false;
        //    place.play(1);
          }
        } else if (lv2B1X != 150 && lv2B2X != 150 && lv2B3X == 150 && lv2B4X != 150) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv2B3Y = 175;
            blockSelectedA = true;
      //      select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv2B3Y = 425;
            clickCountA = 0;
            blockSelectedA = false;
            //place.play(1);
          }
        } else if (lv2B1X != 150 && lv2B2X == 150 && lv2B3X != 150 && lv2B4X != 150) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv2B2Y = 175;
            blockSelectedA = true;
            //select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv2B2Y = 425;
            clickCountA = 0;
            blockSelectedA = false;
        //    place.play(1);
          }
        } else if (lv2B1X == 150 && lv2B2X != 150 && lv2B3X != 150 && lv2B4X != 150) {
          if (clickCountA == 1 && blockSelectedA == false) {
            lv2B1Y = 175;
            blockSelectedA = true;
       //     select.play(1);
          } else if (clickCountA == 2 && blockSelectedA == false) {
            clickCountA = 0;
          } else if (clickCountA == 2 && blockSelectedA == true) { //if pressed twice in same spot
            lv2B1Y = 425;
            clickCountA = 0;
            blockSelectedA = false;
        //    place.play(1);
          }
        }
        //If post has no DISK
        if (lv2B1X != 150 && lv2B2X != 150 && lv2B3X != 150 && lv2B4X != 150) {
          clickCountA = 0; //THIS IS IF THERE ARE NO DISKS, BUT USER CLICKS ON EMPTY POST
          blockSelectedA = false;
        }
      }
    } else if (cursorX >= 300 && cursorX < 500 && cursorY < 455 && cursorY >= 225) {
      if (blockSelectedA == true || blockSelectedC == true) {
        blockPlacement();
      } else if (blockSelectedA == false || blockSelectedC == false) {
        clickCountB++;
        //If POST #2 has 4 DISKS
        if (lv2B1X == 400 && lv2B2X == 400 && lv2B3X == 400 && lv2B4X == 400) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv2B4Y = 175;
            blockSelectedB = true;
    //        select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv2B4Y = 335;
            clickCountB = 0;
            blockSelectedB = false;
     //       place.play(1);
          }
        }
        //If POST #2 has 3 DISKS
        if (lv2B1X == 400 && lv2B2X == 400 && lv2B3X == 400 && lv2B4X != 400) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv2B3Y = 175;
            blockSelectedB = true;
      //      select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv2B3Y = 365;
            clickCountB = 0;
            blockSelectedB = false;
      //      place.play(1);
          }
        } else if (lv2B1X == 400 && lv2B2X == 400 && lv2B3X != 400 && lv2B4X == 400) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv2B4Y = 175;
            blockSelectedB = true;
   //         select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv2B4Y = 365;
            clickCountB = 0;
            blockSelectedB = false;
     //       place.play(1);
          }
        } else if (lv2B1X == 400 && lv2B2X != 400 && lv2B3X == 400 && lv2B4X == 400) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv2B4Y = 175;
            blockSelectedB = true;
   //         select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv2B4Y = 365;
            clickCountB = 0;
            blockSelectedB = false;
        //    place.play(1);
          }
        } else if (lv2B1X != 400 && lv2B2X == 400 && lv2B3X == 400 && lv2B4X == 400) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv2B4Y = 175;
            blockSelectedB = true;
     //       select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv2B4Y = 365;
            clickCountB = 0;
            blockSelectedB = false;
      //      place.play(1);
          }
        }
        //If POST #2 has 2 DISKS
        else if (lv2B1X == 400 && lv2B2X == 400 && lv2B3X != 400 && lv2B4X != 400) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv2B2Y = 175;
            blockSelectedB = true;
            //select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv2B2Y = 395;
            clickCountB = 0;
            blockSelectedB = false;
            //place.play(1);
          }
        } else if (lv2B1X == 400 && lv2B2X != 400 && lv2B3X == 400 && lv2B4X != 400) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv2B3Y = 175;
            blockSelectedB = true;
            //select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv2B3Y = 395;
            clickCountB = 0;
            blockSelectedB = false;
            //place.play(1);
          }
        } else if (lv2B1X == 400 && lv2B2X != 400 && lv2B3X != 400 && lv2B4X == 400) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv2B4Y = 175;
            blockSelectedB = true;
            //select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv2B4Y = 395;
            clickCountB = 0;
            blockSelectedB = false;
            //place.play(1);
          }
        } else if (lv2B1X != 400 && lv2B2X == 400 && lv2B3X == 400 && lv2B4X != 400) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv2B3Y = 175;
            blockSelectedB = true;
            //select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv2B3Y = 395;
            clickCountB = 0;
            blockSelectedB = false;
            //place.play(1);
          }
        } else if (lv2B1X != 400 && lv2B2X == 400 && lv2B3X != 400 && lv2B4X == 400) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv2B4Y = 175;
            blockSelectedB = true;
            //select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv2B4Y = 395;
            clickCountB = 0;
            blockSelectedB = false;
            //place.play(1);
          }
        } else if (lv2B1X != 400 && lv2B2X != 400 && lv2B3X == 400 && lv2B4X == 400) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv2B4Y = 175;
            blockSelectedB = true;
            //select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv2B4Y = 395;
            clickCountB = 0;
            blockSelectedB = false;
            //place.play(1);
          }
        }
        //If POST #2 has 1 DISK
        else if (lv2B1X != 400 && lv2B2X != 400 && lv2B3X != 400 && lv2B4X == 400) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv2B4Y = 175;
            blockSelectedB = true;
            //select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv2B4Y = 425;
            clickCountB = 0;
            blockSelectedB = false;
            //place.play(1);
          }
        } else if (lv2B1X != 400 && lv2B2X != 400 && lv2B3X == 400 && lv2B4X != 400) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv2B3Y = 175;
            blockSelectedB = true;
            //select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv2B3Y = 425;
            clickCountB = 0;
            blockSelectedB = false;
            //place.play(1);
          }
        } else if (lv2B1X != 400 && lv2B2X == 400 && lv2B3X != 400 && lv2B4X != 400) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv2B2Y = 175;
            blockSelectedB = true;
            //select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv2B2Y = 425;
            clickCountB = 0;
            blockSelectedB = false;
            //place.play(1);
          }
        } else if (lv2B1X == 400 && lv2B2X != 400 && lv2B3X != 400 && lv2B4X != 400) {
          if (clickCountB == 1 && blockSelectedB == false) {
            lv2B1Y = 175;
            blockSelectedB = true;
            //select.play(1);
          } else if (clickCountB == 2 && blockSelectedB == false) {
            clickCountB = 0;
          } else if (clickCountB == 2 && blockSelectedB == true) { //if pressed twice in same spot
            lv2B1Y = 425;
            clickCountB = 0;
            blockSelectedB = false;
            //place.play(1);
          }
        }
        //If post has no DISK
        if (lv2B1X != 400 && lv2B2X != 400 && lv2B3X != 400 && lv2B4X != 400) {
          clickCountB = 0; //THIS IS IF THERE ARE NO DISKS, BUT USER CLICKS ON EMPTY POST
          blockSelectedB = false;
        }
      }
    } else if (cursorX >= 550 && cursorX < 750 && cursorY < 455 && cursorY >= 225) {
      if (blockSelectedA == true || blockSelectedB == true) {
        blockPlacement();
      } else if (blockSelectedA == false || blockSelectedB == false) {
        clickCountC++;
        //If POST #3 has 4 DISKS, WIN CONDITION IS MET (WIN CONDITION IS MET (skips to if statement for win, in draw)

        //If POST #3 has 3 DISKS
        if (lv2B1X == 650 && lv2B2X == 650 && lv2B3X == 650 && lv2B4X != 650) {
          if (clickCountC == 1 && blockSelectedC == false) {
            lv2B3Y = 175;
            blockSelectedC = true;
            //select.play(1);
          } else if (clickCountC == 2 && blockSelectedC == false) {
            clickCountC = 0;
          } else if (clickCountC == 2 && blockSelectedC == true) { //if pressed twice in same spot
            lv2B3Y = 365;
            clickCountC = 0;
            blockSelectedC = false;
            //place.play(1);
          }
        } else if (lv2B1X == 650 && lv2B2X == 650 && lv2B3X != 650 && lv2B4X == 650) {
          if (clickCountC == 1 && blockSelectedC == false) {
            lv2B4Y = 175;
            blockSelectedC = true;
            //select.play(1);
          } else if (clickCountC == 2 && blockSelectedC == false) {
            clickCountC = 0;
          } else if (clickCountC == 2 && blockSelectedC == true) { //if pressed twice in same spot
            lv2B4Y = 365;
            clickCountC = 0;
            blockSelectedC = false;
            //place.play(1);
          }
        } else if (lv2B1X == 650 && lv2B2X != 650 && lv2B3X == 650 && lv2B4X == 650) {
          if (clickCountC == 1 && blockSelectedC == false) {
            lv2B4Y = 175;
            blockSelectedC = true;
            //select.play(1);
          } else if (clickCountC == 2 && blockSelectedC == false) {
            clickCountC = 0;
          } else if (clickCountC == 2 && blockSelectedC == true) { //if pressed twice in same spot
            lv2B4Y = 365;
            clickCountC = 0;
            blockSelectedC = false;
            //place.play(1);
          }
        } else if (lv2B1X != 650 && lv2B2X == 650 && lv2B3X == 650 && lv2B4X == 650) {
          if (clickCountC == 1 && blockSelectedC == false) {
            lv2B4Y = 175;
            blockSelectedC = true;
            //select.play(1);
          } else if (clickCountC == 2 && blockSelectedC == false) {
            clickCountC = 0;
          } else if (clickCountC == 2 && blockSelectedC == true) { //if pressed twice in same spot
            lv2B4Y = 365;
            clickCountC = 0;
            blockSelectedC = false;
            //place.play(1);
          }
        }
        //If POST #3 has 2 DISKS
        else if (lv2B1X == 650 && lv2B2X == 650 && lv2B3X != 650 && lv2B4X != 650) {
          if (clickCountC == 1 && blockSelectedC == false) {
            lv2B2Y = 175;
            blockSelectedC = true;
            //select.play(1);
          } else if (clickCountC == 2 && blockSelectedC == false) {
            clickCountC = 0;
          } else if (clickCountC == 2 && blockSelectedC == true) { //if pressed twice in same spot
            lv2B2Y = 395;
            clickCountC = 0;
            blockSelectedC = false;
            //place.play(1);
          }
        } else if (lv2B1X == 650 && lv2B2X != 650 && lv2B3X == 650 && lv2B4X != 650) {
          if (clickCountC == 1 && blockSelectedC == false) {
            lv2B3Y = 175;
            blockSelectedC = true;
            //select.play(1);
          } else if (clickCountC == 2 && blockSelectedC == false) {
            clickCountC = 0;
          } else if (clickCountC == 2 && blockSelectedC == true) { //if pressed twice in same spot
            lv2B3Y = 395;
            clickCountC = 0;
            blockSelectedC = false;
            //place.play(1);
          }
        } else if (lv2B1X == 650 && lv2B2X != 650 && lv2B3X != 650 && lv2B4X == 650) {
          if (clickCountC == 1 && blockSelectedC == false) {
            lv2B4Y = 175;
            blockSelectedC = true;
            //select.play(1);
          } else if (clickCountC == 2 && blockSelectedC == false) {
            clickCountC = 0;
          } else if (clickCountC == 2 && blockSelectedC == true) { //if pressed twice in same spot
            lv2B4Y = 395;
            clickCountC = 0;
            blockSelectedC = false;
            //place.play(1);
          }
        } else if (lv2B1X != 650 && lv2B2X == 650 && lv2B3X == 650 && lv2B4X != 650) {
          if (clickCountC == 1 && blockSelectedC == false) {
            lv2B3Y = 175;
            blockSelectedC = true;
          //  select.play(1);
          } else if (clickCountC == 2 && blockSelectedC == false) {
            clickCountC = 0;
          } else if (clickCountC == 2 && blockSelectedC == true) { //if pressed twice in same spot
            lv2B3Y = 395;
            clickCountC = 0;
            blockSelectedC = false;
         //   place.play(1);
          }
        } else if (lv2B1X != 650 && lv2B2X == 650 && lv2B3X != 650 && lv2B4X == 650) {
          if (clickCountC == 1 && blockSelectedC == false) {
            lv2B4Y = 175;
            blockSelectedC = true;
      //      select.play(1);
          } else if (clickCountB == 2 && blockSelectedC == false) {
            clickCountC = 0;
          } else if (clickCountC == 2 && blockSelectedC == true) { //if pressed twice in same spot
            lv2B4Y = 395;
            clickCountC = 0;
            blockSelectedC = false;
       //     place.play(1);
          }
        } else if (lv2B1X != 650 && lv2B2X != 650 && lv2B3X == 650 && lv2B4X == 650) {
          if (clickCountC == 1 && blockSelectedC == false) {
            lv2B4Y = 175;
            blockSelectedC = true;
       //     select.play(1);
          } else if (clickCountC == 2 && blockSelectedC == false) {
            clickCountC = 0;
          } else if (clickCountC == 2 && blockSelectedC == true) { //if pressed twice in same spot
            lv2B4Y = 395;
            clickCountC = 0;
            blockSelectedC = false;
       //     place.play(1);
          }
        }
        //If POST #3 has 1 DISK
        else if (lv2B1X != 650 && lv2B2X != 650 && lv2B3X != 650 && lv2B4X == 650) {
          if (clickCountC == 1 && blockSelectedC == false) {
            lv2B4Y = 175;
            blockSelectedC = true;
      //      select.play(1);
          } else if (clickCountC == 2 && blockSelectedC == false) {
            clickCountC = 0;
          } else if (clickCountC == 2 && blockSelectedC == true) { //if pressed twice in same spot
            lv2B4Y = 425;
            clickCountC = 0;
            blockSelectedC = false;
      //      place.play(1);
          }
        } else if (lv2B1X != 650 && lv2B2X != 650 && lv2B3X == 650 && lv2B4X != 650) {
          if (clickCountC == 1 && blockSelectedC == false) {
            lv2B3Y = 175;
            blockSelectedC = true;
      //      select.play(1);
          } else if (clickCountC == 2 && blockSelectedC == false) {
            clickCountC = 0;
          } else if (clickCountC == 2 && blockSelectedC == true) { //if pressed twice in same spot
            lv2B3Y = 425;
            clickCountC = 0;
            blockSelectedC = false;
       //     place.play(1);
          }
        } else if (lv2B1X != 650 && lv2B2X == 650 && lv2B3X != 650 && lv2B4X != 650) {
          if (clickCountC == 1 && blockSelectedC == false) {
            lv2B2Y = 175;
            blockSelectedC = true;
     //       select.play(1);
          } else if (clickCountC == 2 && blockSelectedC == false) {
            clickCountC = 0;
          } else if (clickCountC == 2 && blockSelectedC == true) { //if pressed twice in same spot
            lv2B2Y = 425;
            clickCountC = 0;
            blockSelectedC = false;
       //     place.play(1);
          }
        } else if (lv2B1X == 650 && lv2B2X != 650 && lv2B3X != 650 && lv2B4X != 650) {
          if (clickCountC == 1 && blockSelectedC == false) {
            lv2B1Y = 175;
            blockSelectedC = true;
   //         select.play(1);
          } else if (clickCountC == 2 && blockSelectedC == false) {
            clickCountC = 0;
          } else if (clickCountC == 2 && blockSelectedC == true) { //if pressed twice in same spot
            lv2B1Y = 425;
            clickCountC = 0;
            blockSelectedC = false;
    //        place.play(1);
          }
        }
        //If post has no DISK
        if (lv2B1X != 650 && lv2B2X != 650 && lv2B3X != 650 && lv2B4X != 650) {
          clickCountC = 0; //THIS IS IF THERE ARE NO DISKS, BUT USER CLICKS ON EMPTY POST
          blockSelectedC = false;
        }
      }
    }
    if (dist(cursorX, cursorY, dPReturnButtonX, dPReturnButtonY) <= (cursorRad+dPReturnRad)) {
      levelSelection();
      goBack.play(1);
      game.pause();
      mainMenu.loop();

      //Resets variables
      lv2B1X = 150;
      lv2B1Y = 425;
      lv2B2X = 150;
      lv2B2Y = 395;
      lv2B3X = 150;
      lv2B3Y = 365;
      lv2B4X = 150;
      lv2B4Y = 335;
      clickCountA = 0;
      clickCountB = 0;
      clickCountC = 0;
      movesTaken = 0;
      blockSelectedA = false;
      blockSelectedB = false;
      blockSelectedC = false;
    }
  } else if (screen == "congrats") {
    if (dist(cursorX, cursorY, cGLevelSelectButtonX, cGLevelSelectButtonY) <= (cursorRad+cGLevelSelectRad)) {
      //This resets the score, IS AFTER the INITIAL RESET because we want the FINAL score to be shown at the conratulatory screen
      movesTaken = 0;
      cGAnimationY1 = 500;
      cGAnimationY2 = 500;
      cGAnimationY3 = 500;
      cGAnimationY4 = 500;
      cGAnimationY5 = 500;

      levelSelection();
      advance.play(1);
      mainMenu.loop();
    } else if (dist(cursorX, cursorY, cGMenuButtonX, cGMenuButtonY) <= (cursorRad+cGMenuRad)) {
      movesTaken = 0;
      cGAnimationY1 = 500;
      cGAnimationY2 = 500;
      cGAnimationY3 = 500;
      cGAnimationY4 = 500;
      cGAnimationY5 = 500;

      mainMenu();
      advance.play(1);
      mainMenu.loop();
    }
  }
}

void blockPlacement() {
  if (screen == "levelOne") {
    if (blockSelectedA == true) {
      //If user selects block from post A, then clicks on post B
      blockSelectedA = false;
      clickCountA = 0;
      if (cursorX >= 300 && cursorX < 500 && cursorY < 455 && cursorY >= 225) {
        if (lv1B3Y == 175) {
          lv1B3Y = 176;  // This changes the y-coordinate, so the code in draw formats the blocks in the correct order, depending on size and position
          lv1B3X = 400;   
          movesTaken++;
          place.play(1);
        } else if (lv1B2Y == 175) {
          //ENFORCES GAME RULE (can only place smaller DISKS on bigger DISKS)
          if (lv1B3X == 400) {
            clickCountA++;
            blockSelectedA = true;
            error.play(1);
          } else {
            lv1B2Y = 176; 
            lv1B2X = 400;
            movesTaken++;
           place.play(1);
          }
        } else if (lv1B1Y == 175) {
          if (lv1B2X == 400 || lv1B3X == 400) {
            clickCountA++;
            blockSelectedA = true;
            error.play(1);
          } else {
            lv1B1Y = 176; 
            lv1B1X = 400;
            movesTaken++;
            place.play(1);
          }
        }
      }
      //If user selects block from post A, then clicks on post C
      if (cursorX >= 550 && cursorX < 750 && cursorY < 455 && cursorY >= 225) {
        if (lv1B3Y == 175) {
          lv1B3Y = 176;  
          lv1B3X = 650;
          movesTaken++;
         place.play(1);
        } else if (lv1B2Y == 175) {
          if (lv1B3X == 650) {
            clickCountA++;
            blockSelectedA = true;
           error.play(1);
          } else {
            lv1B2Y = 176;  
            lv1B2X = 650;
            movesTaken++;
          place.play(1);
          }
        } else if (lv1B1Y == 175) {
          if (lv1B2X == 650 || lv1B3X == 650) {
            clickCountA++;
            blockSelectedA = true;
            error.play(1);
          } else {
            lv1B1Y = 176;  
            lv1B1X = 650;
            movesTaken++;
            place.play(1);
          }
        }
      }
    } else if (blockSelectedB == true) {
      blockSelectedB = false;
      clickCountB = 0;
      //If user selects block from post B, then clicks on post A
      if (cursorX >= 50 && cursorX < 250 && cursorY < 455 && cursorY >= 225) {
        if (lv1B3Y == 175) {
          lv1B3Y = 176;  
          lv1B3X = 150;
          movesTaken++;
          place.play(1);
        } else if (lv1B2Y == 175) {
          if (lv1B3X == 150) {
            clickCountB++;
            blockSelectedB = true;
           error.play(1);
          } else {
            lv1B2Y = 176; 
            lv1B2X = 150;
            movesTaken++;
            place.play(1);
          }
        } else if (lv1B1Y == 175) {
          if (lv1B2X == 150 || lv1B3X == 150) {
            clickCountB++;
            blockSelectedB = true;
            error.play(1);
          } else {
            lv1B1Y = 176; 
            lv1B1X = 150;
            movesTaken++;
           place.play(1);
          }
        }
      }
      //If user selects block from post B, then clicks on post C
      if (cursorX >= 550 && cursorX < 750 && cursorY < 455 && cursorY >= 225) {
        if (lv1B3Y == 175) {
          lv1B3Y = 176;  
          lv1B3X = 650;
          movesTaken++;
          place.play(1);
        } else if (lv1B2Y == 175) {
          if (lv1B3X == 650) {
            clickCountB++;
            blockSelectedB = true;
            error.play(1);
          } else {
            lv1B2Y = 176; 
            lv1B2X = 650;
            movesTaken++;
           place.play(1);
          }
        } else if (lv1B1Y == 175) {
          if (lv1B2X == 650 || lv1B3X == 650) {
            clickCountB++;
            blockSelectedB = true;
           error.play(1);
          } else {
            lv1B1Y = 176; 
            lv1B1X = 650;
            movesTaken++;
            place.play(1);
          }
        }
      }
    } else if (blockSelectedC == true) {
      blockSelectedC = false;
      clickCountC = 0;
      //If user selects block from post C, then clicks on post A
      if (cursorX >= 50 && cursorX < 250 && cursorY < 455 && cursorY >= 225) {    
        if (lv1B3Y == 175) {
          lv1B3Y = 176; 
          lv1B3X = 150;
          movesTaken++;
    //      place.play(1);
        } else if (lv1B2Y == 175) {
          if (lv1B3X == 150) {
            clickCountC++;
            blockSelectedC = true;
   //         error.play(1);
          } else {
            lv1B2Y = 176;
            lv1B2X = 150;
            movesTaken++;
     //       place.play(1);
          }
        } else if (lv1B1Y == 175) {
          if (lv1B2X == 150 || lv1B3X == 150) {
            clickCountC++;
            blockSelectedC = true;
     //       error.play(1);
          } else {
            lv1B1Y = 176; 
            lv1B1X = 150;
            movesTaken++;
  //          place.play(1);
          }
        }
      }
      //If user selects block from post C, then clicks on post B
      if (cursorX >= 300 && cursorX < 500 && cursorY < 455 && cursorY >= 225) {  
        if (lv1B3Y == 175) {
          lv1B3Y = 176;  
          lv1B3X = 400;
          movesTaken++;
   //       place.play(1);
        } else if (lv1B2Y == 175) {
          if (lv1B3X == 400) {
            clickCountC++;
            blockSelectedC = true;
     //       error.play(1);
          } else {
            lv1B2Y = 176;  
            lv1B2X = 400;
            movesTaken++;
     //       place.play(1);
          }
        } else if (lv1B1Y == 175) {
          if (lv1B2X == 400 || lv1B3X == 400) {
            clickCountC++;
            blockSelectedC = true;
    //        error.play(1);
          } else {
            lv1B1Y = 176;  
            lv1B1X = 400;
            movesTaken++;
     //       place.play(1);
          }
        }
      }
    }
  } else if (screen == "levelTwo") {
    if (blockSelectedA == true) {
      //If user selects block from post A, then clicks on post B
      blockSelectedA = false;
      clickCountA = 0;
      if (cursorX >= 300 && cursorX < 500 && cursorY < 455 && cursorY >= 225) {
        if (lv2B4Y == 175) {
          lv2B4Y = 176;
          lv2B4X = 400;
          movesTaken++;
      //    place.play(1);
        } else if (lv2B3Y == 175) {
          if (lv2B4X == 400) {
            clickCountA++;
            blockSelectedA = true;
   //         error.play(1);
          } else {
            lv2B3Y = 176;  // This changes the y-coordinate, so the code in draw formats the blocks in the correct order, depending on size and position
            lv2B3X = 400;   
            movesTaken++;
     //       place.play(1);
          }
        } else if (lv2B2Y == 175) {
          //ENFORCES GAME RULE (can only place smaller DISKS on bigger DISKS)
          if (lv2B4X == 400 || lv2B3X == 400) {
            clickCountA++;
            blockSelectedA = true;
      //      error.play(1);
          } else {
            lv2B2Y = 176; 
            lv2B2X = 400;
            movesTaken++;
        //    place.play(1);
          }
        } else if (lv2B1Y == 175) {
          if (lv2B4X == 400 || lv2B3X == 400 || lv2B2X == 400) {
            clickCountA++;
            blockSelectedA = true;
    //        error.play(1);
          } else {
            lv2B1Y = 176; 
            lv2B1X = 400;
            movesTaken++;
    //        place.play(1);
          }
        }
      }
      //If user selects block from post A, then clicks on post C
      if (cursorX >= 550 && cursorX < 750 && cursorY < 455 && cursorY >= 225) {
        if (lv2B4Y == 175) {
          lv2B4Y = 176;
          lv2B4X = 650;
          movesTaken++;
    //      place.play(1);
        } else if (lv2B3Y == 175) {
          if (lv2B4X == 650) {
            clickCountA++;
            blockSelectedA = true;
    //        error.play(1);
          } else {
            lv2B3Y = 176; 
            lv2B3X = 650;
            movesTaken++;
     //       place.play(1);
          }
        } else if (lv2B2Y == 175) {
          if (lv2B4X == 650 || lv2B3X == 650) {
            clickCountA++;
            blockSelectedA = true;
      //      error.play(1);
          } else {
            lv2B2Y = 176;  
            lv2B2X = 650;
            movesTaken++;
     //       place.play(1);
          }
        } else if (lv2B1Y == 175) {
          if (lv2B4X == 650 || lv2B3X == 650 || lv2B2X == 650 ) {
            clickCountA++;
            blockSelectedA = true;
     //       error.play(1);
          } else {
            lv2B1Y = 176; 
            lv2B1X = 650;
            movesTaken++;
    //        place.play(1);
          }
        }
      }
    } else if (blockSelectedB == true) {
      blockSelectedB = false;
      clickCountB = 0;
      //If user selects block from post B, then clicks on post A
      if (cursorX >= 50 && cursorX < 250 && cursorY < 455 && cursorY >= 225) {
        if (lv2B4Y == 175) {
          lv2B4X = 150;
          lv2B4Y = 176;
          movesTaken++;
   //       place.play(1);
        } else if (lv2B3Y == 175) {
          if (lv2B4X == 150) {
            clickCountB++;
            blockSelectedB = true;
    //        error.play(1);
          } else {
            lv2B3Y = 176; 
            lv2B3X = 150;
            movesTaken++;
    //        place.play(1);
          }
        } else if (lv2B2Y == 175) {
          if (lv2B4X == 150 || lv2B3X == 150) {
            clickCountB++;
            blockSelectedB = true;
     //       error.play(1);
          } else {
            lv2B2Y = 176;  
            lv2B2X = 150;
            movesTaken++;
       //     place.play(1);
          }
        } else if (lv2B1Y == 175) {
          if (lv2B4X == 150 || lv2B3X == 150 || lv2B2X == 150) {

            clickCountB++;
            blockSelectedB = true;
   //         error.play(1);
          } else {
            lv2B1Y = 176; 
            lv2B1X = 150;
            movesTaken++;
    //        place.play(1);
          }
        }
      }
      //If user selects block from post B, then clicks on post C
      if (cursorX >= 550 && cursorX < 750 && cursorY < 455 && cursorY >= 225) {
        if (lv2B4Y == 175) {
          lv2B4Y = 176;
          lv2B4X = 650;
          movesTaken++;
    //      place.play(1);
        } else if (lv2B3Y == 175) {
          if (lv2B4X == 650) {
            clickCountB++;
            blockSelectedB = true;
    //        error.play(1);
          } else {
            lv2B3Y = 176; 
            lv2B3X = 650;
            movesTaken++;
    //        place.play(1);
          }
        } else if (lv2B2Y == 175) {
          if (lv2B4X == 650 || lv2B3X == 650) {
            clickCountB++;
            blockSelectedB = true;
   //         error.play(1);
          } else {
            lv2B2Y = 176; 
            lv2B2X = 650;
            movesTaken++;
   //         place.play(1);
          }
        } else if (lv2B1Y == 175) {
          if (lv2B4X == 650 || lv2B3X == 650 || lv2B2X == 650) {
            clickCountB++;
            blockSelectedB = true;
     //       error.play(1);
          } else {
            lv2B1Y = 176; 
            lv2B1X = 650;
            movesTaken++;
      //      place.play(1);
          }
        }
      }
    } else if (blockSelectedC == true) {
      blockSelectedC = false;
      clickCountC = 0;
      //If user selects block from post C, then clicks on post A
      if (cursorX >= 50 && cursorX < 250 && cursorY < 455 && cursorY >= 225) {  
        if (lv2B4Y == 175) {
          lv2B4Y = 176; 
          lv2B4X = 150;
          movesTaken++;
    //      place.play(1);
        } else if (lv2B3Y == 175) {
          if (lv2B4X == 150) {
            clickCountC++;
            blockSelectedC = true;
   //         error.play(1);
          } else {
            lv2B3Y = 176;  
            lv2B3X = 150;
            movesTaken++;
  //          place.play(1);
          }
        } else if (lv2B2Y == 175) {
          if (lv2B4X == 150 || lv2B3X == 150) {
            clickCountC++;
            blockSelectedC = true;
  //          error.play(1);
          } else {
            lv2B2Y = 176; 
            lv2B2X = 150;
            movesTaken++;
    //        place.play(1);
          }
        } else if (lv2B1Y == 175) {
          if (lv2B4X == 150 || lv2B3X == 150 || lv2B2X == 150 ) {
            clickCountC++;
            blockSelectedC = true;
     //       error.play(1);
          } else {
            lv2B1Y = 176;  
            lv2B1X = 150;
            movesTaken++;
    //        place.play(1);
          }
        }
      }
      //If user selects block from post C, then clicks on post B
      if (cursorX >= 300 && cursorX < 500 && cursorY < 455 && cursorY >= 225) {
        if (lv2B4Y == 175) {
          lv2B4Y = 176;  
          lv2B4X = 400;
          movesTaken++;
    //      place.play(1);
        } else if (lv2B3Y == 175) {
          if (lv2B4X == 400) {
            clickCountC++;
            blockSelectedC = true;
   //         error.play(1);
          } else {
            lv2B3Y = 176;  
            lv2B3X = 400;
            movesTaken++;
      //      place.play(1);
          }
        } else if (lv2B2Y == 175) {
          if (lv2B4X == 400 || lv2B3X == 400) {
            clickCountC++;
            blockSelectedC = true;
     //       error.play(1);
          } else {
            lv2B2Y = 176;  
            lv2B2X = 400;
            movesTaken++;
    //        place.play(1);
          }
        } else if (lv2B1Y == 175) {
          if (lv2B4X == 400 ||lv2B3X == 400 || lv2B2X == 400 ) {
            clickCountC++;
            blockSelectedC = true;
       //     error.play(1);
          } else {
            lv2B1Y = 176; 
            lv2B1X = 400;
            movesTaken++;
       //     place.play(1);
          }
        }
      }
    }
  }
}
