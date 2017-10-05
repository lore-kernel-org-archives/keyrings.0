From: Florian Weimer <fweimer@redhat.com>
Date: Thu, 05 Oct 2017 12:33:30 +0000
Subject: Re: Draft manpage explaining kernel lockdown
Message-Id: <3765ad08-2c73-7285-02e1-e04f31dde3fd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <7969.1507201224@warthog.procyon.org.uk>
In-Reply-To: <7969.1507201224-S6HVgzuS8uM4Awkfq6JHfwNdhmdF6hFW@public.gmane.org>
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, keyrings-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-security-module-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-efi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On 10/05/2017 01:00 PM, David Howells wrote:
> Lockdown is typically enabled during boot and may be terminated, if configured,
> by typing a special key combination on a directly attached physical keyboard.

Does this include a Bluetooth keyboard (which might not actually exist 
and might in reality be another server in the same rack, of course).

Thanks,
Florian
