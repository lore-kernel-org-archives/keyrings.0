From: David Howells <dhowells@redhat.com>
Date: Wed, 06 Mar 2019 17:29:55 +0000
Subject: Re: [RFC PATCH 0/2] Create CAAM HW key in linux keyring and use in dmcrypt
Message-Id: <11177.1551893395@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1551456599-10603-1-git-send-email-franck.lenormand@nxp.com>
In-Reply-To: <1551456599-10603-1-git-send-email-franck.lenormand@nxp.com>
To: Franck LENORMAND <franck.lenormand@nxp.com>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, horia.geanta@nxp.com, silvano.dininno@nxp.com, agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com, jmorris@namei.org, serge@hallyn.com

Franck LENORMAND <franck.lenormand@nxp.com> wrote:

> The capacity to generate or load keys already available in the Linux key
> retention service does not allows to exploit CAAM capabilities hence we
> need to create a new key_type. The new key type "caam_tk" allows to:
>  - Create a black key from random
>  - Create a black key from a red key
>  - Load a black blob to retrieve the black key

Is it possible that this could be done through an existing key type, such as
the asymmetric, trusted or encrypted key typed?

David
