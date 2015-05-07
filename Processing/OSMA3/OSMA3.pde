
import peasy.*;

PImage map;

JSONArray data;
float multiplierX , multiplierZ;
float minX,minZ,maxX,maxZ;

float totalDimension;

PeasyCam cam;

Point[] mapPoints = null;

Point[][] grid;
float cellSize = 30;
int numberOfCells = 40;
float initialY = -400;
float deltaTexture = -200;

int cycle = 0;

void setup(){

  size(1280,800,P3D);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(4000);
  
  map = loadImage("map4.jpg");
  
  totalDimension = cellSize * numberOfCells;
  
  multiplierX = 1;
  multiplierZ = 1;
  
  minX = 7.6121093750000455;
  minZ = 45.02009126413054;
  maxX = 7.7878906250000455;
  maxZ = 45.113204817143846;
  
  grid = new Point[numberOfCells][numberOfCells];
  
  for(int i = 0; i<numberOfCells; i++){
    for(int j = 0; j<numberOfCells; j++){
      grid[i][j] = new Point();
      grid[i][j].r = 255;
      grid[i][j].g = 255;
      grid[i][j].b = 255;
      grid[i][j].x = i*cellSize;
      grid[i][j].z = j*cellSize;
      grid[i][j].y = initialY;
      grid[i][j].dx = 0;
      grid[i][j].dz = 0;
      grid[i][j].dy = 0;
      grid[i][j].c = 5;
    }
  }
  
  getMapPoints();
  
  smooth();
}


void draw(){
  
  background(0,0,0);
  
  //cycle++;
  if(cycle==500){
    getMapPoints();
    cycle = 0;
  }
  
  /*
  try{
    for(int i=0; i<mapPoints.length; i++){
      mapPoints[i].draw();
    }
  }catch(Exception e){}
  */
  
  /*
  for(int i = 0; i<numberOfCells; i++){
    for(int j = 0; j<numberOfCells; j++){
      grid[i][j].draw();
    }
  }
  */
  
  noStroke();
  textureMode(NORMAL);
  beginShape();
  texture(map);
  vertex(0,initialY-deltaTexture,0   ,0,0);
  vertex(totalDimension,initialY-deltaTexture,0  ,1,0);
  vertex(totalDimension,initialY-deltaTexture,totalDimension  ,1,1 );
  vertex(0,initialY-deltaTexture,totalDimension  ,0,1 );
  vertex(0,initialY-deltaTexture,0    ,0,0);
  endShape(CLOSE);
  
  
  noFill();
  stroke(0,255,0);
  for(int i = 0; i<numberOfCells-1; i++){
    beginShape();
    for(int j = 0; j<numberOfCells-1; j++){
      vertex(grid[i][j].x+grid[i][j].dx ,  grid[i][j].y+grid[i][j].dy ,  grid[i][j].z+grid[i][j].dz );
    }
    endShape();
  }
  
  for(int j = 0; j<numberOfCells-1; j++){
    beginShape();
    for(int i = 0; i<numberOfCells-1; i++){
      vertex(grid[i][j].x+grid[i][j].dx ,  grid[i][j].y+grid[i][j].dy ,  grid[i][j].z+grid[i][j].dz );
    }
    endShape();
  }

}


void getMapPoints(){
  data = loadJSONArray("http://localhost:8888/HE/ecosystem/getFirstOSMAVizData.php?w=turin");

  mapPoints = new Point[data.size()];
  
  for(int j = 0; j<numberOfCells; j++){
    for(int k = 0; k<numberOfCells; k++){
      grid[j][k].dy = 0;
    }
  }

  for(int i=0; i<data.size(); i=i+1 )
  {    
    JSONObject point = data.getJSONObject( i ); 
    fill(255,0,0);
    noStroke();
    float xx = totalDimension*(point.getFloat("lng")-minX)/(maxX-minX);
    float zz = totalDimension - totalDimension*(point.getFloat("lat")-minZ)/(maxZ-minZ);
    float r = min(40,2*max(3,point.getFloat("c")));
    
    mapPoints[i] = new Point();
    mapPoints[i].r = 255;
    mapPoints[i].g = 0;
    mapPoints[i].b = 0;
    mapPoints[i].x = xx;
    mapPoints[i].y = 0;
    mapPoints[i].z = zz;
    mapPoints[i].dx = 0;
    mapPoints[i].dy = 0;
    mapPoints[i].dz = 0;
    mapPoints[i].c = r;
    
    for(int j = 0; j<numberOfCells; j++){
      for(int k = 0; k<numberOfCells; k++){
        PVector v = new PVector(grid[j][k].x,grid[j][k].z);
        v.sub( new PVector(xx,zz));
        float m = v.mag();
        if(m<30){
          grid[j][k].dy = grid[j][k].dy + 25*r/m;
        }
      }
    }
    
  }

}

