## Define a graph of classes with complex inheritance pattern
## example taken from wikipedia:
## https://en.wikipedia.org/wiki/Topological_sorting#Examples

setClass("A")
setClass("B")
setClass("C")
setClassUnion("D", members = c("A", "B", "C"))
setClass("E")
setIs("B", "E")
setClassUnion("F", members = c("D", "E"))
setClass("G")
setIs("D", "G")
setClassUnion("H", members = c("C", "E"))
