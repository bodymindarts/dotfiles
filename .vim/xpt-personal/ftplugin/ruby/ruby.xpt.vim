XPTemplate priority=personal

let s:f = g:XPTfuncs()

XPTinclude
    \ _common/common

fun! s:f.rubyClassName()
    return self.RubyCamelCase(substitute(self.file(), '\v(_spec)?.rb', '', ''))
endfun

XPT spec hint=rspec\ template
require '`spec_helper^'

describe `rubyClassName()^ do
  it '`explanation^' do
    `cursor^
  end
end

XPT it hint=rspec\ it\ block
it '`explanation^' do
  `cursor^
end

XPT let hint=rspec\ let
XSET var|post=RubySnakeCase()
let(:`var^) { `cursor^ }

XPT clas hint=ruby\ class
class `rubyClassName()^
  `cursor^
end
