unlet b:current_syntax
syn include @HTML $VIMRUNTIME/syntax/html.vim
syn region htmlTemplate start=+<script [^>]*type *=[^>]*text/ractive[^>]*>+
\                       end=+</script>+me=s-1 keepend
\                       contains=@HTML,htmlScriptTag,@htmlPreproc
