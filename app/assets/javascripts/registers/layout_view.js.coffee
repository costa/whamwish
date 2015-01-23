class Registers.LayoutView extends Backbone.View

  UNDO_CHANCE_SECONDS = 3

  events:
    'changeColor  .bg-colorpicker': '_changeBackgroundColor'
    'click  .status.btn': '_undoOrNothing'
    'focus  .completion-suggested': '_selectAll'
    'input  .completion-suggested': '_styleNewNew'  # XXX TMP (must style a model)
    'input  .wish': '_dummyEditing' # XXX TMP

  bindings:
    '.title': 'title'
    '.subtitle': 'subtitle'
    '.bg-colorpicker':  # NOTE one way only, unfortunately, #_changeBackgroundColor is the other way
      attributes: [
        name: 'data-color'
        observe: 'bg_color'
        onGet: (val)-> "##{val}"
      ]

  _changeBackgroundColor: (e)->
    @model.set 'bg_color', e.color.toHex().slice(1)
    @_undoableSave()

  _autoSaveSetup: ->
    @listenTo @model, 'change', (model, options)->
      if options.stickitChange
        @$(options.stickitChange.selector).addClass 'editing'
        @_undoableSave()
    @stickit()

    @listenTo @model, 'change:bg_color', (model, value)->
      @_setBackground value
    @_setBackground @model.get 'bg_color'
    @$('.bg-colorpicker').colorpicker()

  render: ->
    @$el.html JST['registers/layout']()

    @_autoSaveSetup()
    @_resetDummyItems()

    @listenToOnce @model, 'sync', @_flashLoaded
    @_statusText "Unsaved"  if @model.isNew()
    @

  _styleNewNew: (e)->
    @$('.completion-new').removeClass('completion-new').addClass('completion-progress')
    $(e.target).removeClass('completion-suggested').addClass('completion-new')

  _dummyEditing: (e)->
    @$(e.target).addClass 'editing'
    @_undoableSave()

  _resetDummyItems: ->
    _(
      '#wish-1234567890bar': "Whisky bar"
      '#wish-1234567890pony': "Pony"
      '#wish-1234567890girl': "Little girl"
      '#wish-1234567890new': "What would you want?"
    ).each (val, sel)=>
      @$(sel).text val

    @_styleNewNew target: @$('#wish-1234567890girl')[0]
    @$('#wish-1234567890new').removeClass('completion-progress').addClass('completion-suggested')

  _undoableSave: ->
    @_undo_seconds_left = UNDO_CHANCE_SECONDS
    unless @__undoTimer
      @_showStatusBtn()
      @_undoTick()

  _undoOrNothing: ->
    return  unless @__undoTimer

    clearTimeout @__undoTimer
    delete @__undoTimer

    @_doLoad()

  _undoTick: ->
    @_statusText "Undo? (#{@_undo_seconds_left})"

    if @_undo_seconds_left-- > 0
      @__undoTimer = _(=> @_undoTick()).delay 1000
    else
      delete @__undoTimer
      @_doSave()

  _doSave: ->
    @model.save null, wait: true

    @$('.editing').removeClass 'editing'
    @$('.bg-colorpicker').colorpicker('hide')

    @stopListening @model, 'sync', @_flashLoaded
    @_statusFlash "Saved"

  _doLoad: ->
    @$('.bg-colorpicker').colorpicker('hide')

    @model.revert()
    @_resetDummyItems()

    if @model.isNew()
      @_statusText "Unsaved"
    else
      @_flashLoaded()

  _flashLoaded: ->
    @_statusFlash "Loaded"

  _statusFlash: (text)->
    @_statusText text
    _(=>
      @_hideStatusBtn()  if @$('.status.btn').text() == text
    ).delay 6000

  _statusText: (text)->
    @_showStatusBtn()
    @$('.status.btn').
      animate(opacity: 0.2, 'fast').
      queue((next)=>
        @$('.status.btn').text text
        next()
      ).
      animate(opacity: 0.8, 'fast')

  _showStatusBtn: ->
    @$('.aux-header-control .bg-colorpicker').addClass('hidden')
    @$('.aux-header-control .status.btn').removeClass('hidden')

  _hideStatusBtn: ->
    @$('.aux-header-control .status.btn').addClass('hidden')
    @$('.aux-header-control .bg-colorpicker').removeClass('hidden')

  _setBackground: (color)->
    bg_color = 'FBF7F3'
    @$('.register').css
      background: "linear-gradient(rgba(#{@_hexTOrgb color}, 0.5), rgba(#{@_hexTOrgb bg_color}, 0.5) 200px)"


  _selectAll: (e)->
    _(->
      $(e.target).selectText()
    ).defer()  # NOTE doesn't work otherwise

  _hexTOrgb: (hex)->
    val = parseInt(hex, 16);
    "#{(val >> 16) & 0xFF},#{(val >> 8) & 0xFF},#{val & 0xFF}"
