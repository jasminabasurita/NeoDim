" NeoDim Theme: v0.0.1 {{{
" Neo-Dracula-IMproved!
" @author Jasmina Jacquelina <jasminejacquelin@gmail.com>
"
" This is a fork of the Dracula Vim Theme:
" https://github.com/dracula/vim
" https://github.com/zenorocha/dracula-theme
" Copyright 2016, All rights reserved
" Code licensed under the MIT license
" http://zenorocha.mit-license.org
" @author Trevor Heins <@heinst>
" @author Éverton Ribeiro <nuxlli@gmail.com>
" @author Derek Sifford <dereksifford@gmail.com>
" @author Zeno Rocha <hi@zenorocha.com>
scriptencoding utf8
" }}}

" Configuration: {{{

if v:version > 580
  highlight clear
  if exists('syntax_on')
    syntax reset
  endif
endif

let g:colors_name = 'neodim'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" Palette: {{{2

let s:fg        = ['#F8F8F2', 255]

let s:bglighter = ['#424450', 238]
let s:bglight   = ['#343746', 237]
let s:bg        = ['#282A36', 236]
let s:bgdark    = ['#21222C', 235]
let s:bgdarker  = ['#191A21', 234]

let s:subtle    = ['#424450', 238]

let s:selection = ['#44475A', 239]
let s:comment   = ['#6272A4',  61]
let s:cyan      = ['#8BE9FD', 117]
let s:green     = ['#50FA7B',  84]
let s:orange    = ['#FFB86C', 215]
let s:pink      = ['#FF79C6', 212]
let s:purple    = ['#BD93F9', 141]
let s:red       = ['#FF5555', 203]
let s:yellow    = ['#F1FA8C', 228]

let s:none      = ['NONE', 'NONE']

if has('nvim')
  let g:terminal_color_0  = '#44475A'
  let g:terminal_color_1  = '#DE312B'
  let g:terminal_color_2  = '#2FD651'
  let g:terminal_color_3  = '#D0D662'
  let g:terminal_color_4  = '#9C6FCF'
  let g:terminal_color_5  = '#DE559C'
  let g:terminal_color_6  = '#6AC5D3'
  let g:terminal_color_7  = '#D7D4C8'
  let g:terminal_color_8  = '#656B84'
  let g:terminal_color_9  = '#FF5555'
  let g:terminal_color_10 = '#50FA7B'
  let g:terminal_color_11 = '#F1FA8C'
  let g:terminal_color_12 = '#BD93F9'
  let g:terminal_color_13 = '#FF79C6'
  let g:terminal_color_14 = '#8BE9FD'
  let g:terminal_color_15 = '#F8F8F2'
endif

" }}}2
" User Configuration: {{{2

if !exists('g:neodim_bold')
  let g:neodim_bold = 1
endif

if !exists('g:neodim_italic')
  let g:neodim_italic = 1
endif

if !exists('g:neodim_underline')
  let g:neodim_underline = 1
endif

if !exists('g:neodim_undercurl') && g:neodim_underline != 0
  let g:neodim_undercurl = 1
endif

if !exists('g:neodim_inverse')
  let g:neodim_inverse = 1
endif

"}}}2
" Script Helpers: {{{2

let s:attrs = {
      \ 'bold': g:neodim_bold == 1 ? 'bold' : 0,
      \ 'italic': g:neodim_italic == 1 ? 'italic' : 0,
      \ 'underline': g:neodim_underline == 1 ? 'underline' : 0,
      \ 'undercurl': g:neodim_undercurl == 1 ? 'undercurl' : 0,
      \ 'inverse': g:neodim_inverse == 1 ? 'inverse' : 0,
      \}

function! s:h(scope, fg, ...) " bg, attr_list, special
  let l:fg = copy(a:fg)
  let l:bg = get(a:, 1, ['NONE', 'NONE'])

  let l:attr_list = filter(get(a:, 2, ['NONE']), {idx, val -> type(val) == 1})
  let l:attrs = len(l:attr_list) > 0 ? join(l:attr_list, ',') : 'NONE'

  " Falls back to coloring foreground group on terminals because
  " nearly all do not support undercurl
  let l:special = get(a:, 3, ['NONE', 'NONE'])
  if l:special[0] !=# 'NONE' && l:fg[0] ==# 'NONE' && !has('gui_running')
    let l:fg[0] = l:special[0]
    let l:fg[1] = l:special[1]
  endif

  let l:hl_string = [
        \ 'highlight', a:scope,
        \ 'guifg=' . l:fg[0], 'ctermfg=' . l:fg[1],
        \ 'guibg=' . l:bg[0], 'ctermbg=' . l:bg[1],
        \ 'gui=' . l:attrs, 'cterm=' . l:attrs,
        \ 'guisp=' . l:special[0],
        \]

  execute join(l:hl_string, ' ')
endfunction

"}}}2
" NeoDim Highlight Groups: {{{2

call s:h('NeoDimBgLight', s:none, s:bglight)
call s:h('NeoDimBgLighter', s:none, s:bglighter)
call s:h('NeoDimBgDark', s:none, s:bgdark)
call s:h('NeoDimBgDarker', s:none, s:bgdarker)

call s:h('NeoDimFg', s:fg)
call s:h('NeoDimFgUnderline', s:fg, s:none, [s:attrs.underline])
call s:h('NeoDimFgBold', s:fg, s:none, [s:attrs.bold])

call s:h('NeoDimComment', s:comment, s:none, [s:attrs.italic])
call s:h('NeoDimCommentBold', s:comment, s:none, [s:attrs.bold])

call s:h('NeoDimSelection', s:none, s:selection)

call s:h('NeoDimSubtle', s:subtle)

call s:h('NeoDimCyan', s:cyan)
call s:h('NeoDimCyanItalic', s:cyan, s:none, [s:attrs.italic])

call s:h('NeoDimGreen', s:green)
call s:h('NeoDimGreenBold', s:green, s:none, [s:attrs.bold])
call s:h('NeoDimGreenItalic', s:green, s:none, [s:attrs.italic])
call s:h('NeoDimGreenItalicUnderline', s:green, s:none, [s:attrs.italic, s:attrs.underline])

call s:h('NeoDimOrange', s:orange)
call s:h('NeoDimOrangeBold', s:orange, s:none, [s:attrs.bold])
call s:h('NeoDimOrangeItalic', s:orange, s:none, [s:attrs.italic])
call s:h('NeoDimOrangeBoldItalic', s:orange, s:none, [s:attrs.bold, s:attrs.italic])
call s:h('NeoDimOrangeInverse', s:bg, s:orange)

call s:h('NeoDimPink', s:pink)
call s:h('NeoDimPinkItalic', s:pink, s:none, [s:attrs.italic])

call s:h('NeoDimPurple', s:purple)
call s:h('NeoDimPurpleBold', s:purple, s:none, [s:attrs.bold])
call s:h('NeoDimPurpleItalic', s:purple, s:none, [s:attrs.italic])

call s:h('NeoDimRed', s:red)
call s:h('NeoDimRedInverse', s:fg, s:red)

call s:h('NeoDimYellow', s:yellow)
call s:h('NeoDimYellowItalic', s:yellow, s:none, [s:attrs.italic])

call s:h('NeoDimError', s:red, s:none, [s:attrs.undercurl], s:red)
call s:h('NeoDimWarn', s:orange, s:none, [s:attrs.undercurl], s:orange)

call s:h('NeoDimErrorLine', s:none, s:none, [s:attrs.undercurl], s:red)
call s:h('NeoDimWarnLine', s:none, s:none, [s:attrs.undercurl], s:orange)
call s:h('NeoDimInfoLine', s:none, s:none, [s:attrs.undercurl], s:cyan)

call s:h('NeoDimTodo', s:cyan, s:none, [s:attrs.bold, s:attrs.inverse])
call s:h('NeoDimSearch', s:green, s:none, [s:attrs.inverse])
call s:h('NeoDimFold', s:comment, s:bgdark)
call s:h('NeoDimBoundary', s:selection, s:selection)
" call s:h('NeoDimBoundary', s:bglighter, s:bglighter)
call s:h('NeoDimLink', s:cyan, s:none, [s:attrs.underline])

call s:h('NeoDimDiffChange', s:none, s:none)
call s:h('NeoDimDiffText', s:bg, s:orange)
call s:h('NeoDimDiffDelete', s:red, s:bgdark)

" }}}2

" }}}
" User Interface: {{{

" Core: {{{2
set background=dark

call s:h('Normal', s:fg, s:bg)
hi! link Visual NeoDimSelection
hi! link VisualNOS Visual
hi! link Search NeoDimSearch
hi! link IncSearch NeoDimOrangeInverse

" Status / Command Line
call s:h('StatusLine', s:none, s:bglighter, [s:attrs.bold])
call s:h('StatusLineNC', s:none, s:bglight)
call s:h('WildMenu', s:bg, s:purple, [s:attrs.bold])

" Tabs
hi! link TabLine NeoDimFold
hi! link TabLineFill NeoDimBgDarker
hi! link TabLineSel Normal

" Popup Menu
hi! link Pmenu NeoDimBgDark
hi! link PmenuSel NeoDimSelection
hi! link PmenuSbar NeoDimBgDark
hi! link PmenuThumb NeoDimSelection

" Messages
hi! link ErrorMsg NeoDimRedInverse
hi! link WarningMsg NeoDimOrangeInverse
hi! link MoreMsg NeoDimFgBold
hi! link Question NeoDimFgBold
hi! link Title NeoDimGreenBold

" Folds
hi! link Folded NeoDimFold
hi! link VertSplit NeoDimBoundary
hi! link FoldColumn NeoDimSubtle

" Line Numbers
hi! link CursorLineNr NeoDimYellow
hi! link LineNr NeoDimComment
hi! link SignColumn NeoDimComment

" Whitespace / Non-text
call s:h('CursorLine', s:none, s:subtle) " Required as some plugins will overwrite
hi! link NonText NeoDimSubtle
hi! link CursorColumn NeoDimSelection
hi! link ColorColumn NeoDimSelection

" Diffs
hi! link DiffAdd NeoDimGreen
hi! link DiffChange NeoDimDiffChange
hi! link DiffText NeoDimDiffText
hi! link DiffDelete NeoDimDiffDelete

"}}}2
" NetRW: {{{2

hi! link Directory NeoDimPurpleBold

" }}}2
" GitGutter: {{{2
hi! link GitGutterAdd NeoDimGreen
hi! link GitGutterChange NeoDimYellow
hi! link GitGutterChangeDelete NeoDimOrange
hi! link GitGutterDelete NeoDimRed
"}}}2

" }}}
" Syntax: {{{

hi! link Comment NeoDimComment
hi! link Underlined NeoDimFgUnderline
hi! link Todo NeoDimTodo

hi! link Error NeoDimError
hi! link SpellBad NeoDimErrorLine
hi! link SpellLocal NeoDimWarnLine
hi! link SpellCap NeoDimInfoLine
hi! link SpellRare NeoDimInfoLine

hi! link Constant NeoDimPurple
hi! link String NeoDimYellow
hi! link Character NeoDimPink
hi! link Number Constant
hi! link Boolean Constant
hi! link Float Constant

hi! link Identifier NeoDimFg
hi! link Function NeoDimGreen

hi! link Statement NeoDimPink
hi! link Conditional NeoDimPink
hi! link Repeat NeoDimPink
hi! link Label NeoDimPink
hi! link Operator NeoDimPink
hi! link Keyword NeoDimPink
hi! link Exception NeoDimPink

hi! link PreProc NeoDimPink
hi! link Include NeoDimPink
hi! link Define NeoDimPink
hi! link Macro NeoDimPink
hi! link PreCondit NeoDimPink
hi! link StorageClass NeoDimPink
hi! link Structure NeoDimPink
hi! link Typedef NeoDimPink

hi! link Type NeoDimCyanItalic

hi! link Delimiter NeoDimFg

hi! link Special NeoDimPink
hi! link SpecialKey NeoDimRed
hi! link SpecialComment NeoDimCyanItalic
hi! link Tag NeoDimCyan
hi! link helpHyperTextJump NeoDimLink
hi! link helpCommand NeoDimPurple
hi! link helpExample NeoDimGreen

call s:h('MatchParen', s:none, s:pink, [s:attrs.underline])
call s:h('Conceal', s:comment, s:bglight)

" CSS: {{{2

hi! link cssAttrComma Delimiter
hi! link cssBraces Delimiter
hi! link cssSelectorOp Delimiter
hi! link cssFunctionComma Delimiter
hi! link cssAttributeSelector NeoDimGreenItalic
hi! link cssAttrRegion NeoDimPink
hi! link cssUnitDecorators NeoDimPink
hi! link cssProp NeoDimCyan
hi! link cssPseudoClassId NeoDimGreenItalic

"}}}2
" Git Commit: {{{2

" These groups appear when editing commit messages.
" They are not part of the Diff interface of vim diff

" The following two are misnomers. Colors are correct.
hi! link diffFile NeoDimGreen
hi! link diffNewFile NeoDimRed

hi! link diffLine NeoDimCyanItalic
hi! link diffRemoved NeoDimRed
hi! link diffAdded NeoDimGreen

"}}}2
" HTML: {{{2

hi! link htmlTag NeoDimFg
hi! link htmlArg NeoDimGreenItalic
hi! link htmlTitle NeoDimFg
hi! link htmlH1 NeoDimFg
hi! link htmlSpecialChar NeoDimPurple

"}}}2
" JavaScript: {{{2

hi! link javaScriptBraces Delimiter
hi! link javaScriptNumber Constant
hi! link javaScriptNull Constant
hi! link javaScriptFunction NeoDimPink

" Added JavaScript Syntax Highlighting
" Requires vim-javascript
hi! link jsFuncName NeoDimGreen
hi! link jsThis NeoDimCyanItalic
hi! link jsRegexpString NeoDimPurple
hi! link jsFuncCall NeoDimPink
hi! link jsFuncArgs NeoDimOrangeBoldItalic


"}}}2
" Markdown: {{{2

hi! link markdownH1 NeoDimPurpleBold
hi! link markdownH2 markdownH1
hi! link markdownH3 markdownH1
hi! link markdownH4 markdownH1
hi! link markdownH5 markdownH1
hi! link markdownH6 markdownH1
hi! link markdownHeadingDelimiter markdownH1
hi! link markdownHeadingRule markdownH1

hi! link markdownBold NeoDimOrangeBold
hi! link markdownItalic NeoDimYellowItalic
hi! link markdownBoldItalic NeoDimOrangeBoldItalic

hi! link markdownBlockquote NeoDimCyan

hi! link markdownCode NeoDimGreenItalic
hi! link markdownCodeDelimiter NeoDimGreen

hi! link markdownListMarker NeoDimCyan
hi! link markdownOrderedListMarker NeoDimCyan

hi! link markdownRule NeoDimComment

hi! link markdownLinkText NeoDimPink
hi! link markdownUrl NeoDimLink

"}}}2
" Ruby: {{{2

let g:ruby_operators=1
hi! link rubyStringDelimiter NeoDimYellow
hi! link rubyInterpolationDelimiter NeoDimPink
hi! link rubyCurlyBlock NeoDimPink
hi! link rubyBlockParameter NeoDimOrangeItalic
hi! link rubyBlockArgument NeoDimOrangeItalic
hi! link rubyInstanceVariable NeoDimPurpleItalic
hi! link rubyGlobalVariable NeoDimPurple
hi! link rubyRegexpDelimiter NeoDimRed

"}}}2
" YAML: {{{2

hi! link yamlBlockMappingKey NeoDimCyan
hi! link yamlPlainScalar NeoDimYellow
hi! link yamlAnchor NeoDimPinkItalic
hi! link yamlAlias NeoDimGreenItalicUnderline
hi! link yamlNodeTag NeoDimPink
hi! link yamlFlowCollection NeoDimPink
hi! link yamlFlowIndicator Delimiter

"}}}2
" Vim Script: {{{2

hi! link vimOption NeoDimCyanItalic
hi! link vimAutoEventList NeoDimCyanItalic
hi! link vimAutoCmdSfxList NeoDimCyanItalic
hi! link vimSetSep Delimiter
hi! link vimSetMod NeoDimPink
hi! link vimHiBang NeoDimPink
hi! link vimEnvVar NeoDimPurple
hi! link vimUserFunc NeoDimGreen
hi! link vimFunction NeoDimGreen
hi! link vimUserAttrbCmpltFunc NeoDimGreen

"}}}2

"}}}

" vim: fdm=marker ts=2 sts=2 sw=2:

" hi Comment ctermfg=61 ctermbg=NONE cterm=italic guifg=#6272a4 guibg=NONE gui=italic
" hi ErrorMsg ctermfg=16 ctermbg=141 cterm=NONE guifg=#282a36 guibg=#BD93F9 gui=NONE
" hi WarningMsg ctermfg=16 ctermbg=141 cterm=NONE guifg=#282a36 guibg=#BD93F9 gui=NONE

