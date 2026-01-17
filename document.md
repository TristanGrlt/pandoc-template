---
title: "The main title"
subtitle: "A nice subtitle"
author: "Name Surname"
institute: "University of ..."
lang: "fr"
theme: "light" # <-- thème clair : light | thème sombre : dark
no-cover-page: false # <-- Activer/désactiver la page de garde
no-toc: true # <-- Activer/désactiver la table des matières
fix-images: false # <-- Forcer les images à rester exactement à leur position (true) ou laisser LaTeX les positionner automatiquement (false)
fontsize: 12pt
geometry: margin=2.5cm
bibliography: references.bib
---

# LaTeX Report Template with Pandoc

This folder contains a LaTeX template for generating professional reports with Pandoc, along with a flexible Makefile to simplify compilation.

## Contents

- `template.tex` - Main LaTeX template
- `Makefile` - Compilation script with configurable options
- `img/` - Folder containing required images
  - `dark-background.png` - Background image for dark theme
  - `light-background.png` - Background image for light theme

## Installation

### Prerequisites

Make sure you have installed:

- **Pandoc** (version 2.0 or higher)
- **XeLaTeX** (included in TeX Live or MiKTeX)
- **Make** (usually pre-installed on Linux/macOS)

### Quick Installation

## Usage

### Basic Usage

Place your Markdown file at the same level as the Makefile (or directly modify document.md) and compile:

```bash
# Default compilation (light theme, PDF, with cover page and table of contents)
make

# Specify a source file
make INPUT=my-other-document.md

# Specify output name
make OUTPUT_NAME=final-report
```
