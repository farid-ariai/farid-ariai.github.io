#!/usr/bin/env ruby
# Keep the standalone LaTeX CV aligned with the website's public research records.
require 'date'
require 'json'
require 'yaml'

site = File.expand_path('..', __dir__)
check = ARGV.delete('--check')
abort 'Usage: ruby scripts/sync_cv.rb [--check] [path/to/cv.tex]' if ARGV.length > 1
cv_path = File.expand_path(ARGV.first || 'cv.tex', site)
research = JSON.parse(File.read(File.join(site, '_data/research.json')))
publications = Dir[File.join(site, '_publications/*.md')].map do |path|
  front_matter = File.read(path).split(/^---\s*$\n?/, 3)[1]
  YAML.safe_load(front_matter, permitted_classes: [Date, Time])
end

def tex(value)
  escapes = {
    '\\' => '\\textbackslash{}', '&' => '\\&', '%' => '\\%', '$' => '\\$',
    '#' => '\\#', '_' => '\\_', '{' => '\\{', '}' => '\\}',
    '~' => '\\textasciitilde{}', '^' => '\\textasciicircum{}',
    '–' => '--', '—' => '---', '“' => '``', '”' => "''", '’' => "'"
  }
  value.to_s.each_char.map { |character| escapes.fetch(character, character) }.join
end

blocks = { 'PROFILE' => tex(research.fetch('profile')) }
blocks['PROJECTS'] = research.fetch('projects').map do |project|
  (["\\begin{minipage}{\\linewidth}", "\\textbf{#{tex(project.fetch('title'))}}", '\\begin{itemize}'] +
   project.fetch('cv_bullets').map { |bullet| "  \\item #{tex(bullet)}" } +
   ['\\end{itemize}', '\\end{minipage}\\par\\vspace{6pt}']).join("\n")
end.join("\n\n")
blocks['SKILLS'] = (['\\begin{itemize}'] + research.fetch('skills').map do |skill|
  "  \\item \\textbf{#{tex(skill.fetch('group'))}:} #{tex(skill.fetch('items'))}"
end + ['  \\item \\textbf{Languages:} Persian (native); English (professional / academic proficiency)',
       '\\end{itemize}']).join("\n")

index = 1
blocks['PUBLICATIONS'] = [['manuscripts', 'Journal articles'], ['conferences', 'Conference proceedings']].map do |category, heading|
  entries = publications.select { |publication| publication['category'] == category }
                        .sort_by { |publication| publication.fetch('date').to_s }.reverse
  lines = ["\\textit{\\small #{heading}}", "\\begin{enumerate}[leftmargin=1.5em, itemsep=4pt, topsep=2pt, start=#{index}]"]
  entries.each do |publication|
    authors = publication.fetch('authors').map do |author|
      author == 'Ariai, F.' ? '\\me{}' : tex(author)
    end
    author_text = authors[0...-1].join(', ') + ', \\& ' + authors.last
    citation = "#{author_text} (#{Date.parse(publication.fetch('date').to_s).year}). #{tex(publication.fetch('title'))}. \\textit{#{tex(publication.fetch('venue'))}}"
    citation += ", #{tex(publication['volume'])}" if publication['volume']
    citation += "(#{tex(publication['issue'])})" if publication['issue']
    citation += ", Art.~#{tex(publication['article'])}" if publication['article']
    citation += ", #{tex(publication['pages'])}" if publication['pages']
    citation += '.'
    citation += " #{tex(publication['conference'])}." if publication['conference']
    if publication['doi']
      doi = tex(publication['doi'])
      citation += " \\href{https://doi.org/#{doi}}{doi:#{doi}}"
    end
    lines << "  \\item #{citation}"
  end
  index += entries.length
  (lines + ['\\end{enumerate}']).join("\n")
end.join("\n\n")

original = File.read(cv_path)
updated = original.dup
blocks.each do |name, content|
  pattern = /% BEGIN GENERATED #{name}\n.*?% END GENERATED #{name}/m
  abort "Missing or duplicate #{name} markers in #{cv_path}" unless updated.scan(pattern).length == 1
  updated.sub!(pattern) { "% BEGIN GENERATED #{name}\n#{content}\n% END GENERATED #{name}" }
end
if check
  abort 'The CV differs from the shared records; run scripts/sync_cv.rb.' unless original == updated
  puts 'CV profile, six projects, technical skills and four publications match the shared records.'
else
  File.write(cv_path, updated)
  puts "Updated #{cv_path}"
end
