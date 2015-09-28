Building the container:
---
Nothing special here, the following command will build this container.
```
$ docker build -t cturra/dropbox .
```

Running the container
---
The below example Docker run command can be used to run this container. I
specifically choose to limit the memory available to dropbox because it
can get rather greedy with it ;)
```
$ docker run --name=dropbox --net=host --memory=512M \
  -v /data/dropbox:/dropbox:rw -d cturra/dropbox
```

Another note, the first time you run this, you'll need to link the container
to your dropbox account. If you check out the supervisor logs, located within
your volume mount (from the example above that would be `/data/dropbox/logs/`)
you should see a message like:
```
This computer isn't linked to any Dropbox account...
Please visit https://www.dropbox.com/cli_link_nonce?nonce=90084227dc5340d88136f436c5be18fb
to link this device.
```

Simply copy that link into your browser and complete the linking process. After
you've done this the first time, subsequent runs shouldn't prompt you for this.

Note that the container expects /docker to look like this:

```
├── dropbox
│   ├── Dropbox
│   └── logs
│       └── supervisor
```

You can use the following command as an example to create this structure:

```
mkdir -p /data/dropbox/Dropbox /data/dropbox/logs/supervisor
```

Help
---
If you see this warning warning when running this container...
```
WARNING: Your kernel does not support swap limit capabilities, memory limited
without swap.
```

Check out the "Adjust memory and swap accounting" section of the Docker
installation documents:

 https://docs.docker.com/installation/ubuntulinux/#adjust-memory-and-swap-accounting
