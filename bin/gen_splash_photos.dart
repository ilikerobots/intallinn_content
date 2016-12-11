import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:in_tallinn_content/license/license.dart';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

const YAML_PATH = "assets/image/splash_photo.yaml";
const INPATH = "assets/image/";
const OUTPATH = "web/content/images/splash/";
const CONVERT_SCRIPT = "convert";
const FINAL_GEOMETRY = "2200>";
const QUALITY = 70;

main() async {
  String inPath = path.absolute(INPATH);
  String outPath = path.absolute(OUTPATH);

  Directory outDir = new Directory(outPath);
  if (!outDir.existsSync()) {
    await outDir.create(recursive: true);
  }

  String contents = await new File(YAML_PATH).readAsString();
  var yaml = loadYaml(contents);

  Directory tmpDir = await Directory.systemTemp.createTemp('content_section_photo');

  await Future.forEach(yaml['photos'], (Map f) async {
    String iFile = path.join(inPath, f['in_filename']);
    String oFile = path.join(outPath, f['out_filename']);
    String tmpBase = path.basenameWithoutExtension(iFile);
    print("Converting $INPATH${f['in_filename']} to $OUTPATH${f['out_filename']}");
    await exitOnFail(Process.run(CONVERT_SCRIPT, ['-quality', '100', iFile, "${tmpDir.path}/$tmpBase.cache.jpg"])); // convert to jpg if not already
    await exitOnFail(Process.run(CONVERT_SCRIPT, ['-thumbnail', FINAL_GEOMETRY, '-quality', '$QUALITY', "${tmpDir.path}/$tmpBase.cache.jpg", oFile])); 
    
    writeLicenseFile(f['license'], "$oFile.license");
    
  });
  tmpDir.delete(recursive: true);
}

Future<Null> writeLicenseFile(Map<String, String> licenseAttribs, String fName) async {
  License l = new LicenseFactory().getLicenseFromString(licenseAttribs['type']);
  Map<String,dynamic> out = {}..addAll(licenseAttribs);
  out['attribution_text'] =  l.getAttribution(licenseAttribs['author']);
  out['attribution_required'] =  l.attributionRequired;
  await new File(fName).create()..writeAsString(JSON.encode(out));
}

Future<Null> exitOnFail(Future<ProcessResult> resF) async {
  ProcessResult res = await resF;
  if (res.exitCode != 0) {
    stderr.writeln(res.stderr);
    exit(res.exitCode);
  }
  return;
}

