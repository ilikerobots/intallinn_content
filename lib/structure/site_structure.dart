import 'package:in_tallinn_content/structure/page.dart';
import 'package:in_tallinn_content/structure/page_section.dart';
import 'package:in_tallinn_content/structure/content_page.dart';

class SiteStructure {
  static final List<Page> pages = <Page>[
    new ContentPage("Basics")
      ..sections.add(new PageSection("history", "History", icon: "restore", icon_data: 0xe8b3 ))
      ..sections.add(new PageSection("people", "People", icon: "people", icon_data: 0xe7fb))
      ..sections.add(new PageSection("climate", "Climate", icon: "wb_sunny", icon_data: 0xe430))
      ..sections.add(new PageSection("language", "Language", icon: "mode_comment", icon_data: 0xe253))
      ..sections.add(new PageSection("currency", "Currency", icon: "euro_symbol", icon_data: 0xe926))
      ..sections.add(new PageSection("safety", "Safety", icon: "traffic", icon_data: 0xe565))
      ..sections.add(new PageSection("power", "Power", icon: "power", icon_data: 0xe63c))
      ..sections.add(new PageSection("internet", "Internet/WiFi", icon: "wifi", icon_data: 0xe63e)),
    new ContentPage("Transport")
      ..sections.add(new PageSection("airport", "Airport", icon: "airplanemode_active", icon_data: 0xe195))
      ..sections.add(new PageSection("seaport", "Sea Port", icon: "directions_boat", icon_data: 0xe532))
      ..sections.add(new PageSection("auto-rental", "Auto Rental", icon: "directions_car", icon_data: 0xe531))
      ..sections.add(new PageSection("public-transport", "Public Transport", icon: "directions_transit", icon_data: 0xe535))
      ..sections.add(new PageSection("taxis", "Taxis", icon: "local_taxi", icon_data: 0xe559))
      ..sections.add(new PageSection("bikes", "Bikes", icon: "directions_bike", icon_data: 0xe52f)),
    new ContentPage("Sightseeing")
      ..sections.add(new PageSection("tourist-office", "Tourist Office", icon: "info_outline", icon_data: 0xe88f))
      ..sections.add(new PageSection("parks", "Parks", icon: "nature_people", icon_data: 0xe407))
      ..sections.add(new PageSection("neighborhoods", "Neighborhoods", icon: "zoom_out_map", icon_data: 0xe56b))
      ..sections.add(new PageSection("museums", "Museums ", icon: "local_activity", icon_data: 0xe53f))
      ..sections.add(new PageSection("walking", "Walking Tours ", icon: "directions_walk", icon_data: 0xe536)
        ..photoIdString = "walking-tours")
      ..sections.add(new PageSection("seasonal-events", "Seasonal Events", icon: "event", icon_data: 0xe878))
      ..sections.add(new PageSection("tallinn-card", "Tallinn Card", icon: "card_travel", icon_data: 0xe8f8)),
    new ContentPage("Dining and Nightlife")
      ..sections.add(new PageSection("cuisine", "Cuisine", icon: "local_dining", icon_data: 0xe556))
      ..sections.add(new PageSection("dining", "Dining", icon: "restaurant", icon_data: 0xe56c))
      ..sections.add(new PageSection("nightlife", "Nightlife", icon: "local_bar", icon_data: 0xe540)),
//    new ContentPage("Accommodation"),
    new ContentPage("Elsewhere in Estonia")
     ..sections.add(new PageSection("destinations-outside-tallinn", "Destinations", icon: "map", icon_data: 0xe55b))
      ..sections.add(new PageSection("getting-away", "Getting Away", icon: "explore", icon_data: 0xe87a)),
    new Page("Walking Tours", name: "walking-tours") 
      ..includeInNav = false,
    new Page("About", name: "about")..includeInNav = false,
    new Page("Ask Us", name: "ask-us")..includeInNav = true,
  ];

  SiteStructure();

  static Page getPage(String id) => pages.firstWhere((Page i) => i.id == id);
  static PageSection getSection(String id) {
    PageSection section = null;
    for (Page p in pages) {
        if (p is ContentPage) {
          section = p.sections.firstWhere((PageSection sec) => sec.id == id, orElse: () => null);
          if (section != null) {
            return section;
          }
        }
    }
    return section;

  }


}
