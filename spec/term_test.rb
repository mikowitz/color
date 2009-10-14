## EXPERIMENTATION

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'color'

Color.blue("hello")
Color.cyan_on_red("hello", false)
Color.bold("whatever")
Color.bold_underline_on_red_yellow("what?")