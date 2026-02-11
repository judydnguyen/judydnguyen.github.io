---
layout: page
title: gallery
permalink: /gallery/
description: A collection of moments captured through my lens.
nav: true
nav_order: 5
---

<!-- _pages/gallery.md -->
<div class="gallery">
  <div class="gallery-intro">
    <p class="lead">A visual journey through moments, places, and stories that inspire me.</p>
  </div>

  <div class="grid gallery-grid">
    <div class="grid-sizer"></div>
    {% if site.data.gallery %}
      {% for image in site.data.gallery.images %}
        <div class="grid-item gallery-item">
          <figure class="gallery-figure">
            {% include figure.liquid 
              path="assets/img/{{ image.filename }}" 
              class="img-fluid gallery-image" 
              zoomable=true 
              alt="{% if image.caption %}{{ image.caption }}{% else %}Gallery image{% endif %}"
              caption="{{ image.caption }}"
              loading="lazy"
            %}
          </figure>
        </div>
      {% endfor %}
    {% else %}
      <!-- Fallback: if gallery.yml doesn't exist, use numbered images -->
      {% assign gallery_images = "1,2,3,4,5,6,7,8,9,10,11,12" | split: "," %}
      {% for img_num in gallery_images %}
        <div class="grid-item gallery-item">
          <figure class="gallery-figure">
            {% include figure.liquid 
              path="assets/img/{{ img_num }}.jpg" 
              class="img-fluid gallery-image" 
              zoomable=true 
              alt="Gallery image {{ img_num }}"
              loading="lazy"
            %}
          </figure>
        </div>
      {% endfor %}
    {% endif %}
  </div>
</div>
