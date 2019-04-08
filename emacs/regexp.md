### '\' nonspecial characters - when interactive
* for brakets - `\(\)` `\{\}` - to be regexp part
* but not for [] - no '\' to be regexp part

### to insert newline into regexp
* `C-q C-j`


# examples:

* `[0-9]\{3\}` - replace three digits

* `^[ ^I]*\+` - remove pluses

* `C-q C-<Press TAB>` - for a tab

* `^[ ^I]*[0-9]+[ ^Inewline ]` remove numbers

* `  id\([ ;]\)` -> `name\1`

* `\[\([0-9]+\)\]` -> `.at(\1)`

* `\(row\[[0-9]\]\)` -> `int(\1)`

