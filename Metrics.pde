// Wire up the world to record everything
// Metrics generats data so we can analyse genetics and evolution using R
//
// William Robb 2022

class Metrics {
  
  Table wrldData;        // table for world level data
  Table bugData;         // table for creature level data
  Table grelData;        // table for genological relationship data
  Table gverData;        // table for genological entity data
  
  
  Metrics() {
    
    wrldData = new Table();
    wrldData.addColumn("tick");
    wrldData.addColumn("bcount");
    wrldData.addColumn("fcount");
    
    bugData = new Table();
    bugData.addColumn("tick");
    bugData.addColumn("name");
    bugData.addColumn("age");
    bugData.addColumn("health");
    
    grelData = new Table();
    grelData.addColumn("Parent");
    grelData.addColumn("Child");
    
    gverData = new Table();
    gverData.addColumn("Name");
    gverData.addColumn("Born");
    gverData.addColumn("Died");

  }
  
  void gatherWorldData(int tk, ArrayList<Bloop> bz, Food fd) {
    
    TableRow wRow = wrldData.addRow();
    // state of the world
    wRow.setInt("tick",tk);
    wRow.setInt("bcount", bz.size());
    wRow.setInt("fcount", fd.countFood());
  }  
  
  void gatherCreatureData(int tk, ArrayList<Bloop> bz) {
    Bloop b;
    
    for ( int i = 0; i < bz.size(); i++ ) {
       b = bz.get(i);
       TableRow bRow = bugData.addRow();
       //state of the cute little guy at time tk       
       bRow.setInt("tick",tk);
       bRow.setString("name", b.name);
       bRow.setInt("age", b.age);
       bRow.setFloat("health", b.health);
    }
  }
  
  void recordBirth(int tk, String mumName, String kidName) {
    
    TableRow bGene = grelData.addRow();
    bGene.setString("Parent", mumName);
    bGene.setString("Child", kidName);
    
    TableRow bCert = gverData.addRow();
    bCert.setString("Name", kidName);
    bCert.setInt("Born", tk); 
  }
  
  void recordDeath(int tk, String bName) {
    // find the deceased 
    println(tk,bName);
    TableRow bCert = gverData.findRow(bName,"name");
    bCert.setInt("Died", tk );
  }  
  
  void writeData() {
    saveTable(wrldData,"world.csv");
    saveTable(bugData,"creature.csv");
    saveTable(grelData,"geneedges.csv");
    saveTable(gverData,"geneverts.csv");
  }
}
