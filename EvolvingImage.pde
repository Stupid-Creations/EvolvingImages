void setup(){
  size(400,400);
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
}

image i = new image(100);

void draw(){
  i.show();
}
