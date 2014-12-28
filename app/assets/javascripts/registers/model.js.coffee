rhex4 = ->
  Math.random().toString(16).substr(2, 4)

class Register extends Backbone.Model

  defaults: ->
    key: @_generateKey()
    title: "Yo Wishlist"
    subtitle: "since #{I18n.l 'date.formats.default', new Date}"
    bg_color: '66cc33'

  _generateKey: ->
    "#{rhex4()}-#{rhex4()}-#{rhex4()}-#{rhex4()}"


class Registers.Registers extends Backbone.Collection
  model: Register
