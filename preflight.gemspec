Gem::Specification.new do |s|
  s.name              = "preflight"
  s.version           = "0.4.0"
  s.summary           = "Check PDF files conform to various standards"
  s.description       = "Provides a programatic way to check a PDF file conforms to standards like PDF-X/1a"
  s.license           = "MIT"
  s.author            = "James Healy"
  s.email             = ["james@yob.id.au"]
  s.homepage          = "http://github.com/yob/pdf-preflight"
  # remove rdoc - it conflicts with ruby 3.4.x and rubygem 4.x
  # s.has_rdoc          = true
  # s.rdoc_options      << "--title" << "PDF::Preflight" << "--line-numbers"
  s.files             = Dir.glob("lib/**/*") + Dir.glob("bin/*") + ["README.rdoc", "CHANGELOG"]
  s.executables       << "is_pdfx_1a"
  s.required_rubygems_version = ">=1.3.2"
  # as of ruby 2.5 BigDecimal is a gem and no longer in std library
  s.required_ruby_version = ">=2.5"

  s.add_dependency("bigdecimal")
  s.add_dependency("matrix")
  s.add_dependency("pdf-reader", ">=1.1.0")

  s.add_development_dependency("rake")
  s.add_development_dependency("roodi")
  s.add_development_dependency("rspec",   "<4.0")
  s.add_development_dependency("ZenTest", "<5.0")
end
