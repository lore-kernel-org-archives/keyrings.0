From: David Howells <dhowells@redhat.com>
Date: Thu, 17 Jan 2019 15:04:21 +0000
Subject: Re: [RFC PATCH 1/1] KEYS, integrity: Link .platform keyring to .secondary_trusted_keys
Message-Id: <21896.1547737461@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190108081247.2266-2-kasong@redhat.com> <20190108081247.2266-1-kasong@redhat.com>
In-Reply-To: <20190108081247.2266-2-kasong@redhat.com>
To: Kairui Song <kasong@redhat.com>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, dwmw2@infradead.org, jwboyer@fedoraproject.org, keyrings@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, bauerman@linux.ibm.com, ebiggers@google.com, nayna@linux.ibm.com, dyoung@redhat.com

Kairui Song <kasong@redhat.com> wrote:

> +extern const struct key* __init integrity_get_platform_keyring(void);

This should really be in keys/system_keyring.h and probably shouldn't be
exposed directly if it can be avoided.

David
