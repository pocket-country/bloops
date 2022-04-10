// Evolution EcoSystem
// Daniel Shiffman <http://www.shiffman.net>
// The Nature of Code

// A World of creatures that eat food
// The more they eat, the longer they survive
// The longer they survive, the more likely they are to reproduce
// The bigger they are, the easier it is to land on food
// The bigger they are, the slower they are to find food
// When the creatures die, food is left behind


// 4/8 - try using table() for data output

World world;
Name namer;  // generate little snowflak names

void setup() {
  size(800, 200);  //display size
  
  // name geneerator init
  namer = new Name();
  println(namer.getName());
  
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
