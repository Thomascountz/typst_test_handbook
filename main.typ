#import "_template.typ": *

// --- DOCUMENT CONTENT STARTS HERE ---

#show: doc => manual(
  title: "Dependency Tax",
  subtitle: "Gem Upgrade Protocols",
  author: "Engineering Dept",
  doc-id: "SPEC-2025-EU",
  doc
)

= Operational Context

The metaphor of technical debt is functionally inadequate for describing the accumulation of outdated dependencies. Unlike debt, which implies a principal sum that can be repaid, outdated dependencies function closer to a *tax*.

This tax is levied on all future development velocity. It is paid continuously in the form of compatibility shims, security vulnerabilities, and cognitive load.

== Terminology: Technical Lag

To distinguish this phenomenon from standard debt, we introduce the metric of *Technical Lag*.

#note(title: "Definition", color: c-blue)[
  [Technical Lag] refers to the temporal delta between the upstream release of a dependency and the currently deployed version within the production environment.
]

The accumulation of lag is not linear; it is compounding. As the delta increases, the probability of a breaking change ($Delta P$) approaches 1.0.

= Metrics & Measurement

To quantify the tax, we utilize two primary scalar values. These values allow for the objective comparison of project health across the fleet.

== Version Sequence Distance (VSD)

VSD represents the discrete count of releases between the current version ($V_"curr"$) and the ideal version ($V_"ideal"$).

$ "VSD" = sum_(i="curr")^("ideal") "release"_i $

== Libyear

Libyear represents the chronological time passed between the release date of the current version and the release date of the ideal version.

#note(title: "Critical Warning", color: c-red)[
  Failure to address lag in `rails` or `activesupport` gems results in a cascading dependency lock, rendering minor updates impossible without major refactoring.
]

1.  Identify the constraints preventing the upgrade.
2.  Isolate the "Upper Bound" dependency.
3.  Execute the upgrade sequence.
