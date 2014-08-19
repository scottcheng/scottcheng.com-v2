$ ->
  $body = $ document.body
  ['logo', 'name', 'github', 'instagram', 'twitter', 'facebook', 'email'].forEach (key) ->
    selector = "##{key}"
    className = "color #{key}"
    $body
      .on 'mouseenter', selector, ->
        $body.addClass className
      .on 'mouseleave', selector, ->
        $body.removeClass className
