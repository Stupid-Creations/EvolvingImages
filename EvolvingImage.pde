PImage tester;
float[] pixies;

ArrayList<image> images = new ArrayList<image>();
float threshold = 0.85;

void setup() {
  size(400, 400);

  tester = loadImage("Untitled.jpeg");
  tester.resize(400, 400);

  for (int i = 0; i < 25; i++) {
    images.add(new image(50));
    images.get(i).setScore(tester);
  }
}

class Triangle {
  PVector a;
  PVector b;
  PVector c;
  float br;
  float t;
  Triangle(int x1, int x2, int x3, int y1, int y2, int y3, float brightness, float transparency) {
    a = new PVector(x1, y1);
    b = new PVector(x2, y2);
    c = new PVector(x3, y3);
    br = brightness;
    t = transparency;
  }
  void draw_t() {
    fill(br, t);
    triangle(a.x, a.y, b.x, b.y, c.x, c.y);
  }
}

class image {
  int nt;
  float score;
  ArrayList<Triangle>image = new ArrayList<Triangle>();
  image(int n) {
    nt = n;
    for (int i = 0; i < n; i++) {
      image.add(new Triangle(int(random(0, 400)), int(random(0, 400)), int(random(0, 400)), int(random(0, 400)), int(random(0, 400)), int(random(0, 400)), int(random(0, 255)), int(random(255))));
    }
  }
  void show() {
    background(255);
    for (int i = 0; i<image.size(); i++) {
      image.get(i).draw_t();
    }
  }
  void mutate() {
    float chooser = random(1);
    if (chooser > threshold) {
      image.remove(floor(random(0, image.size())));
      image.add(new Triangle(int(random(0, 400)), int(random(0, 400)), int(random(0, 400)), int(random(0, 400)), int(random(0, 400)), int(random(0, 400)), int(random(0, 255)), int(random(255))));
    }
  }
  float[] get_pixels() {
    show();
    loadPixels();
    float[] bright = new float[160000];
    for (int i = 0; i < pixels.length; i++) {
      bright[i] = brightness(pixels[i]);
    }
    return bright;
  }
  image reproduce(image a, image b) {
    float otherc = random(1);
    if(otherc > 0.5){
      return otherrepro(a,b);
    }else{
    image child = new image(a.nt);
    for (int i = 0; i < b.image.size(); i++) {
      float chooser = random(1);
      if (chooser > 0.7) {
        child.image.set(i, b.image.get(i));
      } else {
        child.image.set(i, a.image.get(i));
      }
      child.mutate();
    }
    return child;
    }
  }
  void setScore(PImage target) {
    pixies = new float[target.pixels.length];
    for (int i = 0; i < pixies.length; i++) {
      pixies[i] = brightness(target.pixels[i]);
    }
    float[]pix = get_pixels();
    score = leastSquares(pix, pixies);
  }
  image otherrepro(image a, image b) {
    image child = new image(50);
    for (int i = 0; i < a.image.size(); i++) {
      child.image.get(i).a.x = (a.image.get(i).a.x+b.image.get(i).a.x)/2;
      child.image.get(i).a.x = (a.image.get(i).b.x+b.image.get(i).b.x)/2;
      child.image.get(i).a.x = (a.image.get(i).c.x+b.image.get(i).c.x)/2;
      child.image.get(i).a.x = (a.image.get(i).a.y+b.image.get(i).a.y)/2;
      child.image.get(i).a.x = (a.image.get(i).b.y+b.image.get(i).b.y)/2;
      child.image.get(i).a.x = (a.image.get(i).c.y+b.image.get(i).c.y)/2;
      child.image.get(i).br =  (a.image.get(i).br+b.image.get(i).br)/2;
      child.image.get(i).t =  (a.image.get(i).t+b.image.get(i).t)/2;
    }
    child.mutate();
    return child;
  }
}

float leastSquares(float[]a, float[]b) {
  float error = 0;
  for (int i = 0; i<a.length; i++) {
    error += (a[i]-b[i])*(a[i]-b[i]);
  }
  return error;
}

int counter = 0;

void draw() {
  background(255);
  images.sort((a, b) -> {
    return int(a.score-b.score);
  }
  );
  println("Epoch: " + counter + " Max Score: " + images.get(0).score);
  images.get(0).show();
  for (int i = 13; i < 25; i++) {
    images.set(i, images.get(0).reproduce(images.get(floor(random(25))), images.get(floor(random(25)))));
  }
  for (int i = 0; i < 25; i ++) {
    images.get(i).setScore(tester);
  }
  counter++;
}
