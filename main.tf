resource "datadog_timeboard" "java" {
  title       = "${var.product_domain} - ${var.cluster} - ${var.environment} - Java"
  description = "A generated timeboard for Java"

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
      q    = "max:jvm.heap_memory{$cluster, $environment} by {host}, max:jvm.heap_memory_max{$cluster, $environment} by {host}"
      type = "line"
    }
  }

  graph {
    title     = "Old Gen"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:jmx.java.lang.usage.used{$cluster, $environment,name:g1_old_gen} by {host,name}, avg:jmx.java.lang.usage.used{$cluster, $environment,name:cms_old_gen} by {host,name}, avg:jmx.java.lang.usage.used{$cluster, $environment,name:ps_old_gen} by {host,name}, avg:jmx.java.lang.usage.used{$cluster, $environment,name:tenured-loa} by {host,name}, avg:jmx.java.lang.usage.used{$cluster, $environment,name:tenured-soa} by {host,name}, avg:jmx.java.lang.usage.used{$cluster, $environment,name:balanced-old} by {host,name}, avg:jmx.java.lang.usage.used{$cluster, $environment,name:tenured_gen} by {host,name}",
      type = "line"
    }

    request {
      q    = "avg:jmx.java.lang.usage.max{$cluster, $environment,name:g1_old_gen} by {host,name}, avg:jmx.java.lang.usage.max{$cluster, $environment,name:cms_old_gen} by {host,name}, avg:jmx.java.lang.usage.max{$cluster, $environment,name:ps_old_gen} by {host,name}, avg:jmx.java.lang.usage.max{$cluster, $environment,name:tenured-loa} by {host,name}, avg:jmx.java.lang.usage.max{$cluster, $environment,name:tenured-soa} by {host,name}, avg:jmx.java.lang.usage.max{$cluster, $environment,name:balanced-old} by {host,name}, avg:jmx.java.lang.usage.max{$cluster, $environment,name:tenured_gen} by {host,name}"
      type = "line"
    }
  }

  graph {
    title     = "Metaspace / Perm Gen"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:jmx.java.lang.usage.used{$cluster,$environment,name:metaspace} by {host,name}, avg:jmx.java.lang.usage.used{$cluster,$environment,name:ps_perm_gen} by {host,name}, avg:jmx.java.lang.usage.used{$cluster,$environment,name:cms_perm_gen} by {host,name}"
      type = "line"
    }

    request {
      q    = "avg:jmx.java.lang.usage.max{$cluster,$environment,name:metaspace} by {host,name}, avg:jmx.java.lang.usage.max{$cluster,$environment,name:ps_perm_gen} by {host,name}, avg:jmx.java.lang.usage.max{$cluster,$environment,name:cms_perm_gen} by {host,name}"
      type = "line"
    }
  }

  graph {
    title     = "Eden Space"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:jmx.java.lang.usage.used{$cluster,$environment,name:g1_eden_space} by {host,name}, avg:jmx.java.lang.usage.used{$cluster,$environment,name:par_eden_space} by {host,name}, avg:jmx.java.lang.usage.used{$cluster,$environment,name:ps_eden_space} by {host,name}, avg:jmx.java.lang.usage.used{$cluster,$environment,name:nursery-allocate} by {host,name}, avg:jmx.java.lang.usage.used{$cluster,$environment,name:balanced-eden} by {host,name}, avg:jmx.java.lang.usage.used{$cluster,$environment,name:eden_space} by {host,name}",
      type = "line"
    }

    request {
      q    = "avg:jmx.java.lang.usage.max{$cluster,$environment,name:g1_eden_space} by {host,name}, avg:jmx.java.lang.usage.max{$cluster,$environment,name:par_eden_space} by {host,name}, avg:jmx.java.lang.usage.max{$cluster,$environment,name:ps_eden_space} by {host,name}, avg:jmx.java.lang.usage.max{$cluster,$environment,name:nursery-allocate} by {host,name}, avg:jmx.java.lang.usage.max{$cluster,$environment,name:balanced-eden} by {host,name}, avg:jmx.java.lang.usage.max{$cluster,$environment,name:eden_space} by {host,name}",
      type = "line"
    }

  }

  graph {
    title     = "Survivor Space"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:jmx.java.lang.usage.used{$cluster,$environment,name:g1_survivor_space} by {host,name}, avg:jmx.java.lang.usage.used{$cluster,$environment,name:par_survivor_space} by {host,name}, avg:jmx.java.lang.usage.used{$cluster,$environment,name:ps_survivor_space} by {host,name}, avg:jmx.java.lang.usage.used{$cluster,$environment,name:nursery-survivor} by {host,name}, avg:jmx.java.lang.usage.used{$cluster,$environment,name:balanced-survivor} by {host,name}, avg:jmx.java.lang.usage.used{$cluster,$environment,name:survivor_space} by {host,name}",
      type = "line"
    }

    request {
      q    = "avg:jmx.java.lang.usage.max{$cluster,$environment,name:g1_survivor_space} by {host,name}, avg:jmx.java.lang.usage.max{$cluster,$environment,name:par_survivor_space} by {host,name}, avg:jmx.java.lang.usage.max{$cluster,$environment,name:ps_survivor_space} by {host,name}, avg:jmx.java.lang.usage.max{$cluster,$environment,name:nursery-survivor} by {host,name}, avg:jmx.java.lang.usage.max{$cluster,$environment,name:balanced-survivor} by {host,name}, avg:jmx.java.lang.usage.max{$cluster,$environment,name:survivor_space} by {host,name}",
      type = "line"
    }
  }

  graph {
    title     = "Minor GC Count per Minute"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "diff(avg:jmx.java.lang.collection_count{$cluster,$environment,name:parnew} by {host,name}), diff(avg:jmx.java.lang.collection_count{$cluster,$environment,name:g1_young_generation} by {host,name}), diff(avg:jmx.java.lang.collection_count{$cluster,$environment,name:ps_scavenge} by {host,name}), diff(avg:jmx.java.lang.collection_count{$cluster,$environment,name:scavenge} by {host,name}), diff(avg:jmx.java.lang.collection_count{$cluster,$environment,name:partial_gc} by {host,name}), diff(avg:jmx.java.lang.collection_count{$cluster,$environment,name:copy} by {host,name})",
      type = "line"
    }
  }

  graph {
    title     = "Minor GC Time"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "diff(avg:jvm.gc.parnew.time{$cluster,$environment,name:parnew} by {host,name}), diff(avg:jvm.gc.parnew.time{$cluster,$environment,name:g1_young_generation} by {host,name}), diff(avg:jmx.java.lang.collection_time{$cluster,$environment,name:parnew} by {host,name}), diff(avg:jmx.java.lang.collection_time{$cluster,$environment,name:g1_young_generation} by {host,name}), diff(avg:jmx.java.lang.collection_time{$cluster,$environment,name:ps_scavenge} by {host,name}), diff(avg:jvm.gc.parnew.time{$cluster,$environment,name:ps_scavenge} by {host,name}), diff(avg:jvm.gc.parnew.time{$cluster,$environment,name:scavenge} by {host,name}), diff(avg:jvm.gc.parnew.time{$cluster,$environment,name:partial_gc} by {host,name}), diff(avg:jvm.gc.parnew.time{$cluster,$environment,name:copy} by {host,name})",
      type = "line"
    }
  }

  graph {
    title     = "Major GC Count per Minute"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "diff(avg:jmx.java.lang.collection_count{$cluster,$environment,name:concurrentmarksweep} by {host,name}), diff(avg:jmx.java.lang.collection_count{$cluster,$environment,name:g1_old_generation} by {host,name}), diff(avg:jmx.java.lang.collection_count{$cluster,$environment,name:ps_marksweep} by {host,name}), diff(avg:jmx.java.lang.collection_count{$cluster,$environment,name:global} by {host,name}), diff(avg:jmx.java.lang.collection_count{$cluster,$environment,name:global_garbage_collect} by {host,name}), diff(avg:jmx.java.lang.collection_count{$cluster,$environment,name:marksweepcompact} by {host,name})",
      type = "line"
    }
  }

  graph {
    title     = "Major GC Time"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "diff(avg:jvm.gc.parnew.time{$cluster,$environment,name:concurrentmarksweep} by {host}), diff(avg:jvm.gc.parnew.time{$cluster,$environment,name:g1_old_generation} by {host}), diff(avg:jmx.java.lang.collection_time{$cluster,$environment,name:g1_old_generation} by {host}), diff(avg:jmx.java.lang.collection_time{$cluster,$environment,name:concurrentmarksweep} by {host}), diff(avg:jmx.java.lang.collection_time{$cluster,$environment,name:ps_marksweep} by {host}), diff(avg:jvm.gc.parnew.time{$cluster,$environment,name:ps_marksweep} by {host}), diff(avg:jvm.gc.parnew.time{$cluster,$environment,name:global} by {host}), diff(avg:jvm.gc.parnew.time{$cluster,$environment,name:global_garbage_collect} by {host}), diff(avg:jvm.gc.parnew.time{$cluster,$environment,name:marksweepcompact} by {host})",
      type = "line"
    }
  }

  graph {
    title     = "Thread Runnable (Not Mandatory)"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:Thread.RUNNABLE{$cluster, $environment} by {host,threadname}"
      type = "line"
    }
  }

  graph {
    title     = "Thread Blocked (Not Mandatory)"
    viz       = "timeseries"
    autoscale = true

    request {
      q    = "avg:Thread.BLOCKED{$cluster, $environment} by {host,threadname}"
      type = "line"
    }
  }

  graph {
    title     = "ScheduledExecutor Queue Count (Not Mandatory)"
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
    custom_unit = "S"
    precision = 0

    request {
      q    = "avg:warmup.elapsedTime{success:true,appgroup:${var.service}} by {host}"
      type = "bars"
      conditional_format {
        comparator = "<"
        value       = 120000
        palette     = "white_on_green"
      }
      conditional_format {
        comparator = "<"
        value       = 180000
        palette     = "white_on_yellow"
      }
      conditional_format {
        comparator = ">"
        value       = 300000
        palette     = "white_on_red"
      }
    }
  }
}
