class GrandFather {
  String name;
  GrandFather(this.name);
}

GrandFather grandFather = GrandFather("Ahmed");

class Father extends GrandFather {
  Father(super.name);
}

class Son {}
