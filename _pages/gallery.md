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
            {% if image.link %}
              {% assign image_path = image.link %}
            {% elsif image.url %}
              {% assign image_path = image.url %}
            {% else %}
              {% assign image_path = "assets/img/" | append: image.filename %}
            {% endif %}
            {% if image.caption %}
              {% assign image_alt = image.caption %}
            {% else %}
              {% assign image_alt = "Gallery image" %}
            {% endif %}
            {% comment %} Check if path is external URL (starts with http:// or https://) {% endcomment %}
            {% if image_path contains 'http://' or image_path contains 'https://' %}
              {% comment %} Check if it's a SharePoint URL that might need special handling {% endcomment %}
              {% if image_path contains 'sharepoint.com' %}
                {% comment %} Try to convert SharePoint path to download URL format {% endcomment %}
                {% if image_path contains '/personal/' and image_path contains '/Documents/' %}
                  {% assign sharepoint_path = image_path | split: '/personal/' | last %}
                  {% assign sharepoint_base = image_path | split: '/personal/' | first %}
                  {% comment %} Convert to download.aspx format {% endcomment %}
                  {% assign image_path = sharepoint_base | append: '/personal/' | append: sharepoint_path | append: '?web=1' %}
                {% endif %}
              {% endif %}
              <!-- External image - use direct img tag -->
              <img
                src="{{ image_path }}"
                class="img-fluid gallery-image"
                alt="{{ image_alt }}"
                loading="lazy"
                data-zoomable
                style="width: 100%; height: auto; display: block; border-radius: 8px;"
                crossorigin="anonymous"
                referrerpolicy="no-referrer"
                onerror="this.onerror=null; this.style.display='none'; this.nextElementSibling.style.display='block';"
              >
              <div style="display: none; padding: 2rem; text-align: center; background: var(--global-card-bg-color); border-radius: 8px; color: var(--global-text-color-light);">
                <p>⚠️ Image failed to load</p>
                <p style="font-size: 0.875rem;">The image may require authentication or the URL is invalid.</p>
                <p style="font-size: 0.75rem; margin-top: 0.5rem;">For SharePoint images, ensure the file is publicly accessible or use a direct download URL.</p>
              </div>
              {% if image.caption %}
                <figcaption class="caption">{{ image.caption }}</figcaption>
              {% endif %}
            {% else %}
              <!-- Local image - use figure include with imagemagick support -->
              {% include figure.liquid path=image_path class="img-fluid gallery-image" zoomable=true alt=image_alt caption=image.caption loading="lazy" %}
            {% endif %}
          </figure>
        </div>
      {% endfor %}
    {% else %}
      <!-- Fallback: if gallery.yml doesn't exist, use numbered images -->
      {% assign gallery_images = "1,2,3,4,5,6,7,8,9,10,11,12" | split: "," %}
      {% for img_num in gallery_images %}
        <div class="grid-item gallery-item">
          <figure class="gallery-figure">
            {% assign image_path = "assets/img/" | append: img_num | append: ".jpg" %}
            {% assign image_alt = "Gallery image " | append: img_num %}
            {% include figure.liquid path=image_path class="img-fluid gallery-image" zoomable=true alt=image_alt loading="lazy" %}
          </figure>
        </div>
      {% endfor %}
    {% endif %}
  </div>
</div>
