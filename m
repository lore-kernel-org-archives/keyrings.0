From: David Howells <dhowells@redhat.com>
Date: Thu, 23 Aug 2018 09:15:24 +0000
Subject: Re: [PATCH] Fix not passing all arguments to keyctl_pkey_query
Message-Id: <14072.1535015724@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180802163746.3063-1-denkenz@gmail.com>
In-Reply-To: <20180802163746.3063-1-denkenz@gmail.com>
To: keyrings@vger.kernel.org

Denis Kenzior <denkenz@gmail.com> wrote:

> pkey_parse_info was being called starting with the 3rd argument.  This
> resulted in calls such as:
> 
> 	'keyctl pkey_query 805557749 enc=pkcs1'
> 
> not passing the enc=pkcs1 parameter and resulting in the query always
> returning the results for the 'raw' encoding.
> 
> Signed-off-by: Denis Kenzior <denkenz@gmail.com>

I've folded this in.

David
