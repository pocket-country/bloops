// Evolution EcoSystem
// Daniel Shiffman <http://www.shiffman.net>
// Spring 2007, The Nature of Code
// Mod wrobb 2022

// The World we live in
// Has bloops and food

class World {

  ArrayList<Bloop> bloops;    // An arraylist for all the creatures
  Food food;

  // for metrics need a concept of time.  Could use frame?
  // using 'tick' from NetLogo
  int tick;
  int decaTick;
  
  // Constructor
  World(int num) {
    
    // big bang at time = 0
    tick = 1;
    decaTick = 0;  // don't have to log every iteration ...

    // Start with initial food and creatures
    food = new Food(num);
    
    // generate a population in our world
    bloops = new ArrayList<Bloop>();
    for (int i = 0; i < num; i++) {
      PVector l = new PVector(random(width),random(height));
      DNA dna = new DNA();
      
      bloops.add(new Bloop(l,dna,"a"+str(100+i)));  //only orig names start lower case and have digits
      // next line didn't work why?
      // datastore.recordBirth(tick, bloops[i].parent, bloops[i].name);
      Bloop b = bloops.get(i);
      datastore.recordBirth(tick, b.parent, b.name ); 
    }
  }  //end constructor
    
  // Make a new creature
  // used on mouse click to create a new creaturee
  // commented this out to make parent work, 
  // how to figure parent for a mouse click?
  // also attached something else to onClick.
  // itching to refactor a general birth meethod to use in init and below
  // void born(float x, float y) {
  //   PVector l = new PVector(x,y);
  //   DNA dna = new DNA();
  //   bloops.add(new Bloop(l,dna));
  // }

  // Run the world - Note there is an implicit loop here
  void run() {
    // update time
    tick += 1;
    if ( tick % 60 == 0 ) { 
      println( tick );
      decaTick += 1;
    }
    // gather data;
    datastore.gatherWorldData(tick, bloops, food);
    datastore.gatherCreatureData(tick, bloops);
    
    // Deal with food
    food.run();
    
    // Cycle through the ArrayList backwards b/c we are deleting
    for (int i = bloops.size()-1; i >= 0; i--) {      
      // All bloops run and eat
      Bloop b = bloops.get(i);
      b.run();
      b.eat(food);
      // If it's dead, kill it and make food
      if (b.dead()) {
        datastore.recordDeath(tick, b.name);
        bloops.remove(i);
        food.add(b.location);
      }
      // Perhaps this bloop would like to make a baby?
      Bloop child = b.reproduce();
      if (child != null) { 
          bloops.add(child);
          datastore.recordBirth( tick, b.name, child.name );
       }
    }
      
    // Limit runs to xx,xxx iterations for development purposes.
    // this has to do with needing to flush and close log
    // Alternate mechanism would include a keypress or
    // ultimatly, figuring out how to build an 'on exit' function
    // (the documeentation for this latter is not clear ... write an exit() function calling super.exit()?)
    if ( tick == 6000 ) {
      datastore.writeData();
      exit();
    }
  }
}
