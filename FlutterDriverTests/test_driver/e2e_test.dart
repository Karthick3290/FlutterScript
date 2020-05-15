import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:screenshots/screenshots.dart';
import 'package:image/image.dart';
import 'package:diff_image/diff_image.dart';
import 'package:ozzie/ozzie.dart';

void main() {

  group('Smoke Tests', () {
    final enterItemNameLabel = find.byValueKey('labeltext');
    final enterItemName = find.byValueKey('textfield');
    FlutterDriver driver;
    Ozzie ozzie;

    setUpAll(() async {
      new Directory('/tmp/screenshots11').create();
      driver = await FlutterDriver.connect();
      ozzie = Ozzie.initWith(driver, groupName: 'E2E1');
    });

    takeScreenshot(FlutterDriver driver, String path) async {
      final List<int> pixels = await driver.screenshot();
      final File file = new File(path);
      await file.writeAsBytes(pixels);
      print(path);
    }

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
        ozzie.generateHtmlReport();
      }
    });

    test('Scenario 2',() async{
      await ozzie.takeScreenshot('Scenario2');
    });
    test('Scenario 1', () async {
      final config = Config();
      expect(await driver.getText(enterItemNameLabel), "Enter Item Name");
      expect(await driver.getText(enterItemName), "Add Item");
      await screenshot(driver, config, 'varuna');
      await ozzie.takeScreenshot('Scenario1');
      final timeline = await driver.traceAction(() async {
        expect(await driver.getText(enterItemNameLabel), 'Enter Item Name');
      });
      final summary = new TimelineSummary.summarize(timeline);
      //summary.writeSummaryToFile('scrolling_summary', pretty: true);
      summary.writeTimelineToFile('scrolling_timeline', pretty: true);
    });
  });
}
