From: David Howells <dhowells@redhat.com>
Date: Thu, 30 May 2019 22:03:48 +0000
Subject: Re: [PATCH 00/10] keys: Miscellany [ver #2]
Message-Id: <24108.1559253828@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190530181248.GC70051@gmail.com> <155923711088.949.14909672457214372214.stgit@warthog.procyon.org.uk>
In-Reply-To: <20190530181248.GC70051@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, Mat Martineau <mathew.j.martineau@linux.intel.com>, James Morris <jamorris@linux.microsoft.com>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:

> syzkaller still manages to crash something in the keys subsystem really
> quickly when I run it on that branch (commit 35036b7e765b6):

I've pushed a new version that should fix that, thanks.

David
