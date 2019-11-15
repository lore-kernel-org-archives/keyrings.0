From: David Howells <dhowells@redhat.com>
Date: Fri, 15 Nov 2019 13:28:52 +0000
Subject: Re: [pipe] d60337eff1: BUG:kernel_NULL_pointer_dereference,address
Message-Id: <9279.1573824532@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191110031348.GE29418@shao2-debian>
In-Reply-To: <20191110031348.GE29418@shao2-debian>
To: kernel test robot <lkp@intel.com>
Cc: dhowells@redhat.com, torvalds@linux-foundation.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, nicolas.dichtel@6wind.com, raven@themaw.net, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@lists.01.org

kernel test robot <lkp@intel.com> wrote:

> [    9.423019] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [    9.425646] #PF: supervisor read access in kernel mode
> [    9.427714] #PF: error_code(0x0000) - not-present page
> [    9.429851] PGD 80000001fb937067 P4D 80000001fb937067 PUD 1739e1067 PMD 0 
> [    9.432468] Oops: 0000 [#1] SMP PTI
> [    9.434064] CPU: 0 PID: 178 Comm: cat Not tainted 5.4.0-rc5-00353-gd60337eff18a3 #1
> [    9.437139] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [    9.440439] RIP: 0010:iov_iter_get_pages_alloc+0x2a8/0x400

Can you tell me if the following change fixes it for you?

--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -404,7 +404,7 @@ static size_t copy_page_to_iter_pipe(struct page *page, size_t offset, size_t by
 	buf->offset = offset;
 	buf->len = bytes;
 
-	pipe->head = i_head;
+	pipe->head = i_head + 1;
 	i->iov_offset = offset + bytes;
 	i->head = i_head;
 out:

Attached is a test program that can induce some a bug in
copy_page_to_iter_pipe() where I forgot to increment the new head when
assigning it to pipe->head.

David
---
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <err.h>
#include <sys/wait.h>

static char buf[256 * 1024] __attribute__((aligned(512)));
static char *filename;
static int pipe_wfd = -1;

static void cleanup(void)
{
	close(pipe_wfd);
}

static void cleanup_child(void)
{
	int w;
	wait(&w);
}

int child(int fd)
{
	ssize_t r;

	do {
		r = read(fd, buf, 256 * 1024);
		if (r == -1)
			err(1, "read");
	} while (r != 0);

	if (close(fd) == -1)
		err(1, "close");

	return 0;
}

int main(int argc, char **argv)
{
	ssize_t n;
	loff_t offset;
	size_t len;
	pid_t pid;
	int fd, pfd[2];

	if (argc != 2) {
		fprintf(stderr, "Format: %s <file>\n", argv[1]);
		exit(2);
	}

	filename = argv[1];

	if (pipe(pfd) == -1)
		err(1, "pipe");
	pipe_wfd = pfd[1];

	pid = fork();
	switch (pid) {
	case -1:
		err(1, "fork");
	case 0:
		close(pfd[1]);
		return child(pfd[0]);
	default:
		close(pfd[0]);
		atexit(cleanup_child);
		break;
	}

	fd = open(filename, O_RDONLY);
	if (fd == -1)
		err(1, "%s", filename);

	atexit(cleanup);

	len = 256 * 1024;
	offset = 0;
	do {
		n = splice(fd, &offset, pfd[1], NULL, 256 * 1024, 0);
		if (n == -1)
			err(1, "splice");
	} while (len -= n, len > 0);

	if (close(pfd[1]) == -1)
		err(1, "close/p");
	if (close(fd) == -1)
		err(1, "close/f");
	return 0;
}
