require 'dragonfly'

app = Dragonfly[:images]
app.configure_with(:imagemagick)
app.configure_with(:rails)

app.define_macro_on_include(Mongoid::Document, :image_accessor)