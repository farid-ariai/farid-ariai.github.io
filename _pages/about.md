---
permalink: /
title: "Farid Ariai"
author_profile: true
redirect_from:
  - /about/
  - /about.html
---

<p><strong>{{ site.data.research.headline | escape }}</strong></p>

I am a PhD candidate in Data Science at [The University of Queensland](https://www.uq.edu.au/), in the School of Electrical Engineering and Computer Science, supervised by [Gianluca Demartini](https://www.gianlucademartini.net) and [Joel Mackenzie](https://jmmackenzie.io). My research focuses on natural language processing in the legal domain and the development and evaluation of large language models (LLMs) for legal tasks.

I investigate legal retrieval-augmented generation, legal-entity supervision and the quality–resource trade-offs of LLM quantisation. Across these projects, I combine controlled experiments with reproducible research software to understand what affects model performance, when apparent improvements hold, and where systems fail.

Alongside this work, I contribute to the [Digital Deliberative Democracy (D3) project](https://d3-project.ch) and study human–AI interaction in civic participation. My projects include research infrastructure for AI-assisted consultation drafting and analysis of an online-deliberation experiment. I also develop human-in-the-loop evaluation tools for LLM-generated feedback on Python code.

## Research themes

{% for theme in site.data.research.themes %}
**{{ theme.title }}.** {{ theme.description }}

{% endfor %}
[Explore my research projects]({{ '/research/' | relative_url }}) · [Publications]({{ '/publications/' | relative_url }})

## Background and teaching

I tutor Python programming at UQ in [CSSE7030: Introduction to Programming](https://programs-courses.uq.edu.au/course.html?course_code=CSSE7030). I hold a Master of Software Engineering from the University of Tehran, where I ranked first in my cohort, and a Bachelor of Software Engineering from Ferdowsi University of Mashhad. Before my PhD, I worked in software development, and I bring that engineering experience to the research systems I build.

[View my CV]({{ '/cv/' | relative_url }})
