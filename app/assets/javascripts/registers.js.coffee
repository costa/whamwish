class Router extends Backbone.Router
  routes:
    'reg/:key': '_showRegister'
    '*path': '_land'  # XXX show an actual 404 for an invalid path, after pushstate has been implemented

  _land: ->
    register = Registers.recent.add {}
    @navigate "reg/#{register.get 'key'}", trigger: true

  _showRegister: (key)->
    register =
      Registers.recent.findWhere(key: key) ||
      key.length > 16 && Registers.recent.add(key: key)  # XXX decent validation, see app/models/register

    return @_land()  unless register  # XXX show an actual 404 instead of the silent redirect + SPECS

    new Registers.LayoutView(
      el: $('main')
      model: register
    ).render()

$ ->
  Registers.recent = new Registers.LocalRegisters
  new Router
  Backbone.history.start()
