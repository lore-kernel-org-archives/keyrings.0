From: David Howells <dhowells@redhat.com>
Date: Thu, 19 Mar 2020 15:08:21 +0000
Subject: Re: [PATCH v3] KEYS: reaching the keys quotas correctly
Message-Id: <3166161.1584630501@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1582864911-30823-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
In-Reply-To: <1582864911-30823-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
To: keyrings@vger.kernel.org

How about:

	keys: Fix the keys quotas limit check

It's a bit unfortunate that "key" is also usable as an adjective.

David
