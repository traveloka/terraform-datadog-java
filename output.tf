output "timeboard_title" {
  value       = "${var.garbage_collector == "CMS" ? join(",", datadog_timeboard.java_cms.*.title) : join(",", datadog_timeboard.java_ps.*.title)}"
  description = "The title of datadog timeboard for Java"
}
