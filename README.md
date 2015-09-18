## IJulia Container

A Docker image that runs [Jupyter Notebook](http://jupyter.org/) with support for
the [Julia language] for technical computing.

### How to Use

```console
$ docker run -it -p 8888:8888 mboersma/ijulia
```

Then open your browser to http://<docker bridge ip>:8888/ and create a Julia notebook.
