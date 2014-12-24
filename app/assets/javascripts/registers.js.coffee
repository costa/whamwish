class Router extends Backbone.Router
  routes:
    'reg/:key': '_showRegister'
    '*path': '_land'  # XXX show an actual 404 after pushstate has been implemented

  _land: ->
    register = Registers.recent.add {}
    @navigate "reg/#{register.get 'key'}", trigger: true

  _showRegister: (key)->
    register = Registers.recent.findWhere(key: key)
    # XXX handle the case when the register is not in recent
    if register
      new Registers.LayoutView(
        el: $('main')
        model: register
      ).render()
    else
      @_land()  # XXX show an actual 404

$ ->
  Registers.recent = new Registers.Registers
  new Router
  Backbone.history.start()
