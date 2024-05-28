# Cacading Style Sheets

`selector { property: value; }`

`@import url("file.css");`

`@font-face { ... }`

## Selectors

| selector | |
| - | - |
| `*` | all document |
| `t` | all tags `<t>` |
| `.cn` | all tags with `class="cn"` |
| `t.cn` | all tags `<t class="cn">` |
| `#id` | tag with `id="id"` |
| `t>g` | all tags `<g>` directly inside a tag `<t>` |
| `t g` | all tags `<g>` inside a tag `<t>` |
| `t+g` | first tag `<g>` following a tag `<t>` |
| `t~g` | all tags `<g>` following a tag `<t>` |

| pseudo-classes| |
| - | - |
| `t:first-letter` | first letter in `<t>` |
| `t:first-line` | first line in `<t>` |
| `t:link` | unvisited links in `<t>` |
| `t:visited` | visited links in `<t>` |
| `t:hoover` | |
| `t:active` | |
| `t:focus` | |

| attribute selector | |
| - | - |
| `t[a]` | all tags `<t>` with an attribute `a` |
| `t[a="a"]` | all tags `<t>` with an attribute `a` whose value is `"a"` |
| `t[a~="a"]` | all tags `<t>` with an attribute `a` with in `"a"` in the list of its values |
| `t[a^="a"]` | all tags `<t>` with an attribute `a` whose value starts with `"a"` |
| `t[a*="a"]` | all tags `<t>` with an attribute `a` whose value contains `"a"` |
| `t[a$="a"]` | all tags `<t>` with an attribute `a` whose value ends with `"a"` |

The most specific selector takes precedence.

Some properties are inherited by child elementes.

## Fonts

A typeface is a group of fonts

| | font |
| - | - |
| generic | `serif` `sans-serif` `monospace` `cursive?` `fantasy?` |
| weigth | `ligth` `medium` `bold` `black` |
| style | `normal` `italic` `oblique` |
| stretch | `condensed` `regular` `extended` |

| CSS | |
| - | - |
| `pt` | 1/72 of an inch |
| `px` | a browser pixel is 3/4 of a point, not necessarly a physical pixel |
| `in` | one inch is 2.54 cm |

| TeX | | |
| - | - | - |
| `pt` | point | 1/72.26 of an inch |
| `bp` | big point | 1/72 of an inch |
| `pc` | pica | 12 points |
| `ex` | | height of an `x` |
| `em` | | width of an `M` |

## Layout

to center an element with respect to its parent: `margin: auto`

| attribute | description |
| - | - |
| __display__ | p.317 |
| `block` | |
| `inline` | |
| `none` | |
| __position__ | [position](https://developer.mozilla.org/en-US/docs/Web/CSS/position) |
| __float__ | p.370 |
| | |
| __clear__ | p.372 |
| | |
