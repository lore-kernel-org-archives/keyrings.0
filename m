From: David Howells <dhowells@redhat.com>
Date: Mon, 26 Jun 2017 15:22:58 +0000
Subject: Re: [PATCH keyutils] tests/bz1031154: skip if selinux is disabled
Message-Id: <25587.1498490578@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1498480521-16489-1-git-send-email-asavkov@redhat.com>
In-Reply-To: <1498480521-16489-1-git-send-email-asavkov@redhat.com>
To: keyrings@vger.kernel.org

Artem Savkov <asavkov@redhat.com> wrote:

> With selinux disabled the test currently fails trying to setenforce, it
> should be skipped instead. Found while trying to run in a container
> where selinux always appears disabled.

Could you add a macro for this to toolbox.sh and use that instead?  It sounds
generally useful.

David
