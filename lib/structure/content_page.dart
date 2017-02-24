import 'package:in_tallinn_content/structure/page.dart';
import 'package:in_tallinn_content/structure/page_section.dart';

class ContentPage extends Page {
  List<PageSection> sections = <PageSection>[];

  ContentPage(String title, {String id: null, String name: null})
      : super(title, id: id, name: name) {
    includeInNav = true;
  }
}
