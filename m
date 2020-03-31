From: David Howells <dhowells@redhat.com>
Date: Tue, 31 Mar 2020 21:52:52 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <2418286.1585691572@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <1445647.1585576702@warthog.procyon.org.uk>
In-Reply-To: <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: dhowells@redhat.com, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, dray@redhat.com, kzak@redhat.com, mszeredi@redhat.com, swhiteho@redhat.com, jlayton@redhat.com, raven@themaw.net, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, lennart@poettering.net, cyphar@cyphar.com

Christian Brauner <christian.brauner@ubuntu.com> wrote:

> querying all properties of a mount atomically all-at-once,

I don't actually offer that, per se.

Having an atomic all-at-once query for a single mount is actually quite a
burden on the system.  There's potentially a lot of state involved, much of
which you don't necessarily need.

I've tried to avoid the need to do that by adding change counters that can be
queried cheaply.  You read the counters, then you check mounts and superblocks
for which the counters have changed, and then you re-read the counters.  I've
added multiple counters, assigned to different purposes, to make it easier to
pin down what has changed - and so reduce the amount of checking required.

What I have added to fsinfo() is a way to atomically retrieve a list of all
the children of a mount, including, for each mount, the mount ID (which may
have been reused), a uniquifier (which shouldn't wrap over the kernel
lifetime) and the sum of the mount object and superblock change counters.

This should allow you to quickly rescan the mount tree as fsinfo() can look up
mounts by mount ID instead of by path or fd.

Below is a sample file from the kernel that scans by this method, displaying
an ascii art tree of all the mounts under a path or mount.

David
---
// SPDX-License-Identifier: GPL-2.0-or-later
/* Test the fsinfo() system call
 *
 * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
 * Written by David Howells (dhowells@redhat.com)
 */

#define _GNU_SOURCE
#define _ATFILE_SOURCE
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <ctype.h>
#include <errno.h>
#include <time.h>
#include <math.h>
#include <sys/syscall.h>
#include <linux/fsinfo.h>
#include <linux/socket.h>
#include <linux/fcntl.h>
#include <sys/stat.h>
#include <arpa/inet.h>

#ifndef __NR_fsinfo
#define __NR_fsinfo -1
#endif

static __attribute__((unused))
ssize_t fsinfo(int dfd, const char *filename,
	       struct fsinfo_params *params, size_t params_size,
	       void *result_buffer, size_t result_buf_size)
{
	return syscall(__NR_fsinfo, dfd, filename,
		       params, params_size,
		       result_buffer, result_buf_size);
}

static char tree_buf[4096];
static char bar_buf[4096];
static unsigned int children_list_interval;

/*
 * Get an fsinfo attribute in a statically allocated buffer.
 */
static void get_attr(unsigned int mnt_id, unsigned int attr, unsigned int Nth,
		     void *buf, size_t buf_size)
{
	struct fsinfo_params params = {
		.flags		= FSINFO_FLAGS_QUERY_MOUNT,
		.request	= attr,
		.Nth		= Nth,
	};
	char file[32];
	long ret;

	sprintf(file, "%u", mnt_id);

	memset(buf, 0xbd, buf_size);

	ret = fsinfo(AT_FDCWD, file, &params, sizeof(params), buf, buf_size);
	if (ret == -1) {
		fprintf(stderr, "mount-%s: %m\n", file);
		exit(1);
	}
}

/*
 * Get an fsinfo attribute in a dynamically allocated buffer.
 */
static void *get_attr_alloc(unsigned int mnt_id, unsigned int attr,
			    unsigned int Nth, size_t *_size)
{
	struct fsinfo_params params = {
		.flags		= FSINFO_FLAGS_QUERY_MOUNT,
		.request	= attr,
		.Nth		= Nth,
	};
	size_t buf_size = 4096;
	char file[32];
	void *r;
	long ret;

	sprintf(file, "%u", mnt_id);

	for (;;) {
		r = malloc(buf_size);
		if (!r) {
			perror("malloc");
			exit(1);
		}
		memset(r, 0xbd, buf_size);

		ret = fsinfo(AT_FDCWD, file, &params, sizeof(params), r, buf_size);
		if (ret == -1) {
			fprintf(stderr, "mount-%s: %x,%x,%x %m\n",
				file, params.request, params.Nth, params.Mth);
			exit(1);
		}

		if (ret <= buf_size) {
			*_size = ret;
			break;
		}
		buf_size = (ret + 4096 - 1) & ~(4096 - 1);
	}

	return r;
}

/*
 * Display a mount and then recurse through its children.
 */
static void display_mount(unsigned int mnt_id, unsigned int depth, char *path)
{
	struct fsinfo_mount_topology top;
	struct fsinfo_mount_child child;
	struct fsinfo_mount_info info;
	struct fsinfo_ids ids;
	void *children;
	unsigned int d;
	size_t ch_size, p_size;
	char dev[64];
	int i, n, s;

	get_attr(mnt_id, FSINFO_ATTR_MOUNT_TOPOLOGY, 0, &top, sizeof(top));
	get_attr(mnt_id, FSINFO_ATTR_MOUNT_INFO, 0, &info, sizeof(info));
	get_attr(mnt_id, FSINFO_ATTR_IDS, 0, &ids, sizeof(ids));
	if (depth > 0)
		printf("%s", tree_buf);

	s = strlen(path);
	printf("%s", !s ? "\"\"" : path);
	if (!s)
		s += 2;
	s += depth;
	if (s < 38)
		s = 38 - s;
	else
		s = 1;
	printf("%*.*s", s, s, "");

	sprintf(dev, "%x:%x", ids.f_dev_major, ids.f_dev_minor);
	printf("%10u %8x %2x %x %5s %s",
	       info.mnt_id,
	       (info.sb_changes +
		info.sb_notifications +
		info.mnt_attr_changes +
		info.mnt_topology_changes +
		info.mnt_subtree_notifications),
	       info.attr, top.propagation,
	       dev, ids.f_fs_name);
	putchar('\n');

	children = get_attr_alloc(mnt_id, FSINFO_ATTR_MOUNT_CHILDREN, 0, &ch_size);
	n = ch_size / children_list_interval - 1;

	bar_buf[depth + 1] = '|';
	if (depth > 0) {
		tree_buf[depth - 4 + 1] = bar_buf[depth - 4 + 1];
		tree_buf[depth - 4 + 2] = ' ';
	}

	tree_buf[depth + 0] = ' ';
	tree_buf[depth + 1] = '\\';
	tree_buf[depth + 2] = '_';
	tree_buf[depth + 3] = ' ';
	tree_buf[depth + 4] = 0;
	d = depth + 4;

	memset(&child, 0, sizeof(child));
	for (i = 0; i < n; i++) {
		void *p = children + i * children_list_interval;

		if (sizeof(child) >= children_list_interval)
			memcpy(&child, p, children_list_interval);
		else
			memcpy(&child, p, sizeof(child));

		if (i == n - 1)
			bar_buf[depth + 1] = ' ';
		path = get_attr_alloc(child.mnt_id, FSINFO_ATTR_MOUNT_POINT,
				      0, &p_size);
		display_mount(child.mnt_id, d, path + 1);
		free(path);
	}

	free(children);
	if (depth > 0) {
		tree_buf[depth - 4 + 1] = '\\';
		tree_buf[depth - 4 + 2] = '_';
	}
	tree_buf[depth] = 0;
}

/*
 * Find the ID of whatever is at the nominated path.
 */
static unsigned int lookup_mnt_by_path(const char *path)
{
	struct fsinfo_mount_info mnt;
	struct fsinfo_params params = {
		.flags		= FSINFO_FLAGS_QUERY_PATH,
		.request	= FSINFO_ATTR_MOUNT_INFO,
	};

	if (fsinfo(AT_FDCWD, path, &params, sizeof(params), &mnt, sizeof(mnt)) == -1) {
		perror(path);
		exit(1);
	}

	return mnt.mnt_id;
}

/*
 * Determine the element size for the mount child list.
 */
static unsigned int query_list_element_size(int mnt_id, unsigned int attr)
{
	struct fsinfo_attribute_info attr_info;

	get_attr(mnt_id, FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, attr,
		 &attr_info, sizeof(attr_info));
	return attr_info.size;
}

/*
 *
 */
int main(int argc, char **argv)
{
	unsigned int mnt_id;
	char *path;
	bool use_mnt_id = false;
	int opt;

	while ((opt = getopt(argc, argv, "m"))) {
		switch (opt) {
		case 'm':
			use_mnt_id = true;
			continue;
		}
		break;
	}

	argc -= optind;
	argv += optind;

	switch (argc) {
	case 0:
		mnt_id = lookup_mnt_by_path("/");
		path = "ROOT";
		break;
	case 1:
		path = argv[0];
		if (use_mnt_id) {
			mnt_id = strtoul(argv[0], NULL, 0);
			break;
		}

		mnt_id = lookup_mnt_by_path(argv[0]);
		break;
	default:
		printf("Format: test-mntinfo\n");
		printf("Format: test-mntinfo <path>\n");
		printf("Format: test-mntinfo -m <mnt_id>\n");
		exit(2);
	}

	children_list_interval =
		query_list_element_size(mnt_id, FSINFO_ATTR_MOUNT_CHILDREN);

	printf("MOUNT                                 MOUNT ID   CHANGE#  AT P DEV   TYPE\n");
	printf("------------------------------------- ---------- -------- -- - ----- --------\n");
	display_mount(mnt_id, 0, path);
	return 0;
}
