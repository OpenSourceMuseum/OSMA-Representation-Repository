
PFont font;
String message = null;
int cycle = 0;

float r,g,b;

int margin = 200;

void setup(){
  size(1280,800);
  
  font = createFont("Baskerville" , 60);  
  
  getMessage();
  
  r = 0;
  g = 0;
  b = 0;
  
}


void draw(){
  
  background(r,g,b);
  
  cycle = cycle + 1;
  if(cycle==60){
    getMessage();
    cycle = 0;
  }
  

  textAlign(CENTER,CENTER);
  fill(255,255,255);
  noStroke();
  textFont(font,60);
  try{
    //text(message, width/2 , height/2);
    text(message , margin , margin , width-2*margin , height - 2*margin);
  }catch(Exception e){}
}

void getMessage(){
  JSONArray data = loadJSONArray("http://localhost:8888/HE/ecosystem/getRandomMessage.php?w=abbandono");
  if( data!=null && data.size()==1){
    JSONObject element = data.getJSONObject(0);
    message = element.getString("txt");
    
      r = random(0,255);
      g = random(0,255);
      b = random(0,255);
   
   
    
  } 
}
