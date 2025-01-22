RUBY_ENGINE == 'opal' ? (require 'abbreviate-inline-macro/extension') : (require_relative 'abbreviate-inline-macro/extension')

Asciidoctor::Extensions.register do
  if @document.backend == 'html5' || @document.backend == 'pdf'
    inline_macro AbbreviateInlineMacro
  end
end
