---
date: 2024-12-06 15:41
---

# Mocking full classes in Python

In a project I am working on, I wanted to mock an entire class which comprehends a wrapper for API calls to a service.
This class is tested thoroughly on its own package and I'm against performing network calls in unit tests, precisely and that could clutter up a real instance with garbage from automated tests.

This is a classic use case for mocks[^1]. You want to isolate a part of your program's behavior.

Python, the language of the project, has a very nice library for mocking and stubbing[^2]. It does so much, I am not going to even start covering it in this post.

But let's do a quick dummy example to showcase the intention:


```python
# a.py
class MyAPI:
    def does_something(self):
        """Does something really cool that you want to abstract from your tests"""
        pass

    def does_something_else(self):
        """Does something else even cooler but you still want to abstract from your tests"""
        pass

# b.py
def main():
    # something happens
    api = MyAPI()
    api.does_something()
    # something else happens
    api.does_something_selse()
    return 1


# tests.py
from unittest import TestCase
from unittest.mock import patch


class MyAPITests(unittest.TestCase):

    @patch("a.MyAPI")
    def test_it_does_something(self, my_mock):
        assert b.main() == 1
```

In a nutshell, the contrived example just makes an object available and we want to test only the main of our `b.py` file.

I find it a good practice, however, to still ensure the methods of the mocked classed are called. If your code's logic deviates and suddenly you are no longer performing the second call, for instance as you are returning earlier, your program is likely bugged. You still don't care about the mocked behaviour, you just want to ensure it's called each time.

For that, your test code must change, because the classic patch does not include the spec[^3] and this is the only way you can obtain a list of functions called through your mock - spec goes even further by ensuring the method signatures add up, for instance, which I find amazing.

```python
@patch("a.MyAPI", autospec=True)
def test_it_does_something(self, my_mock):
    assert b.main() == 1
    assert len(my_mock.method_calls) == 2
```

In the second snippet, we are ensuring there were two method calls against our `my_mock` object. This ensures the business requirement of performing those actions is there, even though we are ignoring if they are done correctly. This isn't integration tests anyway, so I find this a quite decent way to write the test in this scenario.

Needless to say I spent a few hours trying to understand why without `autospec` I wasn't able to reliably get the list of calls from the `Mock` :))


[^1]: https://martinfowler.com/articles/mocksArentStubs.html
[^2]: https://docs.python.org/3/library/unittest.mock.html
[^3]: https://docs.python.org/3/library/unittest.mock.html#unittest.mock.patch
