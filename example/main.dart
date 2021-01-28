import 'package:treeify/treeify.dart';

void main() {
  final folderStructure = {
    '/': {
      'Users': {
        'foo': {
          'Desktop': null,
          'Documents': null,
        },
        'Shared': null,
      },
      'System': {
        'Library': null,
        'Volumes': null,
      },
    }
  };

  final tree = Treeify.asTree(folderStructure, false);

  print(tree);
}
