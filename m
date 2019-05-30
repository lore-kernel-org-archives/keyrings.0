From: David Howells <dhowells@redhat.com>
Date: Thu, 30 May 2019 13:31:48 +0000
Subject: Re: [PATCH 6/7] keys: Add a keyctl to move a key between keyrings
Message-Id: <3772.1559223108@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190529232500.GA131466@gmail.com> <155856408314.10428.17035328117829912815.stgit@warthog.procyon.org.uk> <155856412507.10428.15987388402707639951.stgit@warthog.procyon.org.uk>
In-Reply-To: <20190529232500.GA131466@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:

> This shows up after a few seconds of syzkaller fuzzing with a description of
> KEYCTL_MOVE added:

Yeah...  I'm fixing that now.  I've also created a bunch of tests, manpages,
etc. for keyutils which I'll push when I've fixed my patches.

David
