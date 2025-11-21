
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
#let f-mono = "DM Mono"

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
    paper: "a4", // <--- SWITCHED TO A4
    fill: c-bg,
    margin: (x: 2.5cm, y: 2.5cm, top: 2.5cm, bottom: 2.5cm),

    header: context {
      if counter(page).get().first() > 1 {
        let h = query(heading.where(level: 1).after(here()))
          .filter(h => h.location().page() == here().page())
          .at(0, default: {
            query(heading.where(level: 1).before(here())).at(-1, default: none)
          })

        set text(size: 8pt, weight: "regular", fill: c-ink)

        grid(
          columns: (1fr, 1fr),
          align(left)[#upper[#title]],
          if h != none { align(right)[#upper[#h.body]] }
        )
      }
    },
    header-ascent: 50%,

    footer: context {
      if counter(page).get().first() > 1 {
        set text(size: 8pt, weight: "regular", fill: c-ink)
        align(center)[#counter(page).display("01")]
      }
    },
    footer-descent: 50%,
  )

  set text(font: f-body, fill: c-ink, size: 10pt)

  show raw: set text(font: f-mono)
  show raw.where(block: true): block.with(
    fill: c-paper,
    inset: 2em,
    width: 100%,
  )

  set heading(numbering: "1.0")
  show heading: it => [
    #text(weight: "bold")[#upper(it)]
  ]

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
        #text(size: 10pt, font:f-mono)[© #year]
        #text(size: 8pt, font:f-mono)[v.#version]

      ]
    ]
  ]
  pagebreak()

  // --- BODY RENDER ---
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
