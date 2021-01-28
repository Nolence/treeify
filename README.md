# treeify

This is a port of the Javascript library [treeify](https://github.com/notatestuser/treeify). Treeify converts maps into nice, visible depth-indented trees for console printing. The structure generated is similar to what you get by running the tree command on Unixy platforms.

```
{
    oranges: {
        'mandarin': {                                          ├─ oranges
            clementine: null,                                  │  └─ mandarin
            tangerine: 'so cheap and juicy!'        -=>        │     ├─ clementine
        }                                                      │     └─ tangerine: so cheap and juicy!
    },                                                         └─ apples
    apples: {                                                     ├─ gala
        'gala': null,                                             └─ pink lady
        'pink lady': null
    }
}
```

## Getting Started

Include the package:

```
  treeify: <latest_version>
```

Use the library by calling the static members on the exposed Tree class:

```dart
final testMap = {
  'oranges': null,
  'apples': true,
};
final tree = Treeify.asTree(testMap, false);
```

## Differences
I removed the `hideFunctions` from the tree as most dart `Map`s are usually not constructed with functions as keys.
