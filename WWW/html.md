# HyperText Markup Language

## Tags

`<! >`
`<? ?>`
`<!-- -->`
`< >`
`< \>`

## Meta tags

| tags | description |
| - | - |
| `<!doctype html>` | informs browser that this is a modern HTML document|
| `<?xml version="1.0" ?>` | |
| *`<html>` | all html code |
| *`<head>` | metadata |
| *`<body>` | all shown elements |

*those tags are in practice optional since there is a standard way used by all browsers to automatically add them in documents missing them.

n.b. quotes around attribute values are now optional (source?)

## Head

| tag | attributes | values & description |
| - | - | - |
| `<title>` | | displayed in the tab |
| `<meta/>` | | |
| | `charset` | `"utf-8"` |

> p191

## CSS

| tag | attributes | values & description |
| - | - | - |
| `<link/>` | `href` | `"path/to/file.css"` |
| | `type` | `"text/css"` |
| | `rel` | `"stylesheet"` |
| `<style>` | | CSS block inside html |
| | `type` | `"text/css"` |

## JS

| tag | attributes | values & description |
| - | - | - |
| `<script>` | ∅ | JS script inside html |
| | `src` | `"path/to/file.js"` (with nothing between tags) |
| | `type` | `"module"` |
| `<button>` | `onclick` | `"/*some js code*/;"` executes code on click |

## Global attributes

| attribute | description |
| - | - |
| `id` | identify uniquely an element for `css` or `js`|
| `class` | identify multiple elementes for `css` or `js` |

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

| tag | description |
| - | - |
| `<!-- -->` | comments |
| `<div>` | element containing a series of child elements into a block element |
| `<span>` | element containing a series of child elements into an inline element |

## Layout elements

These are block-level elements in the same away as `<div>` with evocative names

| | |
| - | - |
| `<header>` | |
| `<footer>` | |
| `<nav>` | |
| `<section>` | |
| `<article>` | |
| `<aside>` | |

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

| tag | attribute | values & description |
| - | - | - |
| `<a>` | `href` | URL |
| | `target` | `"_blank"` opens in a new tab |

| URL type | syntax |
| - | - |
| absolute | `"https://www.site.org/path/to"` returns `/path/to/index.html` |
| relative | `"../file.html` returns /path/file.html"` |
| in-file | `#head` goes to `<h1 id="head">` in the same page |
| emails | `"mailto:name@domain.org"` opens mailer |

## Objects

| tag | attribute | values & description |
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
| `<iframes>` | | inline frame containing a html page |
| | `src` | html page URL |
| | `height` | height in pixels |
| | `width` | width in pixels |
| | `seamless` | `"seamless"` remove scrollbar |

## Forms

| tag | attribute | values & description |
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

## Audio Video Disco

> p200

| | |
| - | - |
| `<video>` | |
| `<audio>` | |

## Escape characters [cf.](https://htmlandcssbook.com/extras/html-escape-codes/)

| | |
| - | - |
| `&lt;` | `<` |
| `&gt;` | `>` |
| `&quot;` | `"` |
| `&amp;` | `&` |
