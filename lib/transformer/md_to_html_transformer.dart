/* This code was adapted from  https://github.com/jathak/md_to_html
 * which is licensed under BSD-3.  Thanks, jathak.
 */
import 'package:barback/barback.dart';
import 'package:markdown/markdown.dart';
import 'package:mustache_no_mirror/mustache.dart' as Mustache;

import 'dart:async';
import 'dart:convert' show JSON;

final _tipPattern = new RegExp(r'^[ ]{0,3}>[ ]*?\*\*tip\*\*[ ]?(.*)$');
final _alertPattern = new RegExp(r'^[ ]{0,3}>[ ]*\*\*alert\*\*[ ]?(.*)$');


abstract class CalloutSyntax extends BlockquoteSyntax {
  String get calloutClass;

  const CalloutSyntax();

  Node parse(BlockParser parser) {
    var childLines = parseChildLines(parser);
    List<Node> children = new InlineParser(childLines.join(" "), parser.document).parse();
    return new Element('p', children)
      ..attributes['class'] = "callout ${calloutClass}";
  }

}
// Parses alerts: `>**tip** item`.
class TipSyntax extends CalloutSyntax {

  const TipSyntax();

  RegExp get pattern => _tipPattern;

  String get calloutClass => "tip";

}

// Parses alerts: `>**alert** item`.
class AlertSyntax extends CalloutSyntax {
  const AlertSyntax();

  RegExp get pattern => _alertPattern;

  String get calloutClass => "alert";

}


class MarkdownTransformer extends Transformer {

  final BarbackSettings _settings;

  MarkdownTransformer.asPlugin(this._settings);

  String get allowedExtensions => ".md .markdown .mdown";

  Future apply(Transform transform) {
    List<InlineSyntax> inlineSyntaxes = [
      //new InlineHtmlSyntax()
    ];

    List<BlockSyntax> blockSyntaxes = [ new TipSyntax(), new AlertSyntax(), new TableSyntax() ];

    return transform.primaryInput.readAsString().then((content) {
      var id = transform.primaryInput.id.changeExtension(".html");

      String templatePath = _settings.configuration['template'];
      return new Asset.fromPath(id, templatePath).readAsString().then((template) {
        var t = Mustache.parse(template, lenient: true);
        var tags = {};
        if (content.startsWith("{")) {
          int jsonEnd = 1;
          int depth = 1;
          while (depth > 0) {
            if (content[jsonEnd] == "{") {
              depth++;
            } else if (content[jsonEnd] == "}") {
              depth--;
            }
            jsonEnd++;
          }
          tags = JSON.decode(content.substring(0, jsonEnd));
          content = content.substring(jsonEnd);
        }
        tags['content'] = markdownToHtml(content, inlineSyntaxes: inlineSyntaxes, blockSyntaxes: blockSyntaxes);
        String output = t.renderString(tags, lenient: true, htmlEscapeValues: false);
        transform.addOutput(new Asset.fromString(id, output));
      });
    });
  }
}
