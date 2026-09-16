---
layout: single
title: "CV"
permalink: /cv/
author_profile: true
redirect_from:
  - /resume
  - /resume-json
---

[Download my academic CV (PDF)]({{ '/files/Farid_Ariai_CV.pdf' | relative_url }})

## Profile

{{ site.data.research.profile }}

## Education

- **PhD in Data Science**, [The University of Queensland](https://uq.edu.au/), Australia — 2024–Present. Supervisors: Gianluca Demartini and Joel Mackenzie.
- **Master of Software Engineering**, [University of Tehran](https://ut.ac.ir), Iran — 2021–2023. Ranked first in my cohort.
- **Bachelor of Software Engineering**, [Ferdowsi University of Mashhad](https://um.ac.ir), Iran — 2012–2017.

## Research experience

### PhD Researcher — Legal NLP and LLM Evaluation

*The University of Queensland · April 2024–Present*

- Conduct research on legal retrieval, parameter-efficient model adaptation and post-training quantisation, with an emphasis on controlled evaluation and reproducible experiments.
- Develop research software spanning dataset preparation, model training and inference, statistical evaluation and GPU/HPC execution.
- Authored a survey of Legal NLP published in *ACM Computing Surveys*.

### Research Collaborator — Digital Deliberative Democracy (D3)

*The University of Queensland / University of Zurich · April 2024–Present*

Contribute to research on NLP and human–AI interaction in civic participation through the [D3 project](https://d3-project.ch), supported by [SNSF Grant 205975](https://data.snf.ch/grants/grant/205975).

## Selected research projects

{% for project in site.data.research.projects %}
### [{{ project.title }}]({{ '/research/' | relative_url }}#{{ project.id }})

{% for bullet in project.cv_bullets %}
- {{ bullet }}
{% endfor %}

{% endfor %}
## Publications

{% assign publication_number = 1 %}
{% for category in site.publication_category %}
{% assign publications = site.publications | where: 'category', category[0] | sort: 'date' | reverse %}
{% if publications.size > 0 %}
### {{ category[1].title }}

<ol start="{{ publication_number }}">
{% for post in publications %}
  <li>{% include publication-citation.html post=post %} <a href="{{ post.url | relative_url }}">Details</a></li>
{% endfor %}
</ol>
{% assign publication_number = publication_number | plus: publications.size %}
{% endif %}
{% endfor %}

## Teaching experience

**Tutor — CSSE7030: Introduction to Programming**<br>
*The University of Queensland, Brisbane · July 2025–Present*

Tutor postgraduate students in Python programming, algorithmic thinking and software design.

## Industry experience

**Software Developer**<br>
*Neyestan Rayaneh, Mashhad, Iran · September 2015–January 2024*

- Designed and maintained enterprise software systems.
- Managed the full software-development lifecycle: requirements, implementation, testing and deployment.

## Technical skills

{% for skill in site.data.research.skills %}
- **{{ skill.group }}:** {{ skill.items }}.
{% endfor %}

**Languages:** Persian (native); English (professional / academic proficiency).

## Academic referees

Professor Gianluca Demartini — Principal Supervisor, School of EECS, UQ.<br>
Dr Joel Mackenzie — Associate Supervisor, School of EECS, UQ.
