$ ->
  $body = $ document.body
  ['github', 'dribbble', 'instagram', 'px', 'twitter', 'email'].forEach (key) ->
    selector = "##{key}"
    className = "color #{key}"
    $body
      .on 'mouseenter', selector, ->
        $body.addClass className
      .on 'mouseleave', selector, ->
        $body.removeClass className
