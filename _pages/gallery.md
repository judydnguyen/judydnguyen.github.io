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
          >
          <button type="button" class="gallery-view" aria-label="View full image">
            <i class="ti ti-arrows-maximize"></i> View full image
          </button>
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

<div class="gallery-lightbox" role="dialog" aria-modal="true" aria-label="Photo viewer">
  <button type="button" class="gallery-lightbox-close" aria-label="Close">&times;</button>
  <button type="button" class="gallery-lightbox-prev" aria-label="Previous photo">&lsaquo;</button>
  <figure class="gallery-lightbox-figure">
    <img alt="">
    <figcaption></figcaption>
  </figure>
  <button type="button" class="gallery-lightbox-next" aria-label="Next photo">&rsaquo;</button>
</div>

<script>
  // Size each tile from its photo's aspect ratio so rows line up at an even height.
  (function () {
    var gallery = document.querySelector('.gallery');
    var tiles = document.querySelectorAll('.gallery-tile:not(.gallery-tile--featured)');
    if (!gallery || !tiles.length) return;

    function rowHeight() {
      return parseFloat(getComputedStyle(gallery).getPropertyValue('--row-height')) || 260;
    }

    function sizeTile(tile) {
      var ratio = parseFloat(tile.style.getPropertyValue('--r')) || 1.5;
      tile.style.flexBasis = ratio * rowHeight() + 'px';
    }

    tiles.forEach(function (tile) {
      var img = tile.querySelector('img');
      function setRatio() {
        if (img.naturalWidth && img.naturalHeight) {
          tile.style.setProperty('--r', (img.naturalWidth / img.naturalHeight).toFixed(3));
        }
        sizeTile(tile);
      }
      if (img.complete) setRatio();
      else img.addEventListener('load', setRatio);
    });

    window.addEventListener('resize', function () {
      tiles.forEach(sizeTile);
    });
  })();

  // Lightbox: shows the whole, uncropped photo with its caption.
  (function () {
    var tiles = Array.prototype.slice.call(document.querySelectorAll('.gallery-tile'));
    var box = document.querySelector('.gallery-lightbox');
    if (!tiles.length || !box) return;
    var boxImg = box.querySelector('img');
    var boxCaption = box.querySelector('figcaption');
    var current = 0;

    function show(index) {
      current = (index + tiles.length) % tiles.length;
      var img = tiles[current].querySelector('img');
      var caption = tiles[current].querySelector('figcaption');
      boxImg.src = img.src;
      boxImg.alt = img.alt;
      boxCaption.textContent = caption ? caption.textContent : '';
    }

    function open(index) {
      show(index);
      box.classList.add('is-open');
      document.body.style.overflow = 'hidden';
    }

    function close() {
      box.classList.remove('is-open');
      document.body.style.overflow = '';
    }

    tiles.forEach(function (tile, index) {
      tile.addEventListener('click', function () {
        open(index);
      });
    });

    box.querySelector('.gallery-lightbox-close').addEventListener('click', close);
    box.querySelector('.gallery-lightbox-prev').addEventListener('click', function (e) {
      e.stopPropagation();
      show(current - 1);
    });
    box.querySelector('.gallery-lightbox-next').addEventListener('click', function (e) {
      e.stopPropagation();
      show(current + 1);
    });
    box.addEventListener('click', function (e) {
      if (e.target === box) close();
    });
    document.addEventListener('keydown', function (e) {
      if (!box.classList.contains('is-open')) return;
      if (e.key === 'Escape') close();
      else if (e.key === 'ArrowLeft') show(current - 1);
      else if (e.key === 'ArrowRight') show(current + 1);
    });
  })();
</script>
