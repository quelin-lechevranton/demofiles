# HyperText Markup Language

## Meta tags

| `html` | |
| - | - |
| `<html>` | all html code |
| `<head>` | metadata |
| `<body>` | all shown elements |
| `<title>` | inside `<head>` |

## Structural markup

| `html` | `md` | description |
| - | - | - |
| `<h1>` | `#` | main heading |
| `<h6>` | 6 `#`'s | lowest subheading |
| `<p>` | | paragraph |
| `<b>` | `**` | bold |
| `<i>` | `*` | italic |
| `<s>` | | striked |
| `<u>` | | underlined |
| `<sup>` | | superscript |
| `<sub>` | | subscript |
| `<br/>` | `LF` | linebreak |
| `<hr/>` | `---` | horizontal rule |

## Semantic markup

| `html` | description |
| - | - |
| `<strong>` | strong |
| `<em>` | emphasis |
| `<blockquote>` | block quote |
| `<q>` | quote |
| `<abbr>` | abbreviation |
| `<cite>` | citation |
| `<dfn>` | defining instance |
| `<address>` | post address |
| `<ins>` | inserted |
| `<del>` | deleted |

## Lists

| `html` | description |
| - | - |
| `<ol>` | order list |
| `<ul>` | unorder list |
| `<li>` | list item |
| `<dl>` | definition list |
| `<dt>` | definition term |
| `<dd>` | definition |

## Links

| `html` | tags | description |
| - | - | - |
| `<a>` | `href` | URL, mail address with `mailto:` prefix |
| | `target` | with `_blank` open in a new tab |

### Uniform Resource Locator

#### Absolute URLs

- domain name: `www.site.org`

- path to file: `/path/to`

- default page: `index.html`

- `<a href="https://www.site.org/path/to"> link text</a>` returns `siterootfolder/path/to/index.html`

- `<a href="../file.html">` returns `siterootfolder/path/index.html`

- `<a href="#head">` returns to `<h1 id="head">` in the same page

```html
<a href="mailto:cremepatissiere@proton.me">mail me!</a>
```

## Objects

| `html` | tags | description |
| - | - | - |
| `<img>` | `src` | source file |
| | `alt` | text description in case of display problem |
| | `title` | title seen on hover |
| | `height` | height in pixels |
| | `width` | width in pixels |
