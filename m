From: David Howells <dhowells@redhat.com>
Date: Wed, 01 Aug 2018 22:50:53 +0000
Subject: Re: LSM hook for mount, superblock and keys watch notifications
Message-Id: <19025.1533163853@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <83894922-c126-3648-d2f5-191256111718@schaufler-ca.com> <675e5c24-36ef-4cc5-846c-1414c1195d85@schaufler-ca.com> <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk> <7561.1533157444@warthog.procyon.org.uk>
In-Reply-To: <83894922-c126-3648-d2f5-191256111718@schaufler-ca.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, raven@themaw.net, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> This looks like it will solve the problem for security modules.
> I still think there should be some sort of default controls.

The control for keyrings is that you have to have View permission on the thing
you want to set a watchpoint on.

For mount topology changes, everyone can see everything in their namespace
anyway just by repeatedly parsing /proc/mounts or similar.  Whether or not
this is a good idea...

Superblocks - some of the things generated here *shouldn't* be hidden - EIO
for example.

> The idea that the default is that anyone can listen for everyone's
> events, and there's no way to control it does not sit well.
> You could implement that as a security module with the one hook
> that does UID based controls, but I don't see a lot of advantages
> to doing it that way. At the least a process should be able to hide
> the events it would generate from everyone.

That's tricky.  Some of the events aren't actually generated directly by a
process stepping on a trigger - EIO for example.  Further, none of the
interfaces available have a "don't notify" button.  Now I can add one to
move_mount() and fsmount(), but not write() (which might cause EDQUOT or
ENOSPC errors that we might want to know about irrespective of what the user
wants).

> Better would be to have a specification (e.g. mod bits, an ACL) for who
> should receive them.

How does one attach this, and to where?  It doesn't belong to the watch queue,
it belongs to the watched object.  It would also need attaching before the
object gets published.

If you're using fsopen(), you could attach it before doing fsmount() to set an
ACL on a superblock, I suppose:

	fd = fsopen("ext4", 0);
	fsconfig(fd, FSCONFIG_SET_NAMESPACE, "user", NULL, userns_fd);
	fsconfig(fd, FSCONFIG_SET_SB_ACL, NULL, "0:pw,1000:w", 0);
	fsconfig(fd, FSCONFIG_SET_PATH, "source", "/dev/sda1", AT_FDCWD);
	fsconfig(fd, FSCONFIG_SET_FLAG, "acl", NULL, 0);
	mfd = fsmount(0, 0);

where 0 and 1000 are uids and [pw] indicate pickability and watchability, with
the former allowing the use of fspick() with it:

	fd = fspick(AT_FDCWD, "/mnt", 0);

or, even:

	fd = fspick(0, "6f9553ab-7329-4998-bd5b-a5b4add9ad79",
		    FSPICK_OPEN_BY_UUID);

I'm not sure how you'd attach an ACL to mount objects, though.  I guess
move_mount() would have to take a 6th parameter that's the ACL.  You wouldn't
necessarily be able to use the same ACL for both mount and superblock because
of namespaces - it should be possible to have a superblock that's in multiple
user namespace (though it currently isn't).

David
