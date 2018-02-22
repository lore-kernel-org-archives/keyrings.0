From: David Howells <dhowells@redhat.com>
Date: Thu, 22 Feb 2018 23:42:15 +0000
Subject: Re: [PATCH 6/6] KEYS: Use individual pages in big_key for crypto buffers
Message-Id: <29838.1519342935@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <151931646922.27713.5363631712174136041.stgit@warthog.procyon.org.uk>
	<151931642737.27713.5082532296556836948.stgit@warthog.procyon.org.uk>
In-Reply-To: <151931646922.27713.5363631712174136041.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> +		l = min(len, PAGE_SIZE);

Sigh.  This needs to be a min_t().

David
