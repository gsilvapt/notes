---
date: 2024-05-15 16:19
---

# Django and Reverse M2M Relationship Filter

While working on a project today, I learnt it's possible to execute reverse many-to-many relationship filters directly in Django.

```Python

from django.db import models

class Author(models.Model):
    name = models.CharField(max_length=100)

class Tag(models.Model):
    name = models.CharField(max_length=100)
    author = models.ForeignKey('Author', on_delete=models.CASCADE)

class Post(models.Model):
    title = models.CharField(max_length=100)
    tags = models.ManyToManyField(Tag)
```

In a scenario you need to find all posts with tags created by user, you can do the following:

```Python
post = Post.objects.filter(tags__author__name="author_name")
```

Much better and cleaner than chaining different querysets, right? SQL-wise, it also seems more efficient. The only thing that is missing there is the `prefetch_related` which again can be added to the queryset to avoid the N+1 problem:

```Python
post = Post.objects.filter(tags__author__name="tag_name").prefetch_related('tags_set__author')
```

The addition there is the `_set` which is the default name for the reverse relation lookups.
