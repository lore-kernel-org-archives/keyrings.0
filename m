From: David Howells <dhowells@redhat.com>
Date: Thu, 02 Nov 2017 00:06:02 +0000
Subject: Re: [PATCH] KEYS: fix in-kernel documentation for keyctl_read()
Message-Id: <17684.1509581162@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171026205458.105299-1-ebiggers3@gmail.com>
In-Reply-To: <20171026205458.105299-1-ebiggers3@gmail.com>
To: keyrings@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> I guess that's fine --- either way users can't rely on the contents of the
> buffer.  The man page should use the same wording, though.  Should I send a v2
> of both patches?

Please.  I just think it's better to put the 'semi-successful' case before the
'really successful' case.

Thanks.
David
