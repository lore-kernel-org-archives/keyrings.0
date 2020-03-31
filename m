From: David Howells <dhowells@redhat.com>
Date: Tue, 31 Mar 2020 21:23:50 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <2415896.1585689830@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <2415050.1585689255@warthog.procyon.org.uk> <CAJfpegtn1A=dL9VZJQ2GRWsOiP+YSs-4ezE9YgEYNmb-AF0OLA@mail.gmail.com> <1445647.1585576702@warthog.procyon.org.uk> <CAJfpegvZ_qtdGcP4bNQyYt1BbgF9HdaDRsmD43a-Muxgki+wTw@mail.gmail.com> <2294742.1585675875@warthog.procyon.org.uk>
In-Reply-To: <2415050.1585689255@warthog.procyon.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dhowells@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, Christian Brauner <christian.brauner@ubuntu.com>, Lennart Poettering <mzxreary@0pointer.de>, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> > So even the p2 method will give at least 80k queries/s, which is quite
> > good, considering that the need to rescan the complete mount tree
> > should be exceedingly rare (and in case it mattered, could be
> > optimized by priming from /proc/self/mountinfo).
> 
> One thing to note is that the test is actually a little biased in favour of
> the "p" test, where the mnt_id is looked up by path from /proc/fdinfo.  That's
> not all that useful, except as an index into mountfs.  I'm not sure how much
> use it as a check on whether the mount is the same mount or not since mount
> IDs can get reused.

However, to deal with an overrun, you're going to have to read multiple
attributes.  So I've added an attribute file to expose the topology change
counter and it now reads that as well.

For 10000 mounts, f=22899us f2=18240us p=101054us p2=117273us <-- prev email
For 10000 mounts, f=24853us f2=20453us p=235581us p2= 59798us <-- parent_id
For 10000 mounts, f=24621us f2=20528us p=320164us p2=111416us <-- counter

Probably unsurprisingly, this doesn't affect fsinfo() significantly since I've
tried to expose the change counters in relevant places.  It does, however,
significantly affect mountfs because you seem to want every value to be
exposed through its own file.

Now this can be worked around by having files that bundle up several values
that are of interest to a particular operation (e.g. rescanning after a
notification queue overrun).

See the attached additional patch.  Note that the

	sum_check_2 += r.mnt_topology_changes;

bits in the fsinfo() tests accidentally got left in the preceding patch and so
aren't in this one.

David
---
commit 6c62787aec41f67c1d5a55a0d59578854bcef6f8
Author: David Howells <dhowells@redhat.com>
Date:   Tue Mar 31 21:53:11 2020 +0100

    Add a mountfs file to export the topology counter

diff --git a/fs/mountfs/super.c b/fs/mountfs/super.c
index 82c01eb6154d..58c05feb4fdd 100644
--- a/fs/mountfs/super.c
+++ b/fs/mountfs/super.c
@@ -22,7 +22,7 @@ struct mountfs_entry {
 
 static const char *mountfs_attrs[] = {
 	"root", "mountpoint", "id", "parent", "options", "children",
-	"group", "master", "propagate_from"
+	"group", "master", "propagate_from", "counter"
 };
 
 #define MOUNTFS_INO(id) (((unsigned long) id + 1) * \
@@ -128,6 +128,8 @@ static int mountfs_attr_show(struct seq_file *sf, void *v)
 			if (tmp)
 				seq_printf(sf, "%i\n", tmp);
 		}
+	} else if (strcmp(name, "counter") == 0) {
+		seq_printf(sf, "%u\n", atomic_read(&mnt->mnt_topology_changes));
 	} else {
 		WARN_ON(1);
 		err = -EIO;
diff --git a/samples/vfs/test-fsinfo-perf.c b/samples/vfs/test-fsinfo-perf.c
index 2bcde06ee78b..2b7606a53c2d 100644
--- a/samples/vfs/test-fsinfo-perf.c
+++ b/samples/vfs/test-fsinfo-perf.c
@@ -149,6 +149,26 @@ static void get_id_by_proc(int ix, const char *path)
 	}
 
 	sum_check += x;
+
+	/* And now the topology change counter */
+	sprintf(procfile, "/mnt/%u/counter", mnt_id);
+	fd = open(procfile, O_RDONLY);
+	ERR(fd, procfile);
+	len = read(fd, buffer, sizeof(buffer) - 1);
+	ERR(len, "read/counter");
+	close(fd);
+	if (len > 0 && buffer[len - 1] == '\n')
+		len--;
+	buffer[len] = 0;
+
+	x = strtoul(buffer, &q, 10);
+
+	if (*q) {
+		fprintf(stderr, "Bad format in %s '%s'\n", procfile, buffer);
+		exit(3);
+	}
+
+	sum_check_2 += x;
 	//printf("[%u] %u\n", ix, x);
 }
 
@@ -204,7 +224,7 @@ static void get_id_by_mountfs(void)
 	unsigned int base_mnt_id, mnt_id, x;
 	ssize_t len, s_children;
 	char procfile[100], buffer[100], *children, *p, *q, *nl, *comma;
-	int fd, fd2, mntfd, i;
+	int fd, fd2, mntfd;
 
 	/* Start off by reading the mount ID from the base path */
 	fd = open(base_path, O_PATH);
@@ -269,7 +289,6 @@ static void get_id_by_mountfs(void)
 	p = children;
 	if (!*p)
 		return;
-	i = 0;
 	do {
 		mnt_id = strtoul(p, &comma, 10);
 		if (*comma) {
@@ -297,8 +316,26 @@ static void get_id_by_mountfs(void)
 			exit(3);
 		}
 
-		if (0) printf("[%u] %u\n", i++, x);
 		sum_check += x;
+
+		sprintf(procfile, "%u/counter", mnt_id);
+		fd = openat(mntfd, procfile, O_RDONLY);
+		ERR(fd, procfile);
+		len = read(fd, buffer, sizeof(buffer) - 1);
+		ERR(len, "read/counter");
+		close(fd);
+		if (len > 0 && buffer[len - 1] == '\n')
+			len--;
+		buffer[len] = 0;
+
+		x = strtoul(buffer, &q, 10);
+
+		if (*q) {
+			fprintf(stderr, "Bad format in %s '%s'\n", procfile, buffer);
+			exit(3);
+		}
+
+		sum_check_2 += x;
 	} while (p = comma, *comma);
 }
 
