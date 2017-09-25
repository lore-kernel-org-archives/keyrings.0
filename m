From: David Howells <dhowells@redhat.com>
Date: Mon, 25 Sep 2017 15:28:10 +0000
Subject: Re: [PATCH] KEYS: key refcounting cleanup in keyctl_read_key
Message-Id: <1319.1506353290@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <065a1f03-a342-c47c-ea6f-b4cc84f869bb@virtuozzo.com>
In-Reply-To: <065a1f03-a342-c47c-ea6f-b4cc84f869bb@virtuozzo.com>
To: linux-security-module@vger.kernel.org

I have a patch from Eric Biggers that does the same thing that I've applied.

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=keys-fixes&idc0786d956d9e59b68d282be9b156179846ea3d

David
