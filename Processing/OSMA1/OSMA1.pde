JSONArray data;
float multiplierX , multiplierY;
float minX,minY,maxX,maxY;

void setup(){
  // configure stuff
  size(800,800);  
  
  multiplierX = 1;
  multiplierY = 1;
  
  minX = 999;
  minY = 999;
  maxX = -999;
  maxY = -999;
  
  
  
  data = loadJSONArray("http://localhost:8888/HE/ecosystem/getFirstOSMAVizData.php?w=turin");

  for(int i=0; i<data.size(); i=i+1 )
  {    
    JSONObject point = data.getJSONObject( i );
    if(point.getFloat("lng")<minX){  minX = point.getFloat("lng"); }
    if(point.getFloat("lng")>maxX){  maxX = point.getFloat("lng"); }
    if(point.getFloat("lat")<minY){  minY = point.getFloat("lat"); }
    if(point.getFloat("lat")>maxY){  maxY = point.getFloat("lat"); }
  }


}

void draw()
{
  background(0,0,0);
  
  for(int i=0; i<data.size(); i=i+1 )
  {    
    JSONObject point = data.getJSONObject( i ); 
    fill(255,0,0);
    noStroke();
    
    float xx = width*(point.getFloat("lng")-minX)/(maxX-minX);
    float yy = height - height*(point.getFloat("lat")-minY)/(maxY-minY);
    
    ellipse( multiplierX * xx   ,   multiplierY * yy ,   point.getFloat("c") , point.getFloat("c") );
  }
  noLoop();
}


void keyReleased(){

  if(key==' '){
    data = loadJSONArray("http://localhost:8888/HE/ecosystem/getFirstOSMAVizData.php?w=turin");
    println("loaded");
    loop();
  }
}
