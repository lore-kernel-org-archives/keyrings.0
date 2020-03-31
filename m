From: David Howells <dhowells@redhat.com>
Date: Tue, 31 Mar 2020 21:14:15 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <2415050.1585689255@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAJfpegtn1A=dL9VZJQ2GRWsOiP+YSs-4ezE9YgEYNmb-AF0OLA@mail.gmail.com> <1445647.1585576702@warthog.procyon.org.uk> <CAJfpegvZ_qtdGcP4bNQyYt1BbgF9HdaDRsmD43a-Muxgki+wTw@mail.gmail.com> <2294742.1585675875@warthog.procyon.org.uk>
In-Reply-To: <CAJfpegtn1A=dL9VZJQ2GRWsOiP+YSs-4ezE9YgEYNmb-AF0OLA@mail.gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dhowells@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, Christian Brauner <christian.brauner@ubuntu.com>, Lennart Poettering <mzxreary@0pointer.de>, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> So even the p2 method will give at least 80k queries/s, which is quite
> good, considering that the need to rescan the complete mount tree
> should be exceedingly rare (and in case it mattered, could be
> optimized by priming from /proc/self/mountinfo).

One thing to note is that the test is actually a little biased in favour of
the "p" test, where the mnt_id is looked up by path from /proc/fdinfo.  That's
not all that useful, except as an index into mountfs.  I'm not sure how much
use it as a check on whether the mount is the same mount or not since mount
IDs can get reused.

If I instead use the parent_id all round as the desired target value, I then
see:

For 10000 mounts, f"899us f2240us p1054us p27273us <-- prev email
For 10000 mounts, f$853us f2 453us p#5581us p2= 59798us <-- parent_id

Some observations:

 (1) fsinfo() gets a bit slower, reflecting the extra locking that must be
     done to access the topology information (it's using a different
     attribute).

 (2) Going via /proc/fdinfo now includes further a access into mountfs - and
     this makes the access ~2.3x slower than it was before.

 (3) Going via mount ID directly into mountfs (the "p2" test) appears faster
     than it did (when it shouldn't have changed), though it's still slower
     than fsinfo.  This I ascribe to the caching of the inode and dentry from
     the "p" test.

The attached patch adjusts the test program.

David
---
commit e9844e27f3061e4ef2d1511786b5ea60338dc610
Author: David Howells <dhowells@redhat.com>
Date:   Tue Mar 31 21:14:58 2020 +0100

    Get parent ID instead

diff --git a/samples/vfs/test-fsinfo-perf.c b/samples/vfs/test-fsinfo-perf.c
index fba40737f768..2bcde06ee78b 100644
--- a/samples/vfs/test-fsinfo-perf.c
+++ b/samples/vfs/test-fsinfo-perf.c
@@ -69,27 +69,27 @@ static void do_umount(void)
 		perror("umount");
 }
 
-static unsigned long sum_mnt_id;
+static unsigned long sum_check, sum_check_2;
 
-static void get_mntid_by_fsinfo(int ix, const char *path)
+static void get_id_by_fsinfo(int ix, const char *path)
 {
-	struct fsinfo_mount_info r;
+	struct fsinfo_mount_topology r;
 	struct fsinfo_params params = {
 		.flags		= FSINFO_FLAGS_QUERY_PATH,
-		.request	= FSINFO_ATTR_MOUNT_INFO,
+		.request	= FSINFO_ATTR_MOUNT_TOPOLOGY,
 	};
 
 	ERR(fsinfo(AT_FDCWD, path, &params, sizeof(params), &r, sizeof(r)),
 	    "fsinfo");
-	//printf("[%u] %u\n", ix, r.mnt_id);
-	sum_mnt_id += r.mnt_id;
+	sum_check += r.parent_id;
+	sum_check_2 += r.mnt_topology_changes;
 }
 
-static void get_mntid_by_proc(int ix, const char *path)
+static void get_id_by_proc(int ix, const char *path)
 {
-	unsigned int mnt_id;
+	unsigned int mnt_id, x;
 	ssize_t len;
-	char procfile[100], buffer[4096], *p, *nl;
+	char procfile[100], buffer[4096], *p, *q, *nl;
 	int fd, fd2;
 
 	fd = open(path, O_PATH);
@@ -130,12 +130,31 @@ static void get_mntid_by_proc(int ix, const char *path)
 		exit(3);
 	}
 
-	sum_mnt_id += mnt_id;
-	//printf("[%u] %u\n", ix, mnt_id);
+	/* Now look the ID up on mountfs */
+	sprintf(procfile, "/mnt/%u/parent", mnt_id);
+	fd = open(procfile, O_RDONLY);
+	ERR(fd, procfile);
+	len = read(fd, buffer, sizeof(buffer) - 1);
+	ERR(len, "read/parent");
+	close(fd);
+	if (len > 0 && buffer[len - 1] = '\n')
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
+	sum_check += x;
+	//printf("[%u] %u\n", ix, x);
 }
 
-static void get_mntid_by_fsinfo_2(void)
+static void get_id_by_fsinfo_2(void)
 {
+	struct fsinfo_mount_topology t;
 	struct fsinfo_mount_child *children, *c, *end;
 	struct fsinfo_mount_info r;
 	struct fsinfo_params params = {
@@ -171,15 +190,16 @@ static void get_mntid_by_fsinfo_2(void)
 	for (i = 0; c < end; c++, i++) {
 		//printf("[%u] %u\n", i, c->mnt_id);
 		params.flags	= FSINFO_FLAGS_QUERY_MOUNT;
-		params.request	= FSINFO_ATTR_MOUNT_INFO;
+		params.request	= FSINFO_ATTR_MOUNT_TOPOLOGY;
 		sprintf(name, "%u", c->mnt_id);
-		ERR(fsinfo(AT_FDCWD, name, &params, sizeof(params), &r, sizeof(r)),
+		ERR(fsinfo(AT_FDCWD, name, &params, sizeof(params), &t, sizeof(t)),
 		    "fsinfo/child");
-		sum_mnt_id += r.mnt_id;
+		sum_check += t.parent_id;
+		sum_check_2 += t.mnt_topology_changes;
 	}
 }
 
-static void get_mntid_by_mountfs(void)
+static void get_id_by_mountfs(void)
 {
 	unsigned int base_mnt_id, mnt_id, x;
 	ssize_t len, s_children;
@@ -260,11 +280,11 @@ static void get_mntid_by_mountfs(void)
 			comma++;
 		}
 
-		sprintf(procfile, "%u/id", mnt_id);
+		sprintf(procfile, "%u/parent", mnt_id);
 		fd = openat(mntfd, procfile, O_RDONLY);
 		ERR(fd, procfile);
 		len = read(fd, buffer, sizeof(buffer) - 1);
-		ERR(len, "read/id");
+		ERR(len, "read/parent");
 		close(fd);
 		if (len > 0 && buffer[len - 1] = '\n')
 			len--;
@@ -278,7 +298,7 @@ static void get_mntid_by_mountfs(void)
 		}
 
 		if (0) printf("[%u] %u\n", i++, x);
-		sum_mnt_id += x;
+		sum_check += x;
 	} while (p = comma, *comma);
 }
 
@@ -318,32 +338,32 @@ int main(int argc, char **argv)
 	iterate(make_mount);
 
 	printf("--- test fsinfo by path ---\n");
-	sum_mnt_id = 0;
+	sum_check = 0;
 	ERR(gettimeofday(&f_before, NULL), "gettimeofday");
-	iterate(get_mntid_by_fsinfo);
+	iterate(get_id_by_fsinfo);
 	ERR(gettimeofday(&f_after, NULL), "gettimeofday");
-	printf("sum(mnt_id) = %lu\n", sum_mnt_id);
+	printf("sum(mnt_id) = %lu\n", sum_check);
 
 	printf("--- test fsinfo by mnt_id ---\n");
-	sum_mnt_id = 0;
+	sum_check = 0;
 	ERR(gettimeofday(&f2_before, NULL), "gettimeofday");
-	get_mntid_by_fsinfo_2();
+	get_id_by_fsinfo_2();
 	ERR(gettimeofday(&f2_after, NULL), "gettimeofday");
-	printf("sum(mnt_id) = %lu\n", sum_mnt_id);
+	printf("sum(mnt_id) = %lu\n", sum_check);
 
 	printf("--- test /proc/fdinfo ---\n");
-	sum_mnt_id = 0;
+	sum_check = 0;
 	ERR(gettimeofday(&p_before, NULL), "gettimeofday");
-	iterate(get_mntid_by_proc);
+	iterate(get_id_by_proc);
 	ERR(gettimeofday(&p_after, NULL), "gettimeofday");
-	printf("sum(mnt_id) = %lu\n", sum_mnt_id);
+	printf("sum(mnt_id) = %lu\n", sum_check);
 
 	printf("--- test mountfs ---\n");
-	sum_mnt_id = 0;
+	sum_check = 0;
 	ERR(gettimeofday(&p2_before, NULL), "gettimeofday");
-	get_mntid_by_mountfs();
+	get_id_by_mountfs();
 	ERR(gettimeofday(&p2_after, NULL), "gettimeofday");
-	printf("sum(mnt_id) = %lu\n", sum_mnt_id);
+	printf("sum(mnt_id) = %lu\n", sum_check);
 
 	f_dur  = duration(&f_before,  &f_after);
 	f2_dur = duration(&f2_before, &f2_after);
