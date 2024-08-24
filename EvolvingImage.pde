PImage tester;

void setup(){
  size(400,400);
  tester = loadImage("test_graph.png");
  tester.resize(400,400);

}

class Triangle{
  PVector a; 
  PVector b;
  PVector c;
   Triangle(int x1,int x2, int x3, int y1, int y2, int y3){
    a = new PVector(x1,y1);
    b = new PVector(x2,y2);
    c = new PVector(x3,y3);
  }
  void draw_t(){
    line(a.x,a.y,b.x,b.y);
    line(b.x,b.y,c.x,c.y);
    line(c.x,c.y,a.x,a.y);
  }
}
Triangle a = new Triangle(1,2,3,4,5,5);
class image{
  int nt;
  ArrayList<Triangle>image = new ArrayList<Triangle>();
  image(int n){
    nt = n;
    for(int i = 0; i < n;i++){
      image.add(new Triangle(int(random(0,400)),int(random(0,400)),int(random(0,400)),int(random(0,400)),int(random(0,400)),int(random(0,400))));
    }
  }
  void show(){
    for(int i = 0; i<image.size();i++){
      image.get(i).draw_t();
    }
  }
  void mutate(){
    float chooser = random(1);
    if(chooser > 0.6){
      image.remove(floor(random(0,image.size())));
      image.add(new Triangle(int(random(0,400)),int(random(0,400)),int(random(0,400)),int(random(0,400)),int(random(0,400)),int(random(0,400))));
    }
  }
}

float leastSquares(color[]a,color[]b){
 float error = 0;
  for(int i = 0; i<a.length;i++){
    error += (brightness(a[i])-brightness(b[i]))*(brightness(a[i])-brightness(b[i]));
  }
  return error;
}

color[] colors = new color[160000];
color[] colors2 = new color[160000];

image i = new image(10);

void draw(){
  background(255);
  
  i.show();
  loadPixels();
  colors = pixels;
  
  delay(10000);
  
  //image(tester,0,0);
  
  loadPixels();
  for(int i = 0; i < pixels.length;i++){
    pixels[i] = color(brightness(pixels[i]));
  }
  
  updatePixels();
  
  loadPixels();
  colors2 = pixels;
  println(leastSquares(colors,colors2));
}
