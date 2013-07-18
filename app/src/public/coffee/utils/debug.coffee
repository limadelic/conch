define [], () ->

  window.p = (x) -> console.log JSON.stringify x

  window.pp = (x) -> p (name for name of x)
