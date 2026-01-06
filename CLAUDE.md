# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Bookdown project for "Data Science in Education Using R" (Second Edition), published by Routledge. The book teaches data science concepts through educational datasets and is available at [datascienceineducation.com](https://datascienceineducation.com/).

## Building and Rendering the Book

### Build the entire book
```r
bookdown::render_book("index.Rmd", "bookdown::gitbook")
```

### Build specific output formats
```r
# GitBook (web) format
bookdown::render_book("index.Rmd", "bookdown::gitbook")

# Word document format
bookdown::render_book("index.Rmd", "bookdown::word_document2")
```

### Preview during development
Open `index.Rmd` in RStudio and use the "Build Book" button in the Build pane, or use the command above. The rendered book appears in the `_book/` directory.

### Clean build artifacts
```r
bookdown::clean_book()
```

## Project Structure

### Book Configuration Files
- `index.Rmd` - Book metadata, bibliography setup, welcome section
- `_bookdown.yml` - Chapter order (via `rmd_files`), language labels, output settings
- `_output.yml` - Output format configurations (gitbook, Word)
- `before_script.R` - Runs before each chapter; sets knitr options and global settings

### Chapter Organization
Chapters are numbered Rmd files (01-21) that must be listed in order in `_bookdown.yml`. The book follows this structure:
- **01-04**: Introduction and foundations
- **05-06**: Foundational R skills
- **07-14**: Eight data analysis walkthroughs (the core content)
- **15-21**: Application, teaching, resources, and references

### Custom R Functions
Located in `r/` directory:
- `palette_dataedu.R` - Custom color palettes for visualizations
- `theme_dataedu.R` - Custom ggplot2 theme for book figures
- `book-status.R` - Book status tracking utilities

### Data Directory
`data/` contains datasets organized by walkthrough:
- `online-science-motivation/` - Walkthrough 1 (Chapter 7)
- `gradebooks/` - Walkthrough 2 (Chapter 8)
- `agg_data/` - Walkthrough 3 (Chapter 9)
- `longitudinal_data/` - Walkthrough 4 (Chapter 10)
- `tidytuesday/` - Walkthrough 5 & 6 (Chapters 11-12)
- `ml/` - Walkthrough 8 (Chapter 14)

## Working with Chapters

### Chapter Naming Convention
Chapters use descriptive suffixes:
- `wt-` prefix = walkthrough chapter (e.g., `07-wt-ed-ds-pipeline.Rmd`)
- `foundational-skills_1` and `foundational-skills_2` for the two foundational chapters

### Adding/Modifying Chapters
1. Ensure the Rmd file is listed in `_bookdown.yml` under `rmd_files` in the correct order
2. Use consistent header structure (`#` for chapter titles matches `{#c##}` anchor)
3. Include standard sections: Topics Emphasized, Functions Introduced, Vocabulary, Chapter Overview
4. Reference figures stored in `man/figures/` using relative paths

### Cross-References
- Chapters: `[Chapter 6](#c06)` (use the `{#c##}` identifier)
- Figures: Use chunk labels like `{r fig7-1, fig.cap = "..."}`
- Tables: Use bookdown's table cross-referencing

## Dependencies and Package Management

### Key Packages
Core dependencies defined in `DESCRIPTION`:
- `tidyverse` - Data manipulation and visualization
- `bookdown` - Book rendering
- `dataedu` - Custom package for this book (installed from `data-edu/dataedu` GitHub)
- Educational data analysis: `lme4`, `caret`, `tidytext`, `tidygraph`, `ggraph`
- Social media data: `rtweet`, `bskyr`

### Installing Dependencies
```r
# Install from DESCRIPTION file
devtools::install_deps()

# Or manually install key packages
install.packages(c("tidyverse", "bookdown", "here", "janitor"))
devtools::install_github("data-edu/dataedu")
```

## Bibliography and Citations

### Bibliography Files
- `book.bib` - Main bibliography (sorted alphabetically via index.Rmd chunk)
- `packages.bib` - Auto-generated R package citations (created in index.Rmd)
- `apa_pl.csl` - APA citation style file

### Adding Citations
Add new entries to `book.bib`, then reference using `[@citationkey]`. The index.Rmd script automatically sorts both bib files.

## Deployment

### Automatic Deployment
GitHub Actions workflow (`.github/workflows/deploy-bookdown-netlify.yml`) automatically builds and deploys to Netlify when pushing to the `main` branch.

### Manual Deployment
Build the book locally, then the `_book/` directory contains the static site ready for deployment.

## Git Workflow

### Main Branch
The `main` branch is used for production deployments.

### Working with Branches
The project uses feature branches for development (e.g., `c12-finishing-up` for finishing Chapter 12).

## Common Issues

### Build Errors
- Ensure all packages in DESCRIPTION are installed
- Check that `before_script.R` runs without errors
- Verify all chapter files listed in `_bookdown.yml` exist
- Ensure figure paths in `man/figures/` are correct

### Chapter Rendering Issues
Each chapter renders in a new R session (`new_session: yes` in `_bookdown.yml`), so ensure all required packages are loaded within each chapter, not just in `before_script.R`.

## Book-Specific Conventions

### Code Chunks
- Use meaningful chunk labels (e.g., `{r fig7-1}` for figures)
- Set `out.width = "100%"` for figures (configured in before_script.R)
- DPI set to 300 for high-quality figures

### Writing Style
This is an educational text focused on practical data science in education contexts. Each walkthrough demonstrates the complete data science pipeline (import → tidy → transform → visualize → model → communicate) using authentic educational datasets.

### Data Science Pipeline
The book emphasizes this workflow from @r4ds2023:
1. Import data
2. Tidy data
3. Transform data
4. Visualize data
5. Model data
6. Communicate findings
