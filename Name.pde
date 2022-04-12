// names for bloops
// more than one way to skin a cat
// William Robb

class Name { 
  
  // so don't duplicate.
  // maybe hash off clock if this eats too much memory
  StringDict listOnames;
  
  Name() {
    listOnames = new StringDict();
  }
  // helper generate random letter - nested functions in java look gnarley
  String randomLetter() {
    return str(char(int(random(65,91))));
  }
  String getName() {
    String name;
    // or build a markov chain based name generator ...
    while (true) { //omg this looks dangerous
      name = randomLetter() + randomLetter() + randomLetter() + randomLetter();
      if (listOnames.hasKey(name) != true) {
        listOnames.set(name,"Yep");
        return name;
      }
    }
  }
}
