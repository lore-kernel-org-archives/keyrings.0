From: Ben Boeckel <mathstuf@gmail.com>
Date: Thu, 27 Sep 2018 18:37:38 +0000
Subject: Re: [PATCH 1/5] docs: fix prototype for `request_key`
Message-Id: <20180927183738.GB6356@rotor.kitware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180927131450.23458-2-mathstuf@gmail.com>
In-Reply-To: <20180927131450.23458-2-mathstuf@gmail.com>
To: keyrings@vger.kernel.org

On Thu, Sep 27, 2018 at 18:03:32 +0100, David Howells wrote:
> Ben Boeckel <mathstuf@gmail.com> wrote:
> 
> >  	struct key *request_key(const struct key_type *type,
> >  				const char *description,
> > -				const char *callout_info);
> > +				const char *callout_string);
> 
> Ummm...  This no longer corresponds with the code:
> 
> 	struct key *request_key(struct key_type *type,
> 				const char *description,
> 				const char *callout_info)
> 
> so no.

OK, I'll update the other sentence which called it `callout_string`
then.

--Ben
