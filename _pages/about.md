---
layout: about
title: about
permalink: /
subtitle: Société savante nationale dédiée à la biologie fondamentale du vieillissement, ouverte à l'international.

selected_papers: false # includes a list of papers marked as "selected={true}"
social: true # includes social icons at the bottom of the page

announcements:
  enabled: true # includes a list of news items
  scrollable: true # adds a vertical scroll bar if there are more than 3 news items
  limit: 5 # leave blank to include all the news in the `_news` folder

latest_posts:
  enabled: true
  scrollable: true # adds a vertical scroll bar if there are more than 3 new posts items
  limit: 3 # leave blank to include all the blog posts
---

<!--
  Manual profile block (light/dark logo swap), kept in page content rather than
  a _layouts override: the starter's style contract (test/style_contract.js)
  forbids the starter from owning any _layouts path, even as an acknowledged
  local override. This replicates al_folio_core's about.liquid profile markup
  by hand, using the theme's existing only-light/only-dark CSS classes.
-->
<div class="profile float-right">
  {% capture sizes %}(min-width: {{ site.max_width }}) {{ site.max_width | minus: 30 | times: 0.3 }}px, (min-width: 576px) 30vw, 95vw{% endcapture %}
  {% include figure.liquid loading="eager" path="assets/img/logo_SFBVie.png" class="img-fluid z-depth-1 rounded only-light" sizes=sizes alt="Logo SFBVie" cache_bust=true %}
  {% include figure.liquid loading="eager" path="assets/img/logo_SFBVie_black.png" class="img-fluid z-depth-1 rounded only-dark" sizes=sizes alt="Logo SFBVie" cache_bust=true %}
  <div class="more-info">
    <p>Réunion fondatrice — Créteil, mars 2026</p>
    <p><a href="mailto:contact@sfbv.example.org">contact@sfbv.example.org</a></p>
  </div>
</div>

La **SFBVie** fédère une communauté multidisciplinaire centrée sur les mécanismes fondamentaux du vieillissement et leur translation en stratégies thérapeutiques innovantes, avec une ouverture internationale.

En tant que société savante scientifique, la SFBVie donne la priorité aux mécanismes causaux du vieillissement, à l'innovation rigoureuse et à la translation vers la médecine et l'industrie, dans un cadre responsable.

### Ce que nous faisons

- Fédérer la communauté française de biologie du vieillissement.
- Organiser réunions, congrès, écoles thématiques, formations.
- Développer des standards ouverts : protocoles, données, reproductibilité.
- Soutenir les jeunes chercheurs (mentorat, visibilité, prix).

### Ce qui nous différencie

- Focus **biologie fondamentale** + translation (et non soins/clinique).
- Innovation audacieuse, évaluée avec exigence.
- Interdisciplinarité sélective : éthique, philosophie, société.
- Impact mesurable : avancées mécanistiques et trajectoires translationales.

### International

- Coopérations via MoU et sessions conjointes.
- Échanges de conférenciers et de jeunes chercheurs.
- Harmonisation des standards et bonnes pratiques.
- Visibilité croisée avec les sociétés partenaires.

Découvrez nos [groupes thématiques]({{ '/projects/' | relative_url }}), nos [ressources documentaires]({{ '/ressources/' | relative_url }}), et [comment adhérer]({{ '/adhesion/' | relative_url }}) à la SFBVie.
