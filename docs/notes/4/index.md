---
date: 2024-05-03 22:58
---

# `Pyinstaller` for Python apps bundling

I'm working on a project that will run on plethora of systems and for a long time I knew one of the most hated things about Python is it's dependency system and the hassle of preparing a safe environment without messing with your system's installation. There are many tools to ease this off, like `poetry`, `pipenv`, `virtualenv`, `pyenv`, etc but they all require you to still control and maintain a dependency file somewhere, install in the systems you want your application to run and so on. Sometimes all we want from our programs is to simply run.

In addition, sometimes our programs will run in systems we have minimal or no control of at all. Hence, being able to run a program without worrying about it's dependencies is a nice feature. This is one of the things I really love about `Go`'s standard tooling, where you get a binary with everything bundled in and ready to run - dependency free. After some investigations, I found out about [`pyinstaller`](https://www.pyinstaller.org/), a tool that bundles a Python application and all its dependencies into a single package.

At first glance, I thought this was going to work regardless of the Python installation in the system - just a single "binary" users could run like anything else in the `$PATH` and voilá. Well, it wasn't that simple, but the other requirements were still met by this library. Despite requiring a Python installation in the system which your program supports, which I found later when I was trying to run a Python 3.12 application in a system that only had Python 3.8 installed, all dependencies are bundled and shipped together.

`pyinstaller` docs are great and will let you be self-sufficient for your use cases - no need to explain what I need as it was really simple. One note is that `pyinstaller`'s will build a file for the platform you're building from (so, x86_64 linux will only work in x86_64 linux, arm will work in arm, etc) but this is a limitation I can live with. On my development machine I can generate and run the ARM builds, and the project's pipelines take care of building and publishing the binaries for the systems where they will run.

The main advantage in my perspective is that everything gets bundled into a single executable and you don't need to care about environments, dependencies and what-not. _Perhaps_ this will lead to a bigger file size, but it's a trade-off I'm willing to take for the sake of simplicity during deployments.
