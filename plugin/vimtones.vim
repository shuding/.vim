let g:iTunesVolume = 0.0

function! PlaySound()
    if g:vimtonesTurnOn == 1
        if g:vimtonesChangeVol == 1
            call BackGroundMusic()
        endif
        if g:vimtonesPlaySound == 1
            silent! exec '!afplay -v 0.5 ~/.vim/vimtones/mp3/key.mp3 &'
        endif
    endif
endfunction
autocmd CursorMovedI * call PlaySound()
autocmd CursorMoved * call PlaySound()

let g:pressCnt = 0

function! BackGroundMusic()
    let timeNow = str2float(reltimestr(reltime()))
    let vol = timeNow - g:lastinputTime
    let g:pressCnt += 1
    if vol < 1.5
        return
    endif
    let vol = 2 * g:pressCnt / vol
    if g:iTunesVolume < vol
"        echo '+'
        let g:iTunesVolume += 0.5
        silent! exec "!osascript -e 'set Volume ".printf('%f', g:iTunesVolume)."'"
    endif
    if g:iTunesVolume > vol
"        echo '-'
        let g:iTunesVolume -= 0.5
        silent! exec "!osascript -e 'set Volume ".printf('%f', g:iTunesVolume)."'"
    endif
    let g:lastinputTime = timeNow 
    let g:pressCnt = 0
endfunction
