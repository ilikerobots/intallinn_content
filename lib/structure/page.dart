class Page {
  String title;
  String id;
  String name;
  bool includeInNav;
//  dynamic component;
  Map<String, String> data = <String, String>{};

  Page(this.title, {this.id, this.name}) {
    if (id == null) {
      id = _slugify(title);
    }
    if (name == null) {
      name = _camelize(title);
    }
  }

  static _slugify(String val) =>
      val?.replaceAll("_", "-")?.replaceAll(" ", "-")?.toLowerCase();

  static _camelize(String val) =>
      val?.replaceAll("_", "-")
          ?.replaceAll(" ", "-")
          ?.toLowerCase()
          ?.split('-')
          ?.map((String e) => e[0].toUpperCase() + e.substring(1))
          ?.join('');
}
