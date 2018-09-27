From: David Howells <dhowells@redhat.com>
Date: Thu, 27 Sep 2018 17:08:03 +0000
Subject: Re: [PATCH 4/5] keyctl.h: update pointer types
Message-Id: <29140.1538068083@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180927131450.23458-5-mathstuf@gmail.com>
In-Reply-To: <20180927131450.23458-5-mathstuf@gmail.com>
To: keyrings@vger.kernel.org

Ben Boeckel <mathstuf@gmail.com> wrote:

> These should be `const` since the kernel should not touch them. In
> addition `otherinfo` is defined to be opaque, so make it a `void *`.

You're changing the UAPI - and this no longer matches what's in keyutils.h in
userspace.

The UAPI change might potentially cause userspace to fail to compile if
someone was assigning the char * pointer from the struct to another char *
pointer.

Unless there's an actual bug to fix (see the 'private' problem), I would
strongly recommend living with this.

David
