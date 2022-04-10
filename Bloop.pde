// Evolution EcoSystem
// Daniel Shiffman <http://www.shiffman.net>

// Creature class

class Bloop {
  PVector location; // Location
  DNA dna;          // DNA
  float health;     // Life timer
  float xoff;       // For perlin noise
  float yoff;
  // DNA will determine size and maxspeed
  float r;
  float maxspeed;
  
  // we are going to add a couple of properties here
  String name;    // each of these is its own little being
  Integer age;    // in ticks
  String parent;  // see notes, this is going to go away ... maybe
  
  // Create a "bloop" creature
  Bloop(PVector l, DNA dna_, String parent_) {
    location = l.get();
    health = 200;
    age = 0;
    xoff = random(1000);
    yoff = random(1000);
    
    // From genotype to phenotype.  No transcription errors or environmental effects.
    dna = dna_;
    // Gene 0 determines maxspeed and r
    // The bigger the bloop, the slower it is
    maxspeed = map(dna.genes[0], 0, 1, 15, 0);
    r = map(dna.genes[0], 0, 1, 0, 50);
    
    // record parent
    parent = parent_;
    
    // oh and we get to pick a name, what do you think dear?
    name = namer.getName();
    
  }

  void run() {
    update();
    borders();
    display();
  }

  // A bloop can find food and eat it
  void eat(Food f) {
    ArrayList<PVector> food = f.getFood();
    // Are we touching any food objects?
    for (int i = food.size()-1; i >= 0; i--) {
      PVector foodLocation = food.get(i);
      float d = PVector.dist(location, foodLocation);
      // If we are, juice up our strength!
      if (d < r/2) {
        health += 100; 
        food.remove(i);
      }
    }
  }

  // At any moment there is a teeny, tiny chance a bloop will reproduce
  Bloop reproduce() {
    // asexual reproduction
    if (random(1) < 0.0005) {
      // Child is exact copy of single parent
      DNA childDNA = dna.copy();
      // Child DNA can mutate
      childDNA.mutate(0.01);
      
      return new Bloop(location, childDNA, name); //name is not this created bloops name, but its parent.
    } 
    else {
      return null;
    }
  }

  // Method to update location
  void update() {
    // Simple movement based on perlin noise
    float vx = map(noise(xoff),0,1,-maxspeed,maxspeed);
    float vy = map(noise(yoff),0,1,-maxspeed,maxspeed);
    PVector velocity = new PVector(vx,vy);
    xoff += 0.01;
    yoff += 0.01;

    location.add(velocity);
    // Death always looming
    health -= 0.2;
    // Hear the clock tick
    age += 1;
  }

  // Wraparound
  void borders() {
    //0 is bottom bound, so ... just check r
    //could write '0-r' ... for clarity
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }

  // Method to display
  void display() {
    ellipseMode(CENTER);
    stroke(0,health);
    fill(0, health);
    ellipse(location.x, location.y, r, r);
  }

  // Death
  boolean dead() {
    if (health < 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }
}
