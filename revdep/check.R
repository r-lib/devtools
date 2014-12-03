library("devtools")

# Suggesting devtools probably just means that they're using it for
# development, so we're probably save skipping them.
res <- revdep_check(dependencies = c("Depends", "Imports"))

writeLines(revdep_check_summary(res), "revdep/summary.md")
revdep_check_save_logs(res)
