From: David Howells <dhowells@redhat.com>
Date: Sat, 08 Sep 2018 15:26:14 +0000
Subject: Re: [PATCH 00/22] KEYS: Support TPM-wrapped key and crypto ops
Message-Id: <12101.1536420374@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <25C89575-D4E9-48FB-BEC9-383B09F32E44@holtmann.org>
	<153618445730.7946.10001472635835806478.stgit@warthog.procyon.org.uk>
	<alpine.LRH.2.21.1809061007140.23269@namei.org>
In-Reply-To: <25C89575-D4E9-48FB-BEC9-383B09F32E44@holtmann.org>
To: linux-security-module@vger.kernel.org

Marcel Holtmann <marcel@holtmann.org> wrote:

> so I have reviewed and tested this code. In addition, we have test cases for
> it in ELL (embedded linux library).

I wonder if there's any practical way to add a test for this to the keyutils
test suite.  I'm guessing it's quite tricky, given the extra bits you need to
emulate the TPM.

David
