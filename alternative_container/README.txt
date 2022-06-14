ALTERNATIVE SERVER CONTAINER

To build the container image run:

   $ ./build.sh

To start the server run the container:

  $ ./run.sh

Note that the run script runs the container attached to the console.  Ctrl-C
stops the container.  The container itself is not removed and it is started
again next run.

The container mounts the content as an external volume at run-time and any edits
are immediately visible to the server (though users still need to reload
the viewed web-page in their browser).

Because the pyenv configuration is mounted at the run-time, the required SW
is not installed in the image but installed at run-time.  This is also
the reason why container is being preserved between runs.
