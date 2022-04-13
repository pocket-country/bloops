// Evolution EcoSystem
// Daniel Shiffman <http://www.shiffman.net>
// The Nature of Code

// Examples code from ch9 modified by William Robb April 2022

// A World of creatures that eat food
// The more they eat, the longer they survive
// The longer they survive, the more likely they are to reproduce
// The bigger they are, the easier it is to land on food
// The bigger they are, the slower they are to find food
// When the creatures die, food is left behind


// 4/8 - try using table() for data output
// DATA FILE FOR CREATURES STARTS AT TICK 2!
World world;
Name namer;         // generate little snowflak names
Metrics datastore;

void setup() {
  size(800, 200);  //display size
  
  // name geneerator init
  namer = new Name();
  
  datastore = new Metrics();
  
  // World starts with 20 creatures
  // and 20 pieces of food
  world = new World(20);    
  smooth();  //?
}

void draw() {
  background(255);
  
  world.run();
}

// emergency excape hatch - doesn't save data
// TODO save data!
void mousePressed() {
  exit(); 
}
