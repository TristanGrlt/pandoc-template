# Makefile to compile a document with pandoc and the rapport_template.tex template
# Available options: dark, light, pdf, tex, no-cover, no-toc
# These options can be freely combined

# Default variables
INPUT ?= document.md
OUTPUT_NAME ?= document
TEMPLATE = template.tex
PDF_ENGINE = xelatex
BIBLIOGRAPHY ?= references.bib

# Compilation options
THEME ?= 
FORMAT ?= pdf
COVER ?= 
TOC ?= 

# Build pandoc variables
PANDOC_OPTS = --template=$(TEMPLATE)
PANDOC_OPTS += --pdf-engine=$(PDF_ENGINE)

# Bibliography handling
ifneq ($(wildcard $(BIBLIOGRAPHY)),)
	PANDOC_OPTS += --citeproc --bibliography=$(BIBLIOGRAPHY)
endif

# Add metadata according to options (only if explicitly set)
ifneq ($(THEME),)
ifeq ($(THEME),dark)
	PANDOC_OPTS += --metadata=theme:dark
else
	PANDOC_OPTS += --metadata=theme:light
endif
endif

ifneq ($(COVER),)
ifeq ($(COVER),false)
	PANDOC_OPTS += --metadata=no-cover:true
endif
endif

ifneq ($(TOC),)
ifeq ($(TOC),false)
	PANDOC_OPTS += --metadata=no-toc:true
endif
endif

PANDOC_OPTS += --metadata=csquotes:true

# Determine output extension
ifeq ($(FORMAT),tex)
	OUTPUT = $(OUTPUT_NAME).tex
	PANDOC_OPTS += --standalone
else
	OUTPUT = $(OUTPUT_NAME).pdf
	PANDOC_OPTS += -o $(OUTPUT)
endif

# Main targets
.PHONY: all clean help dark light pdf tex no-cover no-toc dark-pdf light-pdf dark-tex light-tex dark-no-cover light-no-toc dark-no-cover-no-toc rebuild

# Default target
all: $(OUTPUT)

# Force rebuild - always recompile
rebuild:
	@rm -f $(OUTPUT)
	@$(MAKE) $(OUTPUT)

# Compile the document
# Force recompilation if template or input changed
$(OUTPUT): $(INPUT) $(TEMPLATE)
ifeq ($(FORMAT),tex)
	@echo "Compiling to LaTeX: $(INPUT) -> $(OUTPUT)"
	pandoc $(INPUT) $(PANDOC_OPTS) -o $(OUTPUT)
else
	@echo "Compiling to PDF: $(INPUT) -> $(OUTPUT)"
	pandoc $(INPUT) $(PANDOC_OPTS)
endif
	@echo "✓ Document generated: $(OUTPUT)"

# Shortcuts for options
dark:
	@rm -f $(OUTPUT_NAME).pdf
	@$(MAKE) THEME=dark $(OUTPUT)

light:
	@rm -f $(OUTPUT_NAME).pdf
	@$(MAKE) THEME=light $(OUTPUT)

pdf:
	@rm -f $(OUTPUT_NAME).pdf
	@$(MAKE) FORMAT=pdf $(OUTPUT)

tex:
	@rm -f $(OUTPUT_NAME).tex
	@$(MAKE) FORMAT=tex $(OUTPUT)

no-cover:
	@rm -f $(OUTPUT_NAME).pdf
	@$(MAKE) COVER=false $(OUTPUT)

no-toc:
	@rm -f $(OUTPUT_NAME).pdf
	@$(MAKE) TOC=false $(OUTPUT)

# Example combinations
dark-pdf:
	@rm -f $(OUTPUT_NAME).pdf
	@$(MAKE) THEME=dark FORMAT=pdf $(OUTPUT)

light-pdf:
	@rm -f $(OUTPUT_NAME).pdf
	@$(MAKE) THEME=light FORMAT=pdf $(OUTPUT)

dark-tex:
	@rm -f $(OUTPUT_NAME).tex
	@$(MAKE) THEME=dark FORMAT=tex $(OUTPUT)

light-tex:
	@rm -f $(OUTPUT_NAME).tex
	@$(MAKE) THEME=light FORMAT=tex $(OUTPUT)

dark-no-cover:
	@rm -f $(OUTPUT_NAME).pdf
	@$(MAKE) THEME=dark COVER=false $(OUTPUT)

light-no-toc:
	@rm -f $(OUTPUT_NAME).pdf
	@$(MAKE) THEME=light TOC=false $(OUTPUT)

dark-no-cover-no-toc:
	@rm -f $(OUTPUT_NAME).pdf
	@$(MAKE) THEME=dark COVER=false TOC=false $(OUTPUT)

# Clean up
clean:
	@echo "Cleaning generated files..."
	@rm -f *.pdf *.aux *.log *.out *.toc
	@echo "✓ Cleanup complete"

# Help
help:
	@echo "═══════════════════════════════════════════════════════════"
	@echo "  Makefile for compilation with template.tex"
	@echo "═══════════════════════════════════════════════════════════"
	@echo ""
	@echo "Basic usage:"
	@echo "  make [OPTIONS]"
	@echo ""
	@echo "Input variables:"
	@echo "  INPUT=<file>           Markdown source file (default: document.md)"
	@echo "  OUTPUT_NAME=<name>     Output file name (default: document)"
	@echo "  BIBLIOGRAPHY=<file>    Bibliography file (default: references.bib)"
	@echo ""
	@echo "Available options (combinable):"
	@echo "  THEME=dark|light       Document theme (default: light)"
	@echo "  FORMAT=pdf|tex         Output format (default: pdf)"
	@echo "  COVER=true|false       Show cover page (default: true)"
	@echo "  TOC=true|false         Show table of contents (default: true)"
	@echo ""
	@echo "Usage examples:"
	@echo "  make                                    # Default compilation (light, pdf, with cover and toc)"
	@echo "  make THEME=dark                         # Dark theme"
	@echo "  make FORMAT=tex                         # LaTeX output"
	@echo "  make COVER=false                        # Without cover page"
	@echo "  make TOC=false                          # Without table of contents"
	@echo "  make THEME=dark FORMAT=pdf              # Dark theme in PDF"
	@echo "  make THEME=dark COVER=false TOC=false   # Dark theme without cover or toc"
	@echo "  make INPUT=my-doc.md OUTPUT_NAME=output # Custom source file"
	@echo ""
	@echo "Predefined targets:"
	@echo "  make dark-pdf                           # Dark theme, PDF output"
	@echo "  make light-tex                          # Light theme, LaTeX output"
	@echo "  make dark-no-cover-no-toc               # Dark without cover or toc"
	@echo ""
	@echo "Other targets:"
	@echo "  make clean              # Clean generated files"
	@echo "  make help               # Show this help"
	@echo ""
	@echo "═══════════════════════════════════════════════════════════"
