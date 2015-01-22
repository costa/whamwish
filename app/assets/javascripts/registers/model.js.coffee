
class Register extends Backbone.Model
  idAttribute: 'key'


  defaults: ->
    titles = @_generateTitles()

    key: @_generateKey()
    title: titles[0]
    subtitle: titles[1]
    bg_color: @_generateBackground()

  _generateTitles: ->
    ["Yo Wishlist", "since #{I18n.l 'date.formats.default', new Date}"]

  _generateKey: ->
    "#{rhex4()}-#{rhex4()}-#{rhex4()}-#{rhex4()}"

  _generateBackground: ->
    '66cc33'


class Registers.LocalRegisters extends Backbone.Collection
  model: Register

  url: '/registers'


rhex4 = ->
  Math.random().toString(16).substr(2, 4)
