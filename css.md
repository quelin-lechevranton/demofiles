# Cacading Style Sheets

`selector { property: value; }`

## Selectors

| selector | |
| - | - |
| `*` | all document |
| `t` | all tags `<t>` |
| `.cn` | all tags with `class="cn"` |
| `t.cn` | all tags `<t class="cn">` |
| `#id` | all tags with `id="id" |
| `t>g` | all tags `<g>` directly inside a tag `<t>` |
| `t g` | all tags `<g>` inside a tag `<t>` |
| `t+g` | first tag `<g>` following a tag `<t>` |
| `t~g` | all tags `<g>` following a tag `<t>` |

The most specific selector takes precedence.

Some properties are inherited by child elementes.

## Colors

`rgb`
`rgba`
`hex`
147 predefined names
`hsl`
`hsla`

## Fonts

| | |
| - | - |
| generic | `serif` `sans-serif` `monospace` `cursive?` `fantasy?` |
| weigth | `ligth` `medium` `bold` `black` |
| style | `normal` `italic` `oblique` |
| stretch | `condensed` `regular` `extended` |

| | |
| - | - |
| `pt` | 1/72 of an inch |
| `px` | a "physical" pixel is 3/4 of a point |
| `in` | one inch is 2.54 cm |
| `ppi` | pixel per inch (displaying) |
| `dpi` | dot per inch (printing) |

| TeX | | |
| - | - | - |
| `pt` | point | 1/72.26 of an inch |
| `bp` | big point | 1/72 of an inch |
| `pc` | pica | 12 points |
| `ex` | | height of an `x` |
| `em` | | width of an `M` |
