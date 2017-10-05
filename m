From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 05 Oct 2017 11:07:10 +0000
Subject: Re: Draft manpage explaining kernel lockdown
Message-Id: <1507201630.2387.16.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <7969.1507201224@warthog.procyon.org.uk>
In-Reply-To: <7969.1507201224@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, mtk.manpages@gmail.com
Cc: mcgrof@kernel.org, linux-man@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2017-10-05 at 12:00 +0100, David Howells wrote:
> 
> Only validly signed wifi databases may be use.

We don't even have this yet, and when we do, we want this to be the
case for typical configurations regardless of lockdown.

johannes
