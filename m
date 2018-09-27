From: David Howells <dhowells@redhat.com>
Date: Thu, 27 Sep 2018 17:15:19 +0000
Subject: Re: [PATCH 5/5] dns_key: add a function to verify the key description
Message-Id: <29624.1538068519@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180927131450.23458-6-mathstuf@gmail.com>
In-Reply-To: <20180927131450.23458-6-mathstuf@gmail.com>
To: keyrings@vger.kernel.org

You can actually vet the description in ->preparse().  ->vet_description() is
redundant if all key types implement ->preparse().

David
