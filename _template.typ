
// --- TYPEFACES ---
#let f-body = "Public Sans"
#let f-mono = "Fira Code"
#let f-size = 10pt

// --- COLORS ---
#let c-bg = rgb("#FFFFFF")
#let c-paper = rgb("#F9F9F9")
#let c-ink = rgb("#333333")
#let c-blue = rgb("#3F62BB")
#let c-red = rgb("#BB4430")
#let c-green = rgb("#3A7D44")
#let c-yellow = rgb("#EFA00B")
#let c-purple = rgb("#4C2C92")

// --- COMPONENTS ---
#let note(title: "NOTE", content, color: c-ink) = {
  block(
    stroke: (left: 4pt + color, top: 1pt + color, bottom: 1pt + color, right: 1pt + color),
    inset: 1em,
    width: 100%,
    below: 2em,
  )[
    #text(fill: color, weight: "bold")[#title] \
    #content
  ]
}

// --- PAGE LAYOUT ---
#let manual(title: "", subtitle: "", author: "", version: "", year: "", body) = {
  // Page Configuration
  set page(
    paper: "a4",
    fill: c-bg,
    margin: (x: 2.5cm, y: 2.5cm, top: 2.5cm, bottom: 2.5cm),
  )

  // --- GLOBAL STYLES ---
  set text(font: f-body, fill: c-ink, size: f-size)

  show raw: set text(font: f-mono)
  show raw.where(block: true): block.with(inset: 1.5em, width: 100%)

  show link: underline

  show heading: set text(weight: "bold")
  show heading.where(level: 1): it => [
    #pagebreak(weak: true)
    #text(size: 20pt)[#upper(it)]
    #line(length: 100%, stroke: 0.5pt + c-ink)
  ]
  show heading.where(level: 2): set text(size: 12pt)
  show heading.where(level: 3): set text(size: 10pt)

  // --- TITLE PAGE ---
  v(1fr)
  align(right)[
    #line(length: 100%, stroke: 0.5pt + c-ink)
    #par(text(size: 48pt, weight: "black", tracking: -3pt)[#upper(title)])
    #v(0.5em)
    #par(text(size: 24pt)[#subtitle])
    #v(5em)
    #v(1fr)
    #par(text(size: 22pt, weight: "bold")[#author])
    #v(1fr)
  ]
  pagebreak()

  // --- COPYRIGHT PAGE ---
  v(1fr)
  par(text(size: 12pt, weight: "bold")[#title])
  par(text(size: 10pt)[#subtitle])
  par(text(size: 10pt)[by #author])
  par(text(size: 10pt)[Copyright $copyright$ #year #author. All rights reserved.])
  v(4fr)
  par(text(size: 9pt)[Version #version])
  pagebreak()

  set page(
    footer: context {
      let pg_num = counter(page).get().first()
      set text(size: 8pt, weight: "regular", fill: c-ink)

      line(length: 100%, stroke: 0.5pt + c-ink)
      v(0.5em)

      let chapter = query(heading.where(level: 1).after(here()))
        .filter(h => h.location().page() == here().page())
        .at(0, default: {
          query(heading.where(level: 1).before(here())).at(-1, default: none)
        })

      if calc.even(pg_num) {
        grid(
          columns: (1fr, 1fr, 1fr),
          "",
          if chapter != none {
            align(center)[#upper[#chapter.body]]
          },
          align(right)[#counter(page).display()],
        )
      } else {
        grid(
          columns: (1fr, 1fr, 1fr),
          align(left)[#counter(page).display()],
          if chapter != none {
            align(center)[#upper[#chapter.body]]
          },
        )
      }
    },
    footer-descent: 30%,
  )

  // --- TABLE OF CONTENTS ---
  set page(numbering: "i")
  counter(page).update(1)
  outline(title: "Table of Contents", depth: 3)
  pagebreak()

  // --- DOCUMENT BODY ---
  set page(numbering: "1")
  counter(page).update(1)
  body
}

