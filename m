From: Ben Boeckel <mathstuf@gmail.com>
Date: Fri, 02 Nov 2018 17:21:22 +0000
Subject: Re: [PATCH v2 5/7] keyctl_dh_compute_kdf: use a void* for opaque data
Message-Id: <20181102172122.GA17847@rotor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180927131436.23328-6-mathstuf@gmail.com>
In-Reply-To: <20180927131436.23328-6-mathstuf@gmail.com>
To: keyrings@vger.kernel.org

On Fri, Nov 02, 2018 at 16:30:21 +0000, David Howells wrote:
> But you shouldn't also *change* the UAPI if that will break existing
> userspace.  I think that's Linus's rule #1.  And your change has the potential
> to do just that.

It seems that my git archaeology missed that the struct was added in
4.12. Sorry about that. I guess late night coding didn't help there.

--Ben
