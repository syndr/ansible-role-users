
works from the shell:

```bash
docker run --name test1 -it --read-only --security-opt seccomp=unconfined --hostname imatest --init=false --cgroupns host -v /sys/fs/cgroup/testcontainer.scope:/sys/fs/cgroup:rw --tmpfs /run geerlingguy/docker-${MOLECULE_DISTRO:-rockylinux9}-ansible:latest
```

