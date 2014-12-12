class Registers.LayoutView extends Backbone.View
  render: ->
    @$el.html JST['registers/layout']()
    @
