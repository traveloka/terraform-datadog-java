locals {
  java_cms_monitor_enabled = "${var.enabled && var.garbage_collector == "CMS" && length(var.recipients) > 0 ? 1 : 0}"
}

resource "datadog_timeboard" "java_cms" {
  count       = "${var.garbage_collector == "CMS" ? 1 : 0}"
  title       = "${var.product_domain} - ${var.cluster} - ${var.environment} - Java CMS"
  description = "A generated timeboard for Java CMS"

  template_variable {
    default = "${var.cluster}"
    name    = "cluster"
    prefix  = "cluster"
  }

  template_variable {
    default = "${var.environment}"
    name    = "environment"
    prefix  = "environment"
  }

  graph {
    title     = "Heap Memory"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "max:jvm.heap_memory{$cluster, $environment} by {host}"
      type = "line"
    }

    request {
      q    = "max:jvm.heap_memory_max{$cluster, $environment} by {host}"
      type = "line"
    }
  }

  graph {
    title     = "Old Gen"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:jmx.java.lang.usage.used{$cluster, $environment,name:cms_old_gen} by {host}"
      type = "line"
    }

    request {
      q    = "avg:jmx.java.lang.usage.max{$cluster, $environment,name:cms_old_gen} by {host}"
      type = "line"
    }
  }

  graph {
    title     = "Perm Gen"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:jmx.java.lang.usage.used{$cluster, $environment,name:cms_perm_gen} by {host}"
      type = "line"
    }

    request {
      q    = "avg:jmx.java.lang.usage.max{$cluster, $environment,name:cms_perm_gen} by {host}"
      type = "line"
    }
  }

  graph {
    title     = "Survivor Space"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:jmx.java.lang.usage.used{$cluster, $environment,name:par_survivor_space} by {host}"
      type = "line"
    }

    request {
      q    = "avg:jmx.java.lang.usage.max{$cluster, $environment,name:par_survivor_space} by {host}"
      type = "line"
    }
  }

  graph {
    title     = "GC Concurrent Marksweep Count per Minute"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "per_minute(avg:jmx.java.lang.collection_count{$cluster, $environment,name:concurrentmarksweep} by {host,name})"
      type = "line"
    }
  }

  graph {
    title     = "GC Parnew Count per Minute"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "per_minute(avg:jmx.java.lang.collection_count{$cluster, $environment,name:parnew} by {host,name})"
      type = "line"
    }
  }

  graph {
    title     = "Thread Runnable"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:Thread.RUNNABLE{$cluster, $environment} by {host,threadname}"
      type = "line"
    }
  }

  graph {
    title     = "Thread Blocked"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:Thread.BLOCKED{$cluster, $environment} by {host,threadname}"
      type = "line"
    }
  }

  graph {
    title     = "ScheduledExecutor Queue Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:ScheduledExecutor.QueuedCount{$cluster, $environment} by {host,threadname}"
      type = "line"
    }
  }

  graph {
    title     = "Avg Warm Up Per Host"
    viz       = "query_value"
    autoscale = false

    request {
      q    = "avg:warmup.elapsedTime{success:true,appgroup:$service} by {host}/1000"
      type = "bars"
    }
  } 
}
