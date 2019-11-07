From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 07 Nov 2019 03:40:37 +0000
Subject: Re: [PATCH v4 01/10] IMA: Defined an IMA hook to measure keys on key create or update
Message-Id: <1573098037.5028.325.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
         <20191106190116.2578-2-nramas@linux.microsoft.com>
         <1573080189.5028.313.camel@linux.ibm.com>
         <c838a233-28fb-cad2-4694-18366c2643a4@linux.microsoft.com>
In-Reply-To: <c838a233-28fb-cad2-4694-18366c2643a4@linux.microsoft.com>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2019-11-06 at 16:21 -0800, Lakshmi Ramasubramanian wrote:
> On 11/6/2019 2:43 PM, Mimi Zohar wrote:
> 
> >> +void ima_post_key_create_or_update(struct key *keyring, struct key *key,
> >> +				   unsigned long flags, bool create)
> >> +{
> >> +	if ((keyring != NULL) && (key != NULL))
> >> +		return;
> > 
> > I would move the patch that defines the "keyring=" policy option prior
> > to this one.  Include the call to process_buffer_measurement() in this
> > patch.  A subsequent patch would add support to defer measuring the
> > key, by calling a function named something like
> > ima_queue_key_measurement().
> > 
> > Mimi
> 
> As I'd stated in the other response, I wanted to isolate all key related 
> code in a separate C file and build it if and only if all CONFIG 
> dependencies are met.

The basic measuring of keys shouldn't be any different than any other
policy rule, other than it is a key and not a file.  This is the
reason that I keep saying start out with the basics and then add
support to defer measuring keys on the trusted keyrings.

Only the queueing code needed for measuring keys on the trusted
keyrings would be in a separate file.

Mimi
