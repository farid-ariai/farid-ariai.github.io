# Farid Ariai's personal website

The website uses the existing Jekyll/AcademicPages theme.

## Content

- `_pages/about.md`, `_pages/research.md` and `_pages/cv.md` provide the main profile pages.
- `_data/research.json` is the shared record for the research profile, themes, six projects and technical skills.
- `_publications/` holds the publication records used by both website citations and the LaTeX CV.
- `files/Farid_Ariai_CV.pdf` is the downloadable CV.
- `cv.tex` is its editable LaTeX source, excluded from the generated website.

## Build the website

Use Ruby 3.3 and Bundler:

```sh
BUNDLE_PATH=vendor/bundle bundle install
BUNDLE_PATH=vendor/bundle bundle exec jekyll build
BUNDLE_PATH=vendor/bundle bundle exec jekyll serve --host 127.0.0.1
```

## Update the downloadable CV

The maintained standalone source is `cv.tex`. The synchronisation script updates its marked profile, project, publication and skills blocks, preserving the surrounding LaTeX layout and biographical entries. Keep appointment and education changes aligned manually with `_pages/cv.md`.

From this directory, with Ruby and Tectonic installed:

```sh
ruby scripts/sync_cv.rb
ruby scripts/sync_cv.rb --check
mkdir -p local/cv-build
tectonic --untrusted --keep-logs --outdir local/cv-build cv.tex
cp local/cv-build/cv.pdf files/Farid_Ariai_CV.pdf
```

Inspect the compiled pages before replacing the download. A different LaTeX source path can be supplied as the script's final argument. The CV remains self-contained for ordinary LaTeX compilation.

Keep private briefs, source reports and factual review notes outside this website directory. Build output, local dependencies and the `local/` working directory are ignored; the `scripts/` directory is excluded from the published site.
