" rainbowbrackets.vim
" Author: Eiichi Sato <sato.eiichi@gmail.com>
" License: MIT license
"   Permission is hereby granted, free of charge, to any person obtaining
"   a copy of this software and associated documentation files (the
"   "Software"), to deal in the Software without restriction, including
"   without limitation the rights to use, copy, modify, merge, publish,
"   distribute, sublicense, and/or sell copies of the Software, and to
"   permit persons to whom the Software is furnished to do so, subject to
"   the following conditions:
"
"   The above copyright notice and this permission notice shall be included
"   in all copies or substantial portions of the Software.
"
"   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

if !exists('g:rainbowbrackets_maxlevel')
	let g:rainbowbrackets_maxlevel = 15
endif

if !exists('g:rainbowbrackets_colors')
	let g:rainbowbrackets_colors =
				\ [
				\	'ctermfg=red',
				\	'ctermfg=green',
				\	'ctermfg=yellow',
				\	'ctermfg=blue',
				\	'ctermfg=magenta',
				\ ]
endif

if !exists('g:rainbowbrackets_enable_round_brackets')
	let g:rainbowbrackets_enable_round_brackets = 1
endif

if !exists('g:rainbowbrackets_enable_square_brackets')
	let g:rainbowbrackets_enable_square_brackets = 0
endif

if !exists('g:rainbowbrackets_enable_curly_brackets')
	let g:rainbowbrackets_enable_curly_brackets = 0
endif

if !exists('g:rainbowbrackets_enable_angle_brackets')
	let g:rainbowbrackets_enable_angle_brackets = 0
endif

" {{{ functions

function! s:buffer_default_from_global(variable)
	if !exists('b:'.a:variable)
		execute 'let' 'b:'.a:variable '=' 'g:'.a:variable
	endif
endfunction

function! s:buffer_defaults_from_global()
	call s:buffer_default_from_global('rainbowbrackets_enable_round_brackets')
	call s:buffer_default_from_global('rainbowbrackets_enable_square_brackets')
	call s:buffer_default_from_global('rainbowbrackets_enable_curly_brackets')
	call s:buffer_default_from_global('rainbowbrackets_enable_angle_brackets')
endfunction

function! s:highlight()
	for level in range(1, g:rainbowbrackets_maxlevel)
		let color = g:rainbowbrackets_colors[(level - 1) % len(g:rainbowbrackets_colors)]
		execute 'highlight default bracketlevel'.level color
	endfor
endfunction

function! s:definebrace(start, end)
	let containlevels = []
	for level in range(1, g:rainbowbrackets_maxlevel)
		call add(containlevels, '_bracketlevel'.level)
	endfor
	for level in range(1, g:rainbowbrackets_maxlevel)
		execute 'syntax region _bracketlevel'.level 'matchgroup=bracketlevel'.level 'start=/'.a:start.'/' 'end=/'.a:end.'/'
					\ 'contains=TOP,'.join(containlevels, ',')
		call remove(containlevels, 0)
	endfor
endfunction

" }}}
" {{{ autoload functions

function! rainbowbrackets#oncolorscheme()
	call s:highlight()
endfunction

function! rainbowbrackets#clear()
	for level in range(1, g:rainbowbrackets_maxlevel)
		execute 'silent! syntax clear _bracketlevel'.level
	endfor
endfunction

function! rainbowbrackets#update()
	" load default value
	call s:buffer_defaults_from_global()

	" reset syntax
	call rainbowbrackets#clear()

	if b:rainbowbrackets_enable_round_brackets
		call s:definebrace('(', ')')
	endif

	if b:rainbowbrackets_enable_square_brackets
		call s:definebrace('\[', '\]')
	endif

	if b:rainbowbrackets_enable_curly_brackets
		call s:definebrace('{', '}')
	endif

	if b:rainbowbrackets_enable_angle_brackets
		call s:definebrace('<', '>')
	endif

	" apply highlight
	call s:highlight()
endfunction

" }}}
