# hint 3

```erl
-type trail :: {left,  any(), tree(), trail()}
             | {right, any(), tree(), trail()}
             | top.
```

or

```erl
-type trail :: list({left, any(), tree()} | {right, any(), tree()}).
```

The immediate parent should be the easiest to access.

A zipper record contains the nodes value, left branch right branch and the
trail.
