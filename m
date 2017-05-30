From: David Howells <dhowells@redhat.com>
Date: Tue, 30 May 2017 15:47:52 +0000
Subject: Re: verify_pefile_signature() and a message field of MZ header in pe.h
Message-Id: <15954.1496159272@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170530071022.GB26483@linaro.org>
In-Reply-To: <20170530071022.GB26483@linaro.org>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: dhowells@redhat.com, ard.biesheuvel@linaro.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, pjones@redhat.com

AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:

> Struct mz_hdr in include/linux/pe.h contains a message[] field.
> Should it be part of this structure?

You'd probably be better off asking Peter Jones - he wrote the original code
that I copied into the kernel.

David
