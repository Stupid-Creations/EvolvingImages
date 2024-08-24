PImage tester;
float[] pixies;

ArrayList<image> images = new ArrayList<image>();

void setup() {
  size(400, 400);

  tester = loadImage("Untitled.jpeg");
  tester.resize(400, 400);

  for (int i = 0; i < 100; i++) {
    images.add(new image(100));
    images.get(i).setScore(tester);
  }
}

class Triangle {
  PVector a;
  PVector b;
  PVector c;
  Triangle(int x1, int x2, int x3, int y1, int y2, int y3) {
    a = new PVector(x1, y1);
    b = new PVector(x2, y2);
    c = new PVector(x3, y3);
  }
  void draw_t() {
    line(a.x, a.y, b.x, b.y);
    line(b.x, b.y, c.x, c.y);
    line(c.x, c.y, a.x, a.y);
  }
}

class image {
  int nt;
  float score;
  ArrayList<Triangle>image = new ArrayList<Triangle>();
  image(int n) {
    nt = n;
    for (int i = 0; i < n; i++) {
      image.add(new Triangle(int(random(0, 400)), int(random(0, 400)), int(random(0, 400)), int(random(0, 400)), int(random(0, 400)), int(random(0, 400))));
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
    if (chooser > 0.85) {
      image.remove(floor(random(0, image.size())));
      image.add(new Triangle(int(random(0, 400)), int(random(0, 400)), int(random(0, 400)), int(random(0, 400)), int(random(0, 400)), int(random(0, 400))));
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
  void setScore(PImage target) {
    pixies = new float[target.pixels.length];
    for (int i = 0; i < pixies.length; i++) {
      pixies[i] = brightness(target.pixels[i]);
    }
    float[]pix = get_pixels();
    score = leastSquares(pix, pixies);
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
  images.sort((a,b) -> {return int(a.score-b.score);});
  println("Epoch:" + counter + " Max Score:" + images.get(0).score);
  images.get(0).show();
  for(int i = 50; i < 100; i++){
    images.set(i,images.get(0).reproduce(images.get(floor(random(50))),images.get(floor(random(50)))));
  }
  for(int i = 0; i < 100; i ++){
    images.get(i).setScore(tester);
  }
  counter++;
}
