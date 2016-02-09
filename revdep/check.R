library("devtools")

revdep_check(dependencies = c("Imports", "Depends"))
revdep_check_save_summary()
revdep_check_print_problems()
