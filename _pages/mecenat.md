---
layout: page
permalink: /mecenat/
title: mécénat
description: Soutenir la SFBVie.
nav: true
nav_order: 6
---

Créée en 2026, la Société Française de Biologie du Vieillissement rassemble les acteurs engagés dans la compréhension des mécanismes fondamentaux du vieillissement. Elle favorise les échanges entre recherche fondamentale, recherche clinique, sciences humaines, innovation et intelligence artificielle.

<div class="mecenat-stats">
  <div class="mecenat-stat">
    <div class="mecenat-stat-value">500+</div>
    <div class="mecenat-stat-label">membres issus de disciplines complémentaires</div>
  </div>
  <div class="mecenat-stat">
    <div class="mecenat-stat-value">30 avril 2027</div>
    <div class="mecenat-stat-label">2<sup>e</sup> Journée annuelle à Nice</div>
  </div>
  <div class="mecenat-stat">
    <div class="mecenat-stat-value">Inserm · CNRS</div>
    <div class="mecenat-stat-label">et des liens étroits avec l'EFAR (European Federation for Aging Research)</div>
  </div>
</div>

### Votre soutien rend possible

<div class="mecenat-grid mecenat-grid-4">
  <div class="mecenat-card">
    <div class="mecenat-card-num">01</div>
    <div class="mecenat-card-title">Jeunes chercheurs</div>
    <p>Prix, bourses, mobilité et participation aux événements scientifiques.</p>
  </div>
  <div class="mecenat-card">
    <div class="mecenat-card-num">02</div>
    <div class="mecenat-card-title">Événements</div>
    <p>Journée annuelle, workshops thématiques, formations et rencontres.</p>
  </div>
  <div class="mecenat-card">
    <div class="mecenat-card-num">03</div>
    <div class="mecenat-card-title">Collaborations</div>
    <p>Nouveaux projets entre disciplines, institutions et entreprises innovantes.</p>
  </div>
  <div class="mecenat-card">
    <div class="mecenat-card-num">04</div>
    <div class="mecenat-card-title">Diffusion</div>
    <p>Partage de connaissances scientifiques fiables auprès de tous les publics.</p>
  </div>
</div>

### Trois façons de s'engager

Des modalités adaptées à chaque organisation.

<div class="mecenat-grid mecenat-grid-3">
  <div class="mecenat-tier">
    <div class="mecenat-tier-title">Don &amp; mécénat</div>
    <div class="mecenat-tier-subtitle">Soutenir sans contrepartie commerciale directe</div>
    <p>Contribution financière, mécénat de compétences, don de matériel, de logiciels ou de services.</p>
  </div>
  <div class="mecenat-tier">
    <div class="mecenat-tier-title">Partenariat</div>
    <div class="mecenat-tier-subtitle">Construire une collaboration durable</div>
    <p>Soutien institutionnel avec des modalités de visibilité définies ensemble dans une convention.</p>
  </div>
  <div class="mecenat-tier">
    <div class="mecenat-tier-title">Parrainage</div>
    <div class="mecenat-tier-subtitle">Accompagner une action ou un événement</div>
    <p>Journée annuelle, workshop, prix scientifique, bourse ou action dédiée aux jeunes chercheurs.</p>
  </div>
</div>

<div class="mecenat-note">
  <strong>Indépendance scientifique garantie.</strong> La SFBVie conserve l'entière maîtrise de sa gouvernance, de sa programmation scientifique, du choix des intervenants et de l'attribution des prix et des bourses.
</div>

### Nous contacter

Vous souhaitez soutenir la SFBVie ? Échangeons sur un partenariat construit selon vos priorités et les actions que vous souhaitez accompagner.

<div class="mecenat-contact">
  <div>
    <strong>Contactez-nous</strong><br>
    <a href="mailto:contact@sfbvie.fr">contact@sfbvie.fr</a>
  </div>
</div>

<style>
  .mecenat-stats {
    display: flex;
    flex-wrap: wrap;
    gap: 1rem;
    margin: 1.5rem 0 2.5rem;
  }
  .mecenat-stat {
    flex: 1 1 220px;
    text-align: center;
    padding: 1.5rem 1rem;
    background-color: var(--global-card-bg-color);
    border: 1px solid var(--global-divider-color);
    border-radius: 0.5rem;
  }
  .mecenat-stat-value {
    font-size: 1.5rem;
    font-weight: 700;
    color: var(--global-theme-color);
  }
  .mecenat-stat-label {
    margin-top: 0.35rem;
    font-size: 0.9rem;
    color: var(--global-text-color-light);
  }

  .mecenat-grid {
    display: grid;
    gap: 1rem;
    margin: 1rem 0 2rem;
  }
  .mecenat-grid-4 {
    grid-template-columns: repeat(4, 1fr);
  }
  .mecenat-grid-3 {
    grid-template-columns: repeat(3, 1fr);
  }
  @media (max-width: 900px) {
    .mecenat-grid-4 {
      grid-template-columns: repeat(2, 1fr);
    }
    .mecenat-grid-3 {
      grid-template-columns: 1fr;
    }
  }
  @media (max-width: 576px) {
    .mecenat-grid-4 {
      grid-template-columns: 1fr;
    }
  }

  .mecenat-card,
  .mecenat-tier {
    padding: 1.25rem;
    background-color: var(--global-card-bg-color);
    border: 1px solid var(--global-divider-color);
    border-radius: 0.5rem;
  }
  .mecenat-card-num {
    font-size: 1.1rem;
    font-weight: 700;
    color: var(--global-theme-color);
  }
  .mecenat-card-title,
  .mecenat-tier-title {
    font-weight: 700;
    margin: 0.35rem 0;
  }
  .mecenat-tier-subtitle {
    font-size: 0.9rem;
    color: var(--global-text-color-light);
    margin-bottom: 0.5rem;
  }
  .mecenat-card p,
  .mecenat-tier p {
    margin: 0;
    font-size: 0.95rem;
  }

  .mecenat-note {
    padding: 1rem 1.25rem;
    border-left: 3px solid var(--global-theme-color);
    background-color: var(--global-card-bg-color);
    border-radius: 0 0.375rem 0.375rem 0;
    margin: 0 0 2rem;
  }

  .mecenat-contact {
    padding: 1.25rem 1.5rem;
    background-color: var(--global-card-bg-color);
    border: 1px solid var(--global-divider-color);
    border-radius: 0.5rem;
    margin-bottom: 1.5rem;
  }
</style>
