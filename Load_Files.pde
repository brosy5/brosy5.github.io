String path = "Documents/Processing/Assign3_Parallel_Coordinates/CHC_data.csv";
String xName;
String yName;
String[] names;
float[] values;
float arrayLength = 0;

public float[] loadValues(int col){
  //Load in data, splice first line for labels
  String[] lines = loadStrings(path);
  String[] firstLine = split(lines[0],",");
  xName = firstLine[0];
  yName = firstLine[1];
  
  //for categorical and numerical data
  String[] names = new String [lines.length-1];
  float[] values = new float [lines.length - 1];
  
  //Separate names and values
  for(int i =1; i < lines.length; i++){
    String[] row = split(lines[i],",");
    names[i-1] = row[0];
    values[i-1] = (int) parseFloat(row[col+1]);
  }
  //Set ArrayLength, which is also number of categories
  arrayLength = values.length;
  //Return Values
  return(values);  
}


public String[] loadNames(){
  //Load in data, splice first line for labels
  String[] lines = loadStrings(path);
  String[] firstLine = split(lines[0],",");
  xName = firstLine[0];
  yName = firstLine[1];
  
  //for categorical and numerical data
  String[] names = new String [lines.length-1];
  
  //Separate names and values
  for(int i =1; i < lines.length; i++){
    String[] row = split(lines[i],",");
    names[i-1] = row[0];
  }
  //Return Names of categories
  return(names);  
}

public int num_Datapoints(){
//Find the dimensions of the Datatable
    String[] lines = loadStrings(path); //load the file as a list of strings
    int num_Datapoints = lines.length - 1; //gets the number of rows in file
    return num_Datapoints;
}

public int num_Categories(){
//Find the dimensions of the Datatable
    String[] lines = loadStrings(path);
    String[] firstLine = split(lines[0], ','); //get headings/dimensions
    
    int num_Categories = firstLine.length - 1; //gets the number of columns in file
    return num_Categories;
}


public String[] catNames(){
      String[] lines = loadStrings(path); //load the file as a list of strings
      String[] firstLine = split(lines[0], ','); //get headings/dimensions
      return(firstLine);
}

public float maxValue(){
  float maxValue = 0;
  for(int i = 0; i < values.length; i++){
    if(maxValue < values[i]){
       maxValue = values[i];
    }
  }
  return(maxValue);
}

public float minValue(){
  float minValue = values[0];
  for(int i = 0; i < values.length; i++){
      if(minValue > values[i]){
         minValue = values[i];
      }
  }
  return(minValue);
}