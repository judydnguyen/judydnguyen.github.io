---
layout: page
title: gallery
permalink: /gallery/
description: A collection of moments captured through my lens.
hide_header: true
nav: true
nav_order: 5
---

<!-- _pages/gallery.md -->
<!-- Photos come from _data/gallery.yml and are shown in that order; the first one is featured. -->
<div class="gallery">
  <p class="gallery-lead">A visual journey through moments, places, and stories that inspire me.</p>

  {% if site.data.gallery.images %}
    <div class="gallery-justified">
      {% for image in site.data.gallery.images %}
        {% if image.link %}
          {% assign image_path = image.link %}
        {% elsif image.url %}
          {% assign image_path = image.url %}
        {% else %}
          {% assign image_path = 'assets/img/' | append: image.filename | relative_url %}
        {% endif %}
        {% if image.caption and image.caption != '' %}
          {% assign image_alt = image.caption %}
        {% else %}
          {% assign image_alt = 'Gallery photo' %}
        {% endif %}
        <figure class="gallery-tile{% if forloop.first %} gallery-tile--featured{% endif %}">
          <img
            src="{{ image_path }}"
            alt="{{ image_alt }}"
            {% if forloop.first %}
              loading="eager"
            {% else %}
              loading="lazy"
            {% endif %}
            referrerpolicy="no-referrer"
            data-zoomable
          >
          {% if image.caption and image.caption != '' %}
            <figcaption>{{ image.caption }}</figcaption>
          {% endif %}
        </figure>
      {% endfor %}
    </div>
  {% else %}
    <p>No photos yet.</p>
  {% endif %}
</div>

<script>
  // Give each tile its photo's aspect ratio so rows line up at an even height.
  document.querySelectorAll('.gallery-tile:not(.gallery-tile--featured) img').forEach(function (img) {
    function setRatio() {
      if (img.naturalWidth && img.naturalHeight) {
        img.parentElement.style.setProperty('--r', (img.naturalWidth / img.naturalHeight).toFixed(3));
      }
    }
    if (img.complete) setRatio();
    else img.addEventListener('load', setRatio);
  });
</script>
