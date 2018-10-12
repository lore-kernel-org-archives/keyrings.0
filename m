From: David Howells <dhowells@redhat.com>
Date: Fri, 12 Oct 2018 20:37:29 +0000
Subject: Re: [PATCH 2/2] conf: add upcall line for nvdimm in request-key.conf
Message-Id: <30852.1539376649@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153936769332.53805.5782268917140745309.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <153936769332.53805.5782268917140745309.stgit@djiang5-desk3.ch.intel.com>
To: keyrings@vger.kernel.org

You should take a look at this patch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/commit/?h=next&id_2f3c34b0b23e5d2ea4564ac990827c47999992

on the keyutils next branch.  You should add a file into:

	/etc/request-key.d/

with this line:

	+create  logon   nvdimm*         *               /usr/sbin/nvdimm-upcall %k

in it.  Do you actually want to say "nvdimm:*", btw?

David
