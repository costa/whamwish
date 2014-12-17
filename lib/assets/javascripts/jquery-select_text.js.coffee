jQuery.fn.selectText = ->  # FROM http://stackoverflow.com/a/13641884/714287
  if document.body.createTextRange
    range = document.body.createTextRange()
    range.moveToElementText @[0]
    range.select()
  else if window.getSelection
    selection = window.getSelection()
    range = document.createRange()
    range.selectNodeContents @[0]
    selection.removeAllRanges()
    selection.addRange range
