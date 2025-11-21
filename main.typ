#import "_template.typ": *

// --- DOCUMENT CONTENT STARTS HERE ---

#show: doc => manual(
  title: "Dependency Tax",
  subtitle: "Gem Upgrade Protocols",
  author: "Thomas Countz",
  version: "0.0.1",
  year: "2025",
  doc
)


= Operational Context

The metaphor of technical debt is functionally inadequate for describing the accumulation of outdated dependencies. Unlike debt, which implies a principal sum that can be repaid, outdated dependencies function closer to a *tax*.

This tax is levied on all future development velocity. It is paid continuously in the form of compatibility shims, security vulnerabilities, and cognitive load.

== Terminology: Technical Lag

To distinguish this phenomenon from standard debt, we introduce the metric of *Technical Lag*.

#note(title: "Definition", color: c-yellow)[
  [Technical Lag] refers to the temporal delta between the upstream release of a dependency and the currently deployed version within the production environment.
]

The accumulation of lag is not linear; it is compounding. As the delta increases, the probability of a breaking change ($Delta P$) approaches 1.0.

=== Uncertainty Principle

The uncertainty principle in dependency management states that as the technical lag ($L$) increases, the predictability of successful upgrades decreases exponentially. This relationship can be modeled as:

$
P("success") = e^(-k * L)
$

Where $k$ is a constant representing the sensitivity of the dependency ecosystem.

See #link("https://example.com")[Dependency Management under Uncertainty] for a formal treatment.

=== Code Example in Ruby

This is an example of a Gemfile that may incur technical lag if not regularly updated:

```ruby
# Gemfile
gem 'rails', '~> 6.0.0'
gem 'activesupport', '~> 6.0.0'
```

As new versions of `rails` and `activesupport` are released, the lag increases, leading to potential security vulnerabilities and incompatibilities.

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
