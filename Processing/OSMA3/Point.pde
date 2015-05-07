class Point{

  float x,y,z;
  float dx,dy,dz;
  float r,g,b;
  float c;

  void draw(){
    
    pushMatrix();
    translate( x+dx  , y+dy , z+dz );
    fill(r,g,b);
    noStroke();
    sphere(c);
    popMatrix();
    
  }

}
