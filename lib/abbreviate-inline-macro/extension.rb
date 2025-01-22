require 'asciidoctor/extensions' unless RUBY_ENGINE == 'opal'

include Asciidoctor

class AbbreviateInlineMacro < Extensions::InlineMacroProcessor
  use_dsl

  named :tla
  name_positional_attributes 'title'

  def process parent, target, attrs
    doc= parent.document
    doc.attributes['seen_abbreviations'] ||= {}
    seen_abbreviations = doc.attributes['seen_abbreviations']
    full_form = attrs['title'] || 'Abbreviation'
      if seen_abbreviations.key?(target) && doc.backend == 'html5'
        create_inline parent, :quoted, %(<abbr title="#{full_form}">#{target}</abbr>), type: :unquoted
      else
        seen_abbreviations[target] = full_form
        create_inline parent, :quoted, %(#{full_form} (#{target})), type: :unquoted
      end
  end

end