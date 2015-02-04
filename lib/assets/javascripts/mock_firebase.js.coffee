#= require mockfirebase/browser/mockfirebase

MockFirebase.override()

class TrueMockFirebase extends Firebase
  constructor: (path)->
    super
    _(=>
      if window.MOCK_FIREBASE && MOCK_FIREBASE[path]
        @set(MOCK_FIREBASE[path])
        MOCK_FIREBASE[path] = null
        @flush()
      ).delay 999

window.Firebase = TrueMockFirebase
