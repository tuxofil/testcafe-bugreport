# Steps-to-reproduce for TestCafe bug report

## Summary

Since 3.0.0 TestCafe doesn't honor `--proxy` command line switch.

## How to reproduce

Run [tinyproxy](https://github.com/tinyproxy/tinyproxy) and [TestCafe](https://github.com/DevExpress/testcafe)
inside a Docker container, then dump proxy server logs to the stdout.

To test with specific version of TestCafe, type:

```
make VERSION=$VERSION
```

For instance, launching `make VERSION=2.6.2` shows that proxy server accepted a connection
and forwarded the request to the target HTTP server.

But running `make VERSION=3.0.0` shows that proxy server just initializes itself, without
accepting any incoming connections.
