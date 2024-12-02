---
date: 2024-06-11 20:08
---

# Use bulks, please


In a recent change we were performing, we needed to update our database records in a magnitude of hundreds of thousands. Did so many things before, twisted and squeeze the hell out of Django's ORM (might not be the best in the industry, but it is what it is). Our deployment pipelines were failing because the migrations would either time out or just take forever to finish, causing locks and other bottlenecks in the applications.

It got to a point I just grew out of it and went with `bulk_create()` and `bulk_update` where needed. `update_or_create()` performs two queries under the hood, this runs one for all creates and all updates. It assumes no object or all objects exist, respectively, and there are some options to find the middle ground there too, like `ignore_conflicts` in case of `bulk_create`. This also assumes good database architecture and defaults, meaning unique constraints are properly followed and implemented in a way that will not interfere when running the bulks.

Performance-wise, it went from 5 minutes to 5 seconds locally, from a never-ending change in production to 20 minutes.

Add `batch_size` if you're concerned and want to somehow throttle the number of objects that are created/updated.

Refs: [https://docs.djangoproject.com/en/5.0/ref/models/querysets/#bulk-create](https://docs.djangoproject.com/en/5.0/ref/models/querysets/#bulk-create)
