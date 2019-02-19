From: Tycho Andersen <tycho@tycho.ws>
Date: Tue, 19 Feb 2019 23:55:37 +0000
Subject: Re: [RFC PATCH 02/27] containers: Implement containers as kernel objects
Message-Id: <20190219235537.GC5274@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
 <155024685321.21651.1504201877881622756.stgit@warthog.procyon.org.uk>
In-Reply-To: <155024685321.21651.1504201877881622756.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, trond.myklebust@hammerspace.com, sfrench@samba.org, linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, rgb@redhat.com, linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 04:07:33PM +0000, David Howells wrote:
> =========
> FUTURE DEVELOPMENT
> =========
> 
>  (1) Setting up the container.
> 
>      A container would be created with, say:
> 
> 	int cfd = container_create("fred", CONTAINER_NEW_EMPTY_FS_NS);
> 

...

>      Further mounts can be added by:
> 
> 	move_mount(mfd, "", cfd, "proc", MOVE_MOUNT_F_EMPTY_PATH);
> 

...

>  (2) Starting the container.
> 
>      Once all modifications are complete, the container's 'init' process
>      can be started by:
> 
> 	fork_into_container(int cfd);
> 
>      This precludes further external modification of the mount tree within
>      the container.

Is there a technical reason for this? In particular, there are some
container runtimes that do this today via clever use of bind mounts
and MS_MOVE, for things like dynamically attaching volumes. It would
be useful to be able to mount things into the container after the
fact.

>  (3) Waiting for the container to complete.
> 
>      The container fd can then be polled to wait for init process therein
>      to complete and the exit code collected by:
> 
> 	container_wait(int container_fd, int *_wstatus, unsigned int wait,
> 		       struct rusage *rusage);
> 
>      The container and everything in it can be terminated or killed off:
> 
> 	container_kill(int container_fd, int initonly, int signal);
> 
>      If 'init' dies, all other processes in the container are preemptively
>      SIGKILL'd by the kernel.

Isn't this essentially how the pid ns works today? I'm not sure what
the container fd offers here (of course if it lands, then having the
same semantics makes sense).

>  (6) Running different LSM policies by container.  This might particularly
>      make sense with something like Apparmor where different path-based
>      rules might be required inside a container to inside the parent.

Apparmor supports this today, as long as the host is also running
Apparmor. For the more general case, Casey (and others) have been
working on LSM stacking for a long time.

Tycho
