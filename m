From: David Howells <dhowells@redhat.com>
Date: Fri, 02 Nov 2018 14:47:32 +0000
Subject: Re: [PATCH v2 6/7] keyctl_set_reqkey_keyring.3: mention KEY_REQKEY_DEFL_USER_SESSION_KEYRING
Message-Id: <11475.1541170052@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Ben Boeckel <mathstuf@gmail.com> wrote:

> +.B KEY_REQKEY_DEFL_GROUP_KEYRING
> +This makes the GID-specific session keyring the default destination.
> +.TP

$subject is at odds with the patch.

There's a good reason I haven't mentioned KEY_REQKEY_DEFL_GROUP_KEYRING.  I
don't want to implement it: it's something Linus wanted - but I think it's
impractical.

David
