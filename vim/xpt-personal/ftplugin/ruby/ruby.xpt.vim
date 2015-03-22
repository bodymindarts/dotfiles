XPTemplate priority=personal

let s:f = XPTfuncs()

fun! s:f.classNameFromSpecFile()
    let name = substitute(expand('%:t'), '_spec.rb', '', '')
    return substitute(name, '\v(^|_)(\a)', '\u\2', 'g')
endfun

XPT req abbr hint=require\ '...'
require '`lib^'

XPT spec hint=rspec\ template
require '`spec_helper^'

describe `classNameFromSpecFile()^ do
  it '`explanation^' do
    `cursor^
  end
end

XPT it hint=rspec\ it\ block
it '`explanation^' do
  `cursor^
end

XPT let hint=rspec\ let
let(:`var^) { `cursor^ }
