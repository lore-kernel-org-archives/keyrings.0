From: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 29 May 2019 22:11:53 +0000
Subject: Re: [GIT PULL] keys: Miscellany
Message-Id: <20190529221152.GD141639@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <18289.1559167295@warthog.procyon.org.uk>
In-Reply-To: <18289.1559167295@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: James Morris <jmorris@namei.org>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 11:01:35PM +0100, David Howells wrote:
> 
>  (2) Implement a keyctl to allow a key to be moved from one keyring to
>      another, with the option of prohibiting key replacement in the
>      destination keyring.
> 

What is the use case, and where are the tests and documentation for this?

- Eric
