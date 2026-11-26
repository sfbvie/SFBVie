---
layout: about
title: à propos
permalink: /
subtitle: Société savante nationale dédiée à la biologie fondamentale du vieillissement, ouverte à l'international.

selected_papers: false # includes a list of papers marked as "selected={true}"
social: true # includes social icons at the bottom of the page

announcements:
  enabled: true # includes a list of news items
  scrollable: true # adds a vertical scroll bar if there are more than 3 news items
  limit: 11 # leave blank to include all the news in the `_news` folder

latest_posts:
  enabled: true
  scrollable: true # adds a vertical scroll bar if there are more than 3 new posts items
  limit: 10 # 10 real posts exist so far (the al-folio sample posts are hidden from /blog/ but not filtered here); bump this up whenever a new real post is published
---

<a class="lang-toggle" href="https://translate.google.com/translate?sl=fr&tl=en&u={{ site.url }}{{ page.url | relative_url }}" title="Traduire cette page en anglais (Google Traduction)" target="_self">🌐 English</a>

<style>
  .lang-toggle {
    position: fixed;
    top: 0.6rem;
    right: 4.5rem;
    z-index: 1051;
    padding: 0.3rem 0.75rem;
    font-size: 0.8rem;
    color: var(--global-text-color);
    background-color: var(--global-card-bg-color);
    border: 1px solid var(--global-divider-color);
    border-radius: 999px;
    text-decoration: none;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12);
  }
  @media (max-width: 576px) {
    .lang-toggle {
      top: auto;
      bottom: 1rem;
      right: 1rem;
    }
  }
  .lang-toggle:hover {
    color: var(--global-hover-text-color);
    background-color: var(--global-hover-color);
  }
</style>

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
    <p><a href="mailto:contact@sfbvie.fr">contact@sfbvie.fr</a></p>
  </div>
</div>

{% comment %}
"Prochain événement" banner, computed at build time (deploy.yml rebuilds daily): among posts with an `event_start`
(and optional `event_end`, default = start) whose last day is today or later, the one starting first.
Same logic as the auto-pinned card in \_pages/blog.md.
{% endcomment %}
{% assign today = site.time | date: "%Y%m%d" | plus: 0 %}
{% assign next_event = nil %}
{% assign next_start = 99999999 %}
{% for p in site.posts %}
{% if p.event_start and p.hide_from_list != true %}
{% assign p_start = p.event_start | date: "%Y%m%d" | plus: 0 %}
{% assign p_end = p.event_end | default: p.event_start | date: "%Y%m%d" | plus: 0 %}
{% if p_end >= today and p_start < next_start %}
{% assign next_event = p %}
{% assign next_start = p_start %}
{% endif %}
{% endif %}
{% endfor %}
{% if next_event %}

{% comment %}
"Add to calendar": Google Calendar link built here; the .ics comes from \_pages/prochain-evenement.ics (same selection
loop, change both together). All-day event, so the end date is exclusive: last day + 1 (computed from noon to stay
clear of DST shifts).
{% endcomment %}
{% assign ne_start = next_event.event_start | date: "%Y%m%d" %}
{% capture ne_last_noon %}{{ next_event.event_end | default: next_event.event_start | date: "%Y-%m-%d" }} 12:00:00{% endcapture %}
{% assign ne_end = ne_last_noon | date: "%s" | plus: 86400 | date: "%Y%m%d" %}
{% capture ne_details %}{{ next_event.description | strip_html | strip }}

{{ next_event.url | absolute_url }}{% endcapture %}

<div class="next-event-wrap"><div class="next-event">
  <a class="next-event-main" href="{{ next_event.url | relative_url }}">
    <span class="next-event-label"><i class="fa-solid fa-calendar-day"></i> Prochain événement · {{ next_event.event_date }}</span>
    <span class="next-event-title">{{ next_event.title }}</span>
  </a>
  <span class="next-event-cal">
    <a href="https://calendar.google.com/calendar/render?action=TEMPLATE&amp;text={{ next_event.title | strip_html | url_encode }}&amp;dates={{ ne_start }}/{{ ne_end }}&amp;details={{ ne_details | url_encode }}" target="_blank" rel="noopener"><i class="fa-brands fa-google"></i> Google Agenda</a>
    <a href="{{ '/prochain-evenement.ics' | relative_url }}" download="sfbvie-prochain-evenement.ics"><i class="fa-solid fa-calendar-plus"></i> iCal / Outlook (.ics)</a>
  </span>
</div></div>

<style>
  .next-event {
    display: block;
    margin: 0 0 1.5rem;
    padding: 0.75rem 1rem;
    border-left: 4px solid var(--global-theme-color);
    border-radius: 0.25rem;
    background-color: var(--global-card-bg-color);
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12);
    color: var(--global-text-color);
  }
  .next-event:hover {
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
  }
  .next-event-main,
  .next-event-main:hover {
    display: block;
    color: var(--global-text-color);
    text-decoration: none;
  }
  .next-event-cal {
    display: flex;
    flex-wrap: wrap;
    gap: 0.4rem 1.2rem;
    margin-top: 0.5rem;
    font-size: 0.85rem;
  }
  .next-event-cal a {
    color: var(--global-theme-color);
  }
  .next-event-label {
    display: block;
    font-size: 0.85rem;
    font-weight: bold;
    color: var(--global-theme-color);
  }
  .next-event-title {
    display: block;
    margin-top: 0.2rem;
  }
</style>

{% endif %}

La **SFBVie** fédère une communauté multidisciplinaire centrée sur les mécanismes fondamentaux du vieillissement et leur translation en stratégies thérapeutiques innovantes, avec une ouverture internationale.

En tant que société savante scientifique, la SFBVie donne la priorité aux mécanismes causaux du vieillissement, à l'innovation rigoureuse et à la translation vers la médecine et l'industrie, dans un cadre responsable.

### Ce que nous faisons

- Fédérer la communauté française de biologie du vieillissement.
- Organiser réunions, congrès, écoles thématiques, formations.
- Développer des standards ouverts : protocoles, données, reproductibilité.
- Soutenir les jeunes chercheurs (mentorat, visibilité, prix).

### Ce qui nous différencie

- Focus sur la biologie fondamentale et la biologie biomédicale pour des avancées mécanistiques majeures et des applications innovantes en médecine, santé publique et écologie.
- Interdisciplinarité incluant l'éthique, la philosophie, la sociologie.

### International

- Coopérations avec les sociétés partenaires.
- Mise en relation des chercheurs/ses pour collaboration et montage de projets ambitieux.
- Promouvoir la biologie du vieillissement auprès des instances internationales.
- Contribuer à la création d'une communauté internationale de jeunes chercheurs/ses.
- Harmonisation des standards et bonnes pratiques.

Découvrez nos [groupes thématiques]({{ '/projects/' | relative_url }}), nos [ressources documentaires]({{ '/ressources/' | relative_url }}), et [comment adhérer]({{ '/adhesion/' | relative_url }}) à la SFBVie.

### En partenariat avec

<div class="partner-logos">
  <div class="partner-logo-col">
    <a class="partner-logo-chip" href="https://www.cnrs.fr" target="_blank" rel="noopener">
      <img src="{{ '/assets/img/logo_cnrs.png' | relative_url }}" alt="CNRS" loading="lazy">
    </a>
  </div>
  <div class="partner-logo-col">
    <a class="partner-logo-chip" href="https://www.inserm.fr" target="_blank" rel="noopener">
      <img src="{{ '/assets/img/logo_inserm.png' | relative_url }}" alt="Inserm" loading="lazy">
    </a>
  </div>
</div>

<div class="partner-itmo-logos">
  <span class="partner-itmo-chip"><img src="{{ '/assets/img/logo_itmo_bcde.png' | relative_url }}" alt="Institut thématique Biologie cellulaire, reproduction, développement et évolution" loading="lazy"></span>
  <span class="partner-itmo-chip"><img src="{{ '/assets/img/logo_itmo_pmn.png' | relative_url }}" alt="Institut thématique Physiopathologie, métabolisme, nutrition" loading="lazy"></span>
</div>

<hr class="partner-divider">

<div class="partner-itmo-logos">
  <a class="partner-itmo-chip" href="https://sfgg.org/" target="_blank" rel="noopener"><img src="{{ '/assets/img/logo_sfgg.png' | relative_url }}" alt="Société Française de Gériatrie et Gérontologie (SFGG)" loading="lazy"></a>
  <a class="partner-itmo-chip" href="https://agingfederation.eu/" target="_blank" rel="noopener"><img src="{{ '/assets/img/logo_efar.png' | relative_url }}" alt="European Federation for Aging Research (EFAR)" loading="lazy"></a>
</div>

<style>
  .partner-divider {
    max-width: 12rem;
    margin: 0.5rem auto 1.5rem;
    border: none;
    border-top: 1px solid var(--global-divider-color);
  }

  .partner-logos {
    display: flex;
    flex-wrap: wrap;
    align-items: flex-start;
    justify-content: center;
    gap: 1.5rem;
    margin: 1rem 0 1.25rem;
  }
  .partner-logo-col {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 0.4rem;
  }
  .partner-logo-chip {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    height: 64px;
    padding: 0.5rem 1.25rem;
    background: #ffffff;
    border-radius: 0.5rem;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12);
  }
  .partner-logo-chip img {
    height: 100%;
    width: auto;
  }

  .partner-itmo-logos {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    justify-content: center;
    gap: 1.25rem;
    margin: 0 0 2rem;
  }
  .partner-itmo-chip {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 0.5rem 1rem;
    background: #ffffff;
    border-radius: 0.5rem;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12);
  }
  .partner-itmo-chip img {
    height: 32px;
    width: auto;
    max-width: 100%;
  }
  .partner-logo-caption {
    margin: 0;
    font-size: 0.8rem;
    color: var(--global-text-color-light);
    text-align: center;
  }
</style>
