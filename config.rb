# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

I18n.default_locale = :de
Time.zone = "Berlin"

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

activate :livereload
activate :directory_indexes
activate :blog do |blog|
  blog.permalink = "portfolio/{title}.html"
  blog.sources = "portfolio/{title}.html"
  blog.layout = "project"
end

configure :build do
  activate :minify_css
end

activate :imageoptim do |options|
  # Use a build manifest to prevent re-compressing images between builds
  options.manifest = true

  # Silence problematic image_optim workers
  options.skip_missing_workers = true

  # Cause image_optim to be in shouty-mode
  options.verbose = false

  # Setting these to true or nil will let options determine them (recommended)
  options.nice = true
  options.threads = true

  # Image extensions to attempt to compress
  options.image_extensions = %w(.png .jpg .gif .svg)

  # Compressor worker options, individual optimisers can be disabled by passing
  # false instead of a hash
  options.advpng    = { :level => 4 }
  options.gifsicle  = { :interlace => false }
  options.jpegoptim = { :strip => ['all'], :max_quality => 100 }
  options.jpegtran  = { :copy_chunks => false, :progressive => true, :jpegrescan => true }
  options.optipng   = { :level => 6, :interlace => false }
  options.pngcrush  = { :chunks => ['alla'], :fix => false, :brute => false }
  options.pngout    = { :copy_chunks => false, :strategy => 0 }
  options.svgo      = {}
end

# Layouts
# https://middlemanapp.com/basics/layouts/
# Per-page layout changes
# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'
# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/
# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

def heading_id(str)
  gen_id = str.gsub(/^[^a-zA-Z]+/, '')
  gen_id.tr!('^a-zA-Z0-9 -', '')
  gen_id.tr!(' ', '-')
  gen_id.downcase!
  gen_id
end

def escape_ics(value)
  if value
    value.dup.tap do |v|
      v.gsub!('\\') { '\\\\' }
      v.gsub!(';', '\;')
      v.gsub!(',', '\,')
      v.gsub!(/\r?\n/, '\n')
    end
  end
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end
