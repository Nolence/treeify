library treeify;

/// This class should not be extended. Instead, call the static funtions
/// [asLines] or [asTree] to get the result of tree.
abstract class Treeify {
  /// This will give you access to each lines in the callback function
  /// [lineCallback]. This can be useful to modify the output in any form.
  static void asLines(
    Map obj,
    Function(String line) lineCallback, [
    bool showValues = true,
  ]) {
    _growBranch('.', obj, false, const [], showValues, lineCallback);
  }

  /// Outputs the entire tree, returning it as a string with line breaks.
  static String asTree(Map obj, bool showValues) {
    var tree = '';

    _growBranch('.', obj, false, const [], showValues, (line) {
      tree += line + '\n';
    });

    return tree;
  }
}

String _makePrefix(String? key, bool last) {
  var str = last ? '└' : '├';

  if (key != null) {
    str += '─ ';
  } else {
    str += '──┐';
  }

  return str;
}

class _Node {
  final Object? root;

  final bool last;

  const _Node(this.root, this.last);
}

void _growBranch(
  String key,
  Object? root,
  bool last,
  List<_Node> lastNodes,
  bool showValues,
  Function(String line) callback,
) {
  var line = '';
  var index = 0;
  bool lastKey;
  var circular = false;
  final lastStatesCopy = [...lastNodes, _Node(root, last)];

  if (lastNodes.isNotEmpty) {
    // based on the "was last element" states of whatever we're nested within,
    // we need to append either blankness or a branch to our line
    for (var i = 0; i < lastNodes.length; i++) {
      final lastNode = lastNodes[i];

      if (i > 0) {
        line += (lastNode.last ? ' ' : '│') + '  ';
      }
      if (!circular && lastNode.root == root) {
        circular = true;
      }
    }

    lastNodes.forEach((lastNode) {});

    // the prefix varies based on whether the key contains something to show and
    // whether we're dealing with the last element in this collection
    line += _makePrefix(key, last) + key;

    // append values and the circular reference indicator
    if (showValues) {
      if (root is! Map) {
        line += ': ' + root.toString();
      }
    }

    if (circular) {
      line += ' (circular ref.)';
    }

    callback(line);
  }

  // can we descend into the next item?
  if (!circular && root is Map) {
    // var keys = filterKeys(root);
    root.entries.forEach((entry) {
      // the last key is always printed with a different prefix, so we'll need to know if we have it
      lastKey = ++index == root.entries.length;

      // hold your breath for recursive action
      _growBranch(
        entry.key,
        entry.value,
        lastKey,
        lastStatesCopy,
        showValues,
        callback,
      );
    });
  }
}
