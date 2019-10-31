From: David Howells <dhowells@redhat.com>
Date: Thu, 31 Oct 2019 13:23:24 +0000
Subject: Re: [PATCH] keyctl: try to wipe keys from memory after use
Message-Id: <23324.1572528204@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191029143451.327761-1-mail@maciej.szmigiero.name>
In-Reply-To: <20191029143451.327761-1-mail@maciej.szmigiero.name>
To: keyrings@vger.kernel.org

Maciej S. Szmigiero <mail@maciej.szmigiero.name> wrote:

> The key being added or updated likely contains secrets so it would be best
> not to leave it in memory or in a core dump when no longer needed.
> 
> Glibc 2.25+ provides the explicit_bzero() function that can be used for
> this purpose, let's utilize it if it is present.
> 
> Tested by redefining exit(n) to abort() and inspecting the resulting core
> file for key data.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Applied.
