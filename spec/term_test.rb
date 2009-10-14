## EXPERIMENTATION

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'color'

Color.bold_underline_blue_on_yellow("This should be formatted the same as the line below")
Color.on_yellow_bold_blue_underline("This should be formatted the same as the line above")