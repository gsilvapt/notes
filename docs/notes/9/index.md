---
date: 2024-06-12 21:57
---

# TIL: QuerySets Over Multiple Tables May Not Return Unique Values

Today I learned that when you query multiple tables in Django, you may not get unique values. This is specially true when the query is somehow crossing over multiple tables (filtering over relationships, for instance) and then doing the joining back in Python.
We have a unit test that started failing after some work and the root cause was a duplicated object, which had me scratching me head for a while.

Then it clicked that this could be the use case of `distinct()` and when I was ready the documentation, I was right - I had see so many `distinct()` calls before but never thought this was the reason. Not sure what I thought really, but had me laughing at myself after figuring out the problem.

While also reviewing things, I learned that we had a mistake in our unit tests that had to be fixed.

References: https://docs.djangoproject.com/en/dev/ref/models/querysets/#django.db.models.query.QuerySet.distinct
