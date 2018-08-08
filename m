From: David Howells <dhowells@redhat.com>
Date: Wed, 08 Aug 2018 15:46:21 +0000
Subject: Re: [RFCv3 08/13] KEYS: asym_tpm: Add loadkey2 and flushspecific
Message-Id: <3081.1533743181@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180802183121.22909-9-denkenz@gmail.com>
In-Reply-To: <20180802183121.22909-9-denkenz@gmail.com>
To: keyrings@vger.kernel.org

Denis Kenzior <denkenz@gmail.com> wrote:

> +#include "../../security/keys/trusted.h"

Should this be moved to include/keys/ somewhere, at least in part?

David
