From: David Howells <dhowells@redhat.com>
Date: Fri, 02 Nov 2018 16:30:21 +0000
Subject: Re: [PATCH v2 5/7] keyctl_dh_compute_kdf: use a void* for opaque data
Message-Id: <19674.1541176221@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180927131436.23328-6-mathstuf@gmail.com>
In-Reply-To: <20180927131436.23328-6-mathstuf@gmail.com>
To: keyrings@vger.kernel.org

Ben Boeckel <mathstuf@gmail.com> wrote:

> Well, I had a patch to also change the UAPI which you rejected because
> it didn't match the code in libkeyutils.

That wasn't the only reason I rejected it.  I also said:

	The UAPI change might potentially cause userspace to fail to compile
	if someone was assigning the char * pointer from the struct to another
	char * pointer.

The structs need to match - something which we failed to do with
keyctl_dh_params.  I've ended up putting some magic with a cpp-conditional and
a union in the kernel for that :-/

But you shouldn't also *change* the UAPI if that will break existing
userspace.  I think that's Linus's rule #1.  And your change has the potential
to do just that.

David
