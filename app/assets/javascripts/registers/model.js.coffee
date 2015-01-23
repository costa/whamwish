class Register extends Backbone.Firebase.Model

  idAttribute: 'key'

  url: ->  # XXX https://github.com/firebase/backbonefire/issues/131
    "#{FIREBASE_URL}/registers/#{@get 'key'}"

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


  # NOTE Here is an experimental (hacky) implementation of a dual storage Backbone model
  # NOTE Featuring: write to (Rails) REST, sync with Firebase; #revert to the values before the last sync

  constructor: ->
    super

    # NOTE "Fixing" the model's url for writes (REST), *after* Firebase has been initialised
    @url = -> @collection.url

    # XXX https://github.com/firebase/backbonefire/issues/133
    @sync = Backbone.Model.prototype.sync
    @save = Backbone.Model.prototype.save

    # NOTE see #revert below
    save_attrs = =>
      @__synced_attrs = _(@attributes).clone()
    @on 'sync', save_attrs
    save_attrs()

  revert: ->
    @set @__synced_attrs

  isNew: ->  # NOTE permit pre-defined id (key), synced objects will have created_at set
    !@get('created_at')?

  _listenLocalChange: ->
    # NOTE a hack as to not let Backbone.Firebase update umm firebase (writes to REST)


class Registers.LocalRegisters extends Backbone.Collection
  model: Register

  url: '/registers'


rhex4 = ->
  Math.random().toString(16).substr(2, 4)
