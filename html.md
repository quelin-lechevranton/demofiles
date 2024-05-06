# HyperText Markup Language

## Meta tags

| tag | description |
| - | - |
| `<html>` | all html code |
| `<head>` | text usually displayed in the tab element |
| `<body>` | all shown elements |
| `<title>` | inside `<head>` |

`<!DOCTYPE html>`

`<?xml version="1.0" ?>`

## Structural markup

| `html` | `md` | description |
| - | - | - |
| `<h1>` | `#` | main heading |
| `<h6>` | 6 `#`'s | lowest subheading |
| `<p>` | | paragraph |
| `<b>` | `__` | bold |
| `<i>` | `*` | italic |
| `<s>` | | striked |
| `<u>` | | underlined |
| `<sup>` | | superscript |
| `<sub>` | | subscript |
| `<br/>` | | linebreak |
| `<hr/>` | `---` | horizontal rule |

## Semantic markup

| tag | description |
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

| tag | description |
| - | - |
| `<ol>` | order list |
| `<ul>` | unorder list |
| `<li>` | list item |
| `<dl>` | definition list |
| `<dt>` | definition term |
| `<dd>` | definition |

## Links

| tag | attribute | description |
| - | - | - |
| `<a>` | `href` | URL, mail address with `mailto:` prefix |
| | `target` | `"_blank"` opens in a new tab |

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

| tag | attribute | description |
| - | - | - |
| `<img/>` | `src` | source file |
| | `alt` | text description in case of display problem |
| | `title` | title seen on hover |
| | `height` | height in pixels |
| | `width` | width in pixels |
| `<figure>` | | environment for `<img>` and `<figcaption>` |
| `<table>` | | environment composed of table rows `<tr>` |
| | | tables can be divied in `<thead>` `<tbody>` `<tfoot>` |
| `<td>` | | table data |
| | `colspan` | number of columns spanned by the data |
| | `rowspan` | number of rows spanned by the data |
| `<th>` | | table heading used in a `<td>` emplacement |
| | `scope` | `"row"` or `"col"` |

## Forms

| tag | attribute | description |
| - | - | - |
| `<form>` | | form environment |
| | `action` | URL of the receiving server |
| | `method` | `"get"` (by default) or `"post"` |
| `<input/>` | | |
| | `type` | `"text"` `"password"` (concealed text) |
| | `name` | identifier |
| | `maxlength` | maximal length of the input |
| `<textarea>` | | multi-line text input |
| `<input/>` | `type` | `"radio"` choice option |
| | `name` | identifier |
| | `value` | value if checked |
| | `checked` | `"checked"` checked by default |
| `<input/>` | `type` | `"checkbox"` |
| | `name` | identifier |
| | `value` | value if checked |
| | `checked` | `"checked"` checked by default |
| `<select>` | | drop down menu |
| | `name` | identifier |
| | `size` | number of options shown at once |
| | `multiple` | `"multiple"` multiple choice possible |
| `<option>` | | one option in the drop down |
| | `value` | value if selected |
| | `selected` | `"selected"` selected by default |
| `<input/>` | `type` | `"file"` box for text input and browse button |
| | `name` | identifier |
| `<input/>` | `type` | `"submit"` button sending the form to the server |
| | `name` | identifier |
| | `value` | text on the button |
| `<input/>` | `type` | `"image"` clickable image as submit button |
| | | all `<img/>`'s attributes are available |

> p162

## Some more

Block elements always start on a new line: `<h1>`, `<div>`, `<p>`, `<ul>`, `<li>`

Inline elements always appear on the same line: `<a>`, `<b>`, `<em>`, `<img/>`

| tag | description |
| - | - |
| `<!-- text -->` | comments |
| `<div>` | environment contains a series of elements into a block element |
| `<span>` | environment contains a series of elements into an inline element |
| `<iframes>` | |

## Global attributes

| attribute | description |
| - | - |
| `id` | identify uniquely an element for `css` or `js`|
| `class` | identify multiple elementes for `css` or `js` |
