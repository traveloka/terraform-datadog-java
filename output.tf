output "timeboard_title" {
  value       = "${datadog_timeboard.java.*.title}"
  description = "The title of datadog timeboard for Java"
}
