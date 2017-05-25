
rcpp_hello_world <- function(){
	.Call("testDllRcpp_rcpp_hello_world", PACKAGE = "testDllRcpp" )
}

