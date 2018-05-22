module "timeboard_java_beical-app" {
  source            = "../../"
  product_domain    = "BEI"
  cluster           = "beical-app"
  garbage_collector = "PS"
}
