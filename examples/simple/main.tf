module "java" {
  source            = "../../"
  product_domain    = "BEI"
  service           = "beical"
  cluster           = "beical-app"
  environment       = "production"
  garbage_collector = "PS"

  recipients = ["slack-bei", "pagerduty-bei", "bei@traveloka.com"]
}
