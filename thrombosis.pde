ArrayList<Attractor> attractors = new ArrayList<Attractor>();
ArrayList<Node> nodes = new ArrayList<Node>();

int attract_dist = 40;
int kill_dist = 6;
float seg_len = 4;
float max_thickness = 6;
float incr_thickness = pow(10, -4);
boolean done = false;


void setup() {
  size(840, 840);

  int step = 16;
  for (int j = 0; j <= height; j += step) {
    for (int i = 0; i <= width; i += step) {
      if (random(1) > 0.2) {
        PVector pos = new PVector(i + random(-step / 2, step / 2), j + random(-step / 2, step / 2));
        attractors.add(new Attractor(pos));
      }
    }
  }

  Node node = new Node(null, new PVector(width * 2 / 3, height / 3), new PVector(0, 0));
  nodes.add(node);
}


void mouseClicked() {
  nodes.clear();
  Node node = new Node(null, new PVector(mouseX, mouseY), new PVector(0, 0));
  nodes.add(node);

  for (Attractor attractor : attractors) {
    attractor.active = true;
  }

  done = false;
}


void draw() {
  if (done) return;
  background(255);

  int numActive = 0;
  for (Attractor attractor : attractors) {
    if (!attractor.active) continue;
    //attractor.show();
    numActive++;

    Node closest = null;
    float min_dist = max(width, height);
    for (Node node : nodes) {
      float d = attractor.pos.dist(node.pos);
      if (d < min_dist) {
        closest = node;
        min_dist = d;
      }
    }

    if (closest != null && min_dist < attract_dist) {
      PVector dir = attractor.pos.copy().sub(closest.pos).normalize().mult(seg_len);
      nodes.add(closest.spawn(dir));

      if (min_dist < kill_dist) {
        attractor.active = false;
      }
    }
  }

  for (Node node : nodes) {
    Node currentNode = node;
    while (currentNode.parent != null) {
      if (currentNode.parent.thickness < max_thickness) {
        currentNode.parent.thickness += incr_thickness;
      }
      currentNode = currentNode.parent;
    }
    node.show();
  }

  if (numActive == 0) {
    done = true;
  }
}
