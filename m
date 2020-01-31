From: David Howells <dhowells@redhat.com>
Date: Fri, 31 Jan 2020 17:19:38 +0000
Subject: Re: [PATCH v2] keys: proc_keys_next should increase position index
Message-Id: <265151.1580491178@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <22307ecd-3254-6077-8bc7-02693338b586@virtuozzo.com> <eaacb0b2-fd0d-480e-1868-0a1284c20185@virtuozzo.com>
In-Reply-To: <22307ecd-3254-6077-8bc7-02693338b586@virtuozzo.com>
To: Vasily Averin <vvs@virtuozzo.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>

Vasily Averin <vvs@virtuozzo.com> wrote:

> If seq_file .next fuction does not change position index,

"function"

>    <<<< and whole last lien again

"line"

I can fix these up for you.

> https://bugzilla.kernel.org/show_bug.cgi?id 6283

I wonder if this should have a tag - it looks kind of out of place without
one, but I can't find one suggested.

David
