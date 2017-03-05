import 'package:in_tallinn_content/photo/photo_id.dart';

class PageSection implements Comparable<PageSection>{
  String id;
  String title;
  String color;
  String icon;
  int icon_data;
  PhotoId photoId;

  PageSection(this.id, this.title, {this.icon: "link", this.icon_data: 0xe157}) {
    photoIdString = id;
  }

  set photoIdString(String s) {
    photoId = new PhotoId(s, type: PhotoCategory.section);
  }

  @override
  int compareTo(PageSection other) => id.toLowerCase().compareTo(other.id.toLowerCase());
}