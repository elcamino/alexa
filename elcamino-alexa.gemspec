# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{elcamino-alexa}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tobias Begalke"]
  s.date = %q{2011-09-02}
  s.description = %q{Ruby library for the Amazon Alexa web API}
  s.email = %q{elcamino@spyz.org}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "elcamino-alexa.gemspec",
    "lib/alexa.rb",
    "lib/alexa/config.rb",
    "lib/alexa/container.rb",
    "lib/alexa/sites_linking_in.rb",
    "lib/alexa/sites_linking_in/site.rb",
    "lib/alexa/traffic_history.rb",
    "lib/alexa/traffic_history/historical_data.rb",
    "lib/alexa/url_info.rb",
    "lib/alexa/url_info/categories.rb",
    "lib/alexa/url_info/contact_info.rb",
    "lib/alexa/url_info/content_data.rb",
    "lib/alexa/url_info/contributing_subdomains.rb",
    "lib/alexa/url_info/related.rb",
    "lib/alexa/url_info/traffic_data.rb",
    "lib/alexa/url_info/usage.rb",
    "test/helper.rb",
    "test/test_alexa.rb"
  ]
  s.homepage = %q{http://github.com/elcamino/alexa}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Alexa Web API ruby library}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rest-client>, [">= 1.0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<rest-client>, [">= 1.0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<rest-client>, [">= 1.0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

