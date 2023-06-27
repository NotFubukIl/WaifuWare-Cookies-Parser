import 'dart:io';
import 'dart:convert';
void main(List<String> args) {
  print("Input Cookies File: ");
  String? file = stdin.readLineSync(encoding: utf8);
  main2(file);
}

void main2(args) {
  if (args.isEmpty) {
    throw ArgumentError('Please, Input a file.');
  }

  var file = File(args);
  if (!file.existsSync()) {
    throw ArgumentError('File not found: ${args}');
  }

  var fileContent = file.readAsStringSync().replaceAll('────────────────────────────────────────', '').split('\n');

  var objects = <Map<String, String>>[];
  var obj = <String, String>{};

  var parsedCookies = '';

  fileContent.forEach((line) {
    if (line.isEmpty) {
      return;
    }
    if (line.startsWith('Browser')) {
      obj = {};
      objects.add(obj);
    }
    var parts = line.split(': ');
    obj[parts[0]] = parts[1] + (parts.length > 2 ? ': ' + parts[2] : '');
  });

  objects.forEach((r) {
    parsedCookies += '${r['Host']}\tTRUE\t/\tFALSE\t2597573456\t${r['Name']}\t${r['Value']}\n';
  });

  var parsedCookiesFile = File('./parsed-cookies.txt');
  parsedCookiesFile.writeAsStringSync(parsedCookies);

  print('Parsed: ${parsedCookiesFile.path}');
  stdin.readLineSync(encoding: utf8);
}