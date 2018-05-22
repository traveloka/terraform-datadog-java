resource "datadog_timeboard" "java_cms" {
  count       = "${var.garbage_collector == "CMS" ? 1 : 0}"
  title       = "${var.product_domain} - ${var.cluster} - Java CMS"
  description = "A generated timeboard for Java CMS"

  template_variable {
    default = "${var.cluster}"
    name    = "cluster"
    prefix  = "cluster"
  }

  graph {
    title     = "Heap Memory"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "max:jvm.heap_memory{$cluster} by {host}"
      type = "line"
    }

    request {
      q    = "max:jvm.heap_memory_max{$cluster} by {host}"
      type = "line"
    }
  }

  graph {
    title     = "Old Gen"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:jmx.java.lang.usage.used{$cluster,name:cms_old_gen} by {host}"
      type = "line"
    }

    request {
      q    = "avg:jmx.java.lang.usage.max{$cluster,name:cms_old_gen} by {host}"
      type = "line"
    }
  }

  graph {
    title     = "Perm Gen"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:jmx.java.lang.usage.used{$cluster,name:cms_perm_gen} by {host}"
      type = "line"
    }

    request {
      q    = "avg:jmx.java.lang.usage.max{$cluster,name:cms_perm_gen} by {host}"
      type = "line"
    }
  }

  graph {
    title     = "Survivor Space"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:jmx.java.lang.usage.used{$cluster,name:par_survivor_space} by {host}"
      type = "line"
    }

    request {
      q    = "avg:jmx.java.lang.usage.max{$cluster,name:par_survivor_space} by {host}"
      type = "line"
    }
  }

  graph {
    title     = "GC Concurrent Marksweep Count per Minute"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "per_minute(avg:jmx.java.lang.collection_count{$cluster,name:concurrentmarksweep} by {host,name})"
      type = "line"
    }
  }

  graph {
    title     = "GC Parnew Count per Minute"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "per_minute(avg:jmx.java.lang.collection_count{$cluster,name:parnew} by {host,name})"
      type = "line"
    }
  }

  graph {
    title     = "Thread Runnable"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:Thread.RUNNABLE{$cluster} by {host,threadname}"
      type = "line"
    }
  }

  graph {
    title     = "Thread Blocked"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:Thread.BLOCKED{$cluster} by {host,threadname}"
      type = "line"
    }
  }

  graph {
    title     = "ScheduledExecutor Queue Count"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:ScheduledExecutor.QueuedCount{$cluster} by {host,threadname}"
      type = "line"
    }
  }
}
