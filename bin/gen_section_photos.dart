import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:in_tallinn_content/license/license.dart';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

const YAML_PATH = "assets/image/section_photo.yaml";
const INPATH = "assets/image/";
const OUTPATH = "web/content/images/section/";
const CONVERT_SCRIPT = "convert";
const FINAL_GEOMETRY = "1024^";
const tmpSubdirName = 'inTallinn_section_img';
const QUALITY = 42;


main() async {
  String inPath = path.absolute(INPATH);
  String outPath = path.absolute(OUTPATH);

  Directory outDir = new Directory(outPath);
  if (!outDir.existsSync()) {
    await outDir.create(recursive: true);
  }

  String contents = await new File(YAML_PATH).readAsString();
  var yaml = loadYaml(contents);

  Directory tmpDir = await Directory.systemTemp.createTemp(tmpSubdirName);

  await Future.forEach(yaml['photos'], (Map f) async {
    print("Converting $INPATH${f['in_filename']} " +
        "to $OUTPATH${f['out_filename']}");

    String iFile = path.join(inPath, f['in_filename']);
    String oFile = path.join(outPath, f['out_filename']);
    String tmpBaseName = path.basenameWithoutExtension(iFile);
    String tmpFileName = "${tmpDir.path}/$tmpBaseName.cache.jpg";

    new File(iFile).copySync(tmpFileName); //copy to tmp location

    await doImageConvert(CONVERT_SCRIPT, ['-quality', '100'], tmpFileName);
    await doImageConvert(CONVERT_SCRIPT,
        ['-thumbnail', FINAL_GEOMETRY, '-quality', '$QUALITY'], tmpFileName);

    new File(tmpFileName).copySync(oFile); //copy to final location
    writeLicenseFile(f['license'], "$oFile.license");
  });
  tmpDir.delete(recursive: true);
}


Future<Null> doImageConvert(final String cmd, final List<String> args,
    final String filename) async {
  List<String> thisArgs = new List.from(args)
    ..add(filename)..add(filename);
  await exitOnFail(Process.run(cmd, thisArgs));
  return;
}

Future<Null> writeLicenseFile(Map<String, String> licenseAttribs,
    String fName) async {
  License l = new LicenseFactory().getLicenseFromString(licenseAttribs['type']);
  Map<String, dynamic> out = {}..addAll(licenseAttribs);
  out['attribution_text'] = l.getAttribution(licenseAttribs['author']);
  out['attribution_required'] = l.attributionRequired;
  await new File(fName).create()
    ..writeAsString(JSON.encode(out));
}

Future<Null> exitOnFail(Future<ProcessResult> resF) async {
  ProcessResult res = await resF;
  if (res.exitCode != 0) {
    stderr.writeln(res.stderr);
    exit(res.exitCode);
  }
  return;
}
