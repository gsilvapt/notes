---
date: 2024-11-20 10:20
---

# pyinstaller lib issues

As mentioned in previous notes[^1], I was working on a library that was bundled with `pyinstaller`, allegedly for easier distribution. However, later on I found out a very odd error when invoking some of the commands from within that library. Although I cannot share many details, I can say the library invokes some `git` commands, and we started having lots of issues with it as it just didn't work.

`/bin/ssh: symbol lookup error: /lib64/libk5crypto.so.3: undefined symbol: EVP_KDF_ctrl, version OPENSSL_1_1_1b`

The first test I performed was invoking the commands manually in the machine where this runs - and it worked. Thus, seems the culprit would be somewhere on packing and distribution of the library. 

After some research, I found out this type of issues commonly occur when applications expect certain libraries to exist and/or were compiled using different versions of the announced libraries. It came to mind that "compiling" this program in a debian-based image to run in a CentOS-based host was thus **not** a good idea. For that, I rewrote things to build the binary in a CentOS-based image. But it didn't solve the problem, and increased our build times in 3 hours (!!!) because apparently building Python from scratch can be quite expensive.

So I tried compiling the binary directly in the target machine - and it worked.

The prevailing theory is `pyinstaller` bundles all the libraries that it will require to work based on what's available in the machine, which includes low-level libraries:

> The one executable file contains an embedded archive of all the Python modules used by your script, as well as compressed copies of any non-Python support files (e.g. .so files). The bootloader uncompresses the support files and writes copies into the the temporary folder. This can take a little time. That is why a one-file app is a little slower to start than a one-folder app

_From their docs: https://pyinstaller.org/en/stable/operating-mode.html#bundling-to-one-file_

However, the commands my program invokes are OS-based, using Python's `subprocess.run`[^2]. So, it was not bundling `libk5crypto.so` correctly, meaning the bundled binary was expecting libs in different places from the ones in the target machine. 

This BugZilla[^3] issue does resonated a bit, but didn't provide a solution to the problem.


[^1]: https://gsilvapt.github.io/zet/4
[^2]: https://docs.python.org/3/library/subprocess.html#subprocess.run
[^3]: https://bugzilla.redhat.com/show_bug.cgi?id=1829790
