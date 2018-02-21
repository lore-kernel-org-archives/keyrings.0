From: David Howells <dhowells@redhat.com>
Date: Wed, 21 Feb 2018 14:16:20 +0000
Subject: Re: [linux] .system_keyring ?
Message-Id: <18207.1519222580@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <49ef1eb6-802b-ae86-a5e4-eb29a8ef4c4c@univention.de>
In-Reply-To: <49ef1eb6-802b-ae86-a5e4-eb29a8ef4c4c@univention.de>
To: keyrings@vger.kernel.org

Philipp Hahn <hahn@univention.de> wrote:

> Grepping the Linux kernel source tree git also find no '.system_keyring'
> in any source file - only the name of the header file and in Documentation/.
> Am I missing something? If that documentation out-dated?

Yeah, the docs are out of date, though I'm not entirely convinced by what we
have now - the IMA people seem to want to split the keyring set yet further,
which suggests this is the wrong way of going about things.

David
