From: David Howells <dhowells@redhat.com>
Date: Fri, 30 Aug 2019 15:12:34 +0000
Subject: Re: Oops (request_key_auth_describe) while running cve-2016-7042 from LTP
Message-Id: <11908.1567177954@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190830145454.B91DF125411@zmta02.collab.prod.int.phx2.redhat.com>
 <20190830085646.14740-1-hdanton@sina.com>
 <4384.1567174383@warthog.procyon.org.uk>
In-Reply-To: <20190830145454.B91DF125411@zmta02.collab.prod.int.phx2.redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: dhowells@redhat.com, Sachin Sant <sachinp@linux.vnet.ibm.com>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>

Hillf Danton <hdanton@sina.com> wrote:

> 1, callee has no pre defined duty to help caller in general; they should not
> try to do anything, however, to help their callers in principle due to
> limited info on their hands IMO.

Ah, no.  It's entirely reasonable for an API to specify that one of its
methods will be called with one or more locks held - and that the method must
be aware of this and may make use of this.

> 3, no comment can be found in security/keys/request_key_auth.c about
> the rcu already documented.

There is API documentation in Documentation/security/keys/core.rst.  If you
look at about line 1538 onwards:

  *  ``void (*describe)(const struct key *key, struct seq_file *p);``

     This method is optional. It is called during /proc/keys reading to
     summarise a key's description and payload in text form.

     This method will be called with the RCU read lock held. rcu_dereference()
     should be used to read the payload pointer if the payload is to be
     accessed. key->datalen cannot be trusted to stay consistent with the
     contents of the payload.

     The description will not change, though the key's state may.

     It is not safe to sleep in this method; the RCU read lock is held by the
     caller.

David
