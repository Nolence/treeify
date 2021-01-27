import 'package:flutter_test/flutter_test.dart';
import 'package:treeify/treeify.dart';

void main() {
  group('Trees that show values', () {
    test('Creates a single level tree', () {
      final testMap = {
        'oranges': null,
        'apples': true,
      };
      final tree = Treeify.asTree(testMap, false);
      final expectedTree = '''├─ oranges
└─ apples
''';

      expect(tree, expectedTree);
    });

    test('Creates a multi level tree', () {
      final testMap = {
        'oranges': {
          'mandarin': {
            'clementine': null,
            'tangarine': 'tasty',
          }
        },
        'apples': {
          'gala': null,
          'pink lady': null,
        }
      };
      final tree = Treeify.asTree(testMap, false);
      final expectedTree = '''├─ oranges
│  └─ mandarin
│     ├─ clementine
│     └─ tangarine
└─ apples
   ├─ gala
   └─ pink lady
''';
      expect(tree, expectedTree);
    });
  });

  group('Trees that do not show values', () {
    test('Creates a single level tree', () {
      final testMap = {
        'oranges': null,
        'apples': true,
      };
      final tree = Treeify.asTree(testMap, true);
      final expectedTree = '''├─ oranges: null
└─ apples: true
''';

      expect(tree, expectedTree);
    });

    test('Creates a multi level tree', () {
      final testMap = {
        'oranges': {
          'mandarin': {
            'clementine': null,
            'tangarine': 'tasty',
          }
        },
        'apples': {
          'gala': null,
          'pink lady': null,
        }
      };
      final tree = Treeify.asTree(testMap, true);
      final expectedTree = '''├─ oranges
│  └─ mandarin
│     ├─ clementine: null
│     └─ tangarine: tasty
└─ apples
   ├─ gala: null
   └─ pink lady: null
''';

      expect(tree, expectedTree);
    });
  });
}
