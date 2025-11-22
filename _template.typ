
// --- 1. VARIBLE DEFINITION ---
#let c-bg = rgb("#FFFFFF") // White Background
#let c-paper = rgb("#F9F9F9") // Off-White Paper
#let c-ink = rgb("#333333") // Dark Gray Text
#let c-blue = rgb("#3F62BB")
#let c-red = rgb("#BB4430")
#let c-green = rgb("#3A7D44")
#let c-yellow = rgb("#EFA00B")
#let c-purple = rgb("#4C2C92")
#let f-body = "Public Sans"
#let f-mono = "Fira Code"

// --- 2. TEMPLATE FUNCTION ---
#let manual(
  title: "",
  subtitle: "",
  author: "",
  version: "",
  year: "",
  body,
) = {
  // Page Configuration
  set page(
    paper: "a4",
    fill: c-bg,
    margin: (x: 2.5cm, y: 2.5cm, top: 2.5cm, bottom: 2.5cm),

    footer: context {
      let pg_num = counter(page).get().first()
      if pg_num > 2 {
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
            align(right)[#counter(page).display("01")],
          )
        } else {
          grid(
            columns: (1fr, 1fr, 1fr),
            align(left)[#counter(page).display("01")],
            if chapter != none {
              align(center)[#upper[#chapter.body]]
            },
          )
        }
      }
    },
    footer-descent: 30%,
  )

  set text(font: f-body, fill: c-ink, size: 12pt)

  show raw: set text(font: f-mono)
  show raw.where(block: true): block.with(
    inset: 1.5em,
    width: 100%,
  
  )
  show heading: set text(weight: "bold")
  show heading.where(level: 1): it => [
    #pagebreak(weak: true)
    #text(size: 20pt)[#upper(it)]
    #line(length: 100%, stroke: 0.5pt + c-ink)
  ]
  show heading.where(level: 2): set text(size: 12pt)
  show heading.where(level: 3): set text(size: 10pt)

  // --- TITLE PAGE RENDER ---
  align(center + horizon)[
    #rect(inset: 0pt, stroke: 0pt + c-ink)[
      #rect(fill: c-ink, width: 100%, inset: 3em)[
        #text(fill: c-bg, font: "Inter 28pt", size: 28pt, weight: "bold")[#upper(title)]
      ]
      #pad(8em)[
        #text(size: 14pt, weight: "regular")[#upper(subtitle)]

        #line(length: 50%, stroke: 0.5pt + c-ink)


        #text(size: 12pt, weight: "regular")[#author]

        #v(5em)
        #text(size: 10pt, font: f-mono)[© #year]
        #text(size: 8pt, font: f-mono)[v.#version]

      ]
    ]
  ]
  pagebreak()

  outline()

  pagebreak()

  body
}

// --- 3. COMPONENT: ALERT BOX ---
#let note(title: "NOTE", content, color: c-ink) = {
  block(
    stroke: (left: 4pt + color, top: 1pt + color, bottom: 1pt + color, right: 1pt + color),
    inset: 1em,
    width: 100%,
    below: 2em,
  )[
    #text(fill: color, weight: "bold")[#upper(title)] \
    #content
  ]
}
