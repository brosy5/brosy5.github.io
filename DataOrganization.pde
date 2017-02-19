//Initialize boolean that tells draw function to run block of code to redraw picture
boolean somethingChanged = false;
int countData = 0;

public float [] getLineWidth(color back){
  float [] lineWidth = new float [values.length];
  for(int i = 0; i < values.length; i++){      
     //If color matches, set 
     if(back == color(i*4 + num_Categories())){
        lineWidth[i] = 4;
     }else{
        lineWidth[i] = 1;
     }
   }
   return(lineWidth);
}

void drawBackbuffer(int col, boolean Swap, color back, int colClicked, float[][] lagYCoord){
  
}

void addData(int col, boolean Swap, color back, int colClicked, float[][] lagYCoord){
  //Find and set max value, min value
  float maxValue = maxValue();
  float minValue = minValue();
  float bottomOfBar = 70 + (height - 120);
  float range = 255/ num_Categories();
  float[] lineWidth1 = getLineWidth(back);
   fill(0);
   textFont(f,12);
   textAlign(CENTER);
   
   //Change color based on most recently clicked column
   stroke(66, (range/3 + 1) * colClicked,(range/2 +1) * colClicked);
   //Write Text for each column
   if(Swap == true && switchDim == true){
       text(maxValue, ((width/num_Categories())*col) + (width/(num_Categories())/2 - 40), 130);
       text(minValue, ((width/num_Categories())*col) + (width/(num_Categories())/2 - 40), 70 + (height - 120) - 3);
     }else if(Swap == false && switchDim == true){
       text(minValue, ((width/num_Categories())*col) + (width/(num_Categories())/2 - 40), 130);
       text(maxValue, ((width/num_Categories())*col) + (width/(num_Categories())/2 - 40), 70 + (height - 120) - 3);
    }
    for(int i = 0; i < values.length; i++){ 
       //If not swapped, draw points and lines
        if(Swap == true && switchDim == true){
         fill(i);
         //Draw a point, scaled to the height of the column
         ellipse(((width/num_Categories())*col) + (width/(num_Categories())/2 + 10), bottomOfBar -((bottomOfBar - 130 - 10)/(maxValue-minValue)) * values[i] - 5,5,5);
            if(col > 0){
                //Order Colors based on column
                 strokeWeight(lineWidth1[i]);
                //Draw line if not the first column
                 line(((width/num_Categories())*(col-1) + (width/(num_Categories())/2 + 10)), lagYCoord[col - 1][i], ((width/num_Categories())*col) + (width/(num_Categories())/2 + 10), bottomOfBar -((bottomOfBar - 130 - 10)/(maxValue-minValue)) * values[i] - 5);
                //Repeat on backbuffer
                backbuffer.beginDraw();
                backbuffer.strokeWeight(2);
                backbuffer.stroke(i*4 + num_Categories());
                backbuffer.line(((width/num_Categories())*(col-1) + (width/(num_Categories())/2 + 10)), lagYCoord [col - 1][i], ((width/num_Categories())*col) + (width/(num_Categories())/2 + 10), ((bottomOfBar - 130 - 10)/(maxValue-minValue)) * values[i] + 130);
                backbuffer.endDraw();  
             }
               //Store lagged Y coordinate for that datapoint
               lagYCoord[col][i]= bottomOfBar - ((bottomOfBar - 130 - 10)/(maxValue-minValue)) * values[i] - 5;
               countData = countData + 1;
               if(countData >= (num_Categories()*values.length)*num_Categories()){
                 switchDim = false;
                 countData = 0;
               }
       }else if(Swap == false && switchDim == true){
         fill(i);
         //Draw a point, scaled to the height of the column
         ellipse(((width/num_Categories())*col) + (width/(num_Categories())/2 + 10), ((bottomOfBar - 130 - 10)/(maxValue-minValue)) * values[i] + 130,5,5);
         if(col > 0){
             //See if cursor is over line to make larger 
             strokeWeight(lineWidth1[i]);
             //Draw line if not the first column
             line(((width/num_Categories())*(col-1) + (width/(num_Categories())/2 + 10)), lagYCoord [col - 1][i], ((width/num_Categories())*col) + (width/(num_Categories())/2 + 10), ((bottomOfBar - 130 - 10)/(maxValue-minValue)) * values[i] + 130);
             //Repeat on backbuffer
             backbuffer.beginDraw();
             backbuffer.stroke(i*4 + num_Categories());
             backbuffer.strokeWeight(2);
             backbuffer.line(((width/num_Categories())*(col-1) + (width/(num_Categories())/2 + 10)), lagYCoord [col - 1][i], ((width/num_Categories())*col) + (width/(num_Categories())/2 + 10), ((bottomOfBar - 130 - 10)/(maxValue-minValue)) * values[i] + 130);
             backbuffer.endDraw();
           }
           lagYCoord[col][i] = ((bottomOfBar - 130 - 10)/(maxValue-minValue)) * values[i] + 130; 
           countData = countData + 1;
           if(countData >= (num_Categories()*values.length)*num_Categories()){
               switchDim = false;
               countData = 0;
           }
       }
   }
}