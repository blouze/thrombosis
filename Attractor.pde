class Attractor {
  PVector pos;
  boolean active = true;

  Attractor(PVector pos) {
    this.pos = pos;
  }

  void show() {
    noStroke();
    fill(#16161d);
    circle(this.pos.x, this.pos.y, 6);
  }
}
