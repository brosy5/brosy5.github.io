//Ben Rosenkranz
//Assignment 3, Parallel Coordinates
//The hovering worked on my computer, but was just very sporadic


//Set up second Canvas
PGraphics backbuffer;
boolean [] swap1; 

void setup(){
  size(1000,400);
  //to make resizeable
  surface.setResizable(true);
 //set font
  f = createFont("Calibri",10,true);
  backbuffer = createGraphics(width, height);
  num_Categories();
  swap1 = new boolean [num_Categories()];
}
//Global Variables
PFont f;


//Method to draw lines
void drawAxis(){
     stroke(0,0,0);
   //Draw Coordinate
    for(int i = 0; i < num_Categories(); i++){
      fill(255,255,255);
      strokeWeight(1);
      rect(((width/num_Categories())*i) + (width/(num_Categories())/2), 120, 20, height - 170);
      color c = color(0,0,i);
      backbuffer.beginDraw();
      backbuffer.fill(c);
      backbuffer.rect(((width/num_Categories())*i) + (width/(num_Categories())/2), 120, 20, height - 170);
      backbuffer.endDraw();
    }
}

//boolean values to swap
int colClicked = 0;
int timer = 0;
int columnColored = 1;
boolean switchDim = false;
boolean wasHighlighted = false;
void mousePressed(color back, boolean[] swap1){
  //Get the color of the backbuffer to see if its the same color
  for(int i = 0; i < num_Categories(); i++){
      if(back == color(0,0,i) && mousePressed == true && swap1[i] == false && timer <= 0){
            colClicked = i;
            swap1[i] = true;
            //To prevent multi-clicks           
            timer = 2;
            //Switch Order of Coloring
            columnColored = i + 1;
            //Tell the program that something changed
            switchDim = true;
            somethingChanged = true;
      }else if(back == color(0,0,i) && mousePressed == true && swap1[i] == true && timer <= 0){
            colClicked = i;
            swap1[i] = false;
            //To prevent multi-clicks
            timer = 2;
            //Switch Order of Coloring
            columnColored = i + 1;
            //Tell the program that something changed -- for use in addData() method
            switchDim = true;
            //Tell the program that something changed -- for use in draw() method
            somethingChanged = true;
      }
      //Check if hovering over a line
      if(back == color(i*4 + num_Categories())){
           somethingChanged = true;
           switchDim = true;
           wasHighlighted = true;
           println("HOVERING");
      }
      //Make sure to print graph again if you unhighlight a line
      if(wasHighlighted == true && back != color(i*4 + num_Categories())){
          somethingChanged = true;
          wasHighlighted = false;
          println(wasHighlighted);
      }
  } 
  timer = timer - 1;
}

void drawLabels(){
    String [] catNames = catNames();
    for(int i = 0; i < num_Categories(); i++){
        fill(0);
        textFont(f,16);
        //Center and print category labels 
        textAlign(CENTER);
        text(catNames[i + 1], ((width/num_Categories())*i) + (width/(num_Categories())/2) + 10, 100);
    }
 }
 
int categories = 0;
int datapoints = 0;
boolean firstRun  = true;
int countLoop = 0;
void draw(){
  categories = num_Categories();
  datapoints = num_Datapoints();
  color back = 0;
  float [][] lagYCoord = new float [categories][datapoints];
  //Only reprint if something has changed because my computer was struggling with the load
  if(somethingChanged == true || firstRun == true){
    println("Count Loop:" + countLoop);
    countLoop++;
    background(255,255,255);
    drawAxis();  
    for(int i = 0; i < num_Categories();i++){
      switchDim = true;
      values = loadValues(i);
      getLineWidth(back);
      back = backbuffer.get(mouseX, mouseY);
      addData(i, swap1[i], back, colClicked, lagYCoord);
    }
    names = loadNames();
    drawLabels();
    firstRun = false;
    somethingChanged = false;
  }
    back = backbuffer.get(mouseX, mouseY);
    mousePressed(back, swap1);
}