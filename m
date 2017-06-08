From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Jun 2017 12:05:46 +0000
Subject: Re: [PATCH keyutils] TEST: Add KDF leading zero test
Message-Id: <6666.1496923546@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170607173135.19912-1-mathew.j.martineau@linux.intel.com>
In-Reply-To: <20170607173135.19912-1-mathew.j.martineau@linux.intel.com>
To: keyrings@vger.kernel.org

Would it be useful to add, say, a "keyctl xpadd" command that was like "keyctl
padd" but took hex input?

David
