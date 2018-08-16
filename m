From: David Howells <dhowells@redhat.com>
Date: Thu, 16 Aug 2018 13:15:19 +0000
Subject: Re: [PATCH 1/2] Replace magic for trusting the secondary keyring with #define
Message-Id: <18610.1534425319@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153442471049.17751.3835342719465644394.stgit@warthog.procyon.org.uk>
In-Reply-To: <153442471049.17751.3835342719465644394.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

Hi Yannik,

I would suggest something like that.  I've switched the patches over as has
been suggested.  I think it makes more sense to create the constant first and
then use that.

I've also fleshed out the patch description a bit and added cc and Fixes
fields as appropriate.

David
