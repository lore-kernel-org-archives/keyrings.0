From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 05 Jun 2017 03:34:12 +0000
Subject: Re: security/keys: add CONFIG_KEYS_COMPAT to Kconfig
Message-Id: <20170605033412.GA6277@zzz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170603024358.GA565@zzz>
	<1486674698-67190-1-git-send-email-bilal.amarni@gmail.com>
	<20170329192002.GA29310@gmail.com>
	<30959.1496477082@warthog.procyon.org.uk>
In-Reply-To: <30959.1496477082@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

On Sat, Jun 03, 2017 at 09:04:42AM +0100, David Howells wrote:
> Eric Biggers <ebiggers3@gmail.com> wrote:
> 
> > This patch is in the "keys-fixes" branch now, but it doesn't remove KEYS_COMPAT
> > from arch/arm64/Kconfig.  David, can you fix it?  Thanks!
> 
> Done.  See below.
> 
> David
> ---

Looks good now, thanks.  (Except that as I mentioned before, I don't think we
need the KEYS_COMPAT option at all, but that can be another patch.)

Eric
