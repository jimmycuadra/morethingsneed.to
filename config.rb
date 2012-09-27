require "middleman-smusher"

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

set :markdown_engine, :redcarpet

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  activate :smusher
end
