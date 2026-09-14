---
layout: single
title: "Research"
permalink: /research/
author_profile: true
---

My research centres on Legal NLP and LLM evaluation: how language models use information, how efficiently they operate, and how their outputs and effects can be measured. Civic participation and educational AI provide complementary settings for this work.

{% for project in site.data.research.projects %}
## {{ project.title }} {#{{ project.id }}}

*{{ project.type }}*

{{ project.description }}

{% endfor %}
