
// --- 1. PALETTE DEFINITION ---
#let c-paper  = rgb("#D5D5D5") // Light Gray Background
#let c-ink    = rgb("#333333") // Dark Gray Text
#let c-blue   = rgb("#3F62BB")
#let c-red    = rgb("#BB4430")
#let c-green  = rgb("#3A7D44")
#let c-yellow = rgb("#EFA00B")

// --- 2. TEMPLATE FUNCTION ---
#let manual(
  title: "",
  subtitle: "",
  doc-id: "DOC-001",
  author: "",
  body
) = {
  // Page Configuration
  set page(
    paper: "a4", // <--- SWITCHED TO A4
    fill: c-paper,
    // Adjusted margins for A4 height/width
    margin: (x: 2.5cm, y: 2.5cm, top: 3.5cm, bottom: 3cm),

    // THE HEADER
    header: context {
      set text(size: 8pt, weight: "regular", fill: c-ink)
      grid(
        columns: (1fr, 1fr),
        align(left)[#upper(title)],
        align(right)[ID: #doc-id]
      )
      v(-0.5em)
      line(length: 100%, stroke: 0.5pt + c-ink)
    },

    // THE FOOTER
    footer: context {
      set text(size: 8pt, weight: "regular", fill: c-ink)
      line(length: 100%, stroke: 0.5pt + c-ink)
      v(0.5em)
      grid(
        columns: (1fr, 1fr, 1fr),
        align(left)[ORIGINAL SPECIFICATION],
        align(center)[PAGE #counter(page).display("001")],
        align(right)[#upper(subtitle)]
      )
    }
  )

  // Text Configuration
  set text(
    font: "Google Sans Code",
    fill: c-ink,
    size: 10pt,
    hyphenate: false
  )

  // Paragraph Configuration
  set par(
    justify: true,
    leading: 0.5em,
    first-line-indent: 0em
  )
  set par(spacing: 1.5em)

  // Heading Configuration
  set heading(numbering: "1.0")
  show heading: it => [
    #set text(weight: "bold")
    #v(0.5em)
    #if it.level == 1 [
      #text(size: 16pt, fill: c-ink)[#upper(it)]
      #line(length: 100%, stroke: 1pt + c-ink)
    ] else [
      #text(fill: c-blue)[#upper(it)]
    ]
    #v(0.5em)
  ]

  // --- TITLE PAGE RENDER ---
  align(center + horizon)[
    #rect(inset: 0pt, stroke: 0pt + c-ink)[
      #rect(fill: c-ink, width: 100%, inset: 2em)[
        #text(fill: c-paper, size: 24pt, weight: "bold")[#upper(title)]
      ]
      #pad(1em)[
        #text(size: 14pt, weight: "regular")[#upper(subtitle)]

        #line(length: 50%, stroke: 1pt + c-ink)

        PREPARED BY: \
        #upper(author)

        DATE: \
        #datetime.today().display("[year]-[month]-[day]")
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
    below: 2em
  )[
    #text(fill: color, weight: "bold")[#upper(title)] \
    #content
  ]
}
