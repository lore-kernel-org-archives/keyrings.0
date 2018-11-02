From: David Howells <dhowells@redhat.com>
Date: Fri, 02 Nov 2018 14:41:01 +0000
Subject: Re: [PATCH v2 3/7] keyctl_dh_compute.3: clarify keyctl_dh_compute_kdf
Message-Id: <10930.1541169661@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Ben Boeckel <mathstuf@gmail.com> wrote:

> +On success
> +.BR keyctl_dh_compute_kdf ()
> +returns the amount of data placed into the buffer when
> +.I buflen
> +is non-zero.

That's incomplete.  It doesn't say what the outcome is when buflen is zero.

David
