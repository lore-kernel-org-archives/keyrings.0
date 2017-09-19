From: David Howells <dhowells@redhat.com>
Date: Tue, 19 Sep 2017 16:05:20 +0000
Subject: Re: [PATCH] KEYS: prevent creating a different user's keyrings
Message-Id: <29684.1505837120@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170918183703.114134-1-ebiggers3@gmail.com>
In-Reply-To: <20170918183703.114134-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

Eric Biggers <ebiggers3@gmail.com> wrote:

> Fix it by marking user and user session keyrings with a flag
> KEY_FLAG_UID_KEYRING.  Then, when searching for a user or user session
> keyring by name, skip all keyrings that don't have the flag set.

I wonder if it's better just to reject attempts to manually create/join
keyrings of such names.  PAM uses the implicit creation method of specifying
the 'macro' key IDs for these keyrings.

David
