JSONArray data;
float multiplierX , multiplierY;
float minX,minY,maxX,maxY;

PImage map;

float t,tInc;

void setup(){
  // configure stuff
  size(1280,800);  
  
  t = 0;
  tInc = 0.02;
  
  map = loadImage("map3.jpg");
  
  multiplierX = 1;
  multiplierY = 1;
  
  /*
  minX = 999;
  minY = 999;
  maxX = -999;
  maxY = -999;
  */
  
  minX = 7.6121093750000455;
  minY = 45.02009126413054;
  maxX = 7.7878906250000455;
  maxY = 45.113204817143846;
  
  
  
  data = loadJSONArray("http://localhost:8888/HE/ecosystem/getFirstOSMAVizData.php?w=turin");

  /*
  for(int i=0; i<data.size(); i=i+1 )
  {    
    JSONObject point = data.getJSONObject( i );
    if(point.getFloat("lng")<minX){  minX = point.getFloat("lng"); }
    if(point.getFloat("lng")>maxX){  maxX = point.getFloat("lng"); }
    if(point.getFloat("lat")<minY){  minY = point.getFloat("lat"); }
    if(point.getFloat("lat")>maxY){  maxY = point.getFloat("lat"); }
  }
  */


}

void draw()
{
  background(0,0,0);
  
  t = t + tInc;
  
  image(map,0,0,width,height);
  
  for(int i=0; i<data.size(); i=i+1 )
  {    
    JSONObject point = data.getJSONObject( i ); 
    fill(0,0,0);
    noStroke();
    
    float xx = width*(point.getFloat("lng")-minX)/(maxX-minX);
    float yy = height - height*(point.getFloat("lat")-minY)/(maxY-minY);
    float r = 2*max(3,point.getFloat("c"));// + 0.2*max(3,point.getFloat("c"))*sin(t+((float)i)/20);
    
    //ellipse( multiplierX * xx   ,   multiplierY * yy ,   r , r );
    
    pushMatrix();
    
    translate(multiplierX * xx - r/2, multiplierY * yy - r/2);
    rotate(PI/4);
    
    rect( 0   ,   0 ,   r , r );
    
    
    popMatrix();
  }
  //noLoop();
  
  if(t>2){
    data = loadJSONArray("http://localhost:8888/HE/ecosystem/getFirstOSMAVizData.php?w=turin");
    t = 0;
  }
  
}


void keyReleased(){

  if(key==' '){
    data = loadJSONArray("http://localhost:8888/HE/ecosystem/getFirstOSMAVizData.php?w=turin");
    //println("loaded");
    loop();
  }
}
