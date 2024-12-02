---
date: 2024-05-03 22:49
---

# Proper Python Logging

After 3 months of working on a project from scratch, I finally understood how to setup a proper logging configuration in Python. Took me long enough but I'm glad I finally got it right. On the other hand, it's frustrating to see how little I was missing...

So, here's what I had:

```python

import logging

def setup_logging(debug: bool):
    logger.setLevel(logging.DEBUG if debug else logging.INFO)

def main():
    args = argparser.parse_args()
    setup_logging(args.debug)
    logger.info("Starting the program...")
    ...
```

Oddly enough, at least for me at the time, I wasn't getting any `logging.info()` calls getting printed to the console. However, if I provided the `--debug` flag to the program, it would print stuff and with the correct level call (`debug`, `info`, `error`, etc). I was puzzled by this behaviour and just had to focus on other parts of the program until recently. As I am finalising the project and I wanted to add proper interaction from the program to the user, `logging.info()` **had** to work.

After many hours... Here's what I was missing:

```python
import logging
import sys


logger = logging.getLogger(__name__)

def setup_logging(debug: bool):
    logging.setLevel(logging.DEBUG if debug else logging.INFO, stream=sys.stdout)

def main():
    args = argparser.parse_args()
    setup_logging(args.debug)
    logger.info("Starting the program...")
    ...
```

Now all calls get printed.

Frustrating to say the least, but often times we encounter these weird challenges where the solution is really that simple.
