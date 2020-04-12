class Node {
  PVector pos;
  PVector dir;
  Node parent;
  float thickness = 0.2;

  Node(Node parent, PVector pos, PVector dir) {
    this.parent = parent;
    this.pos = pos;
    this.dir = dir;
  }

  Node spawn(PVector dir) {
    return new Node(this, this.pos.copy().add(dir), dir);
  }

  void show() {
    if (this.parent != null) {
      colorMode(HSB);
      stroke(255, 192, 128, map(thickness, 0.2, 8, 128, 255));
      strokeWeight(thickness);
      noFill();
      line(this.parent.pos.x, this.parent.pos.y, this.pos.x, this.pos.y);
    }
  }
}
