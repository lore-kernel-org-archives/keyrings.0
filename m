From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Mon, 04 Dec 2017 18:54:28 +0000
Subject: Re: [PATCH tip/core/rcu 15/21] keyring: Remove now-redundant smp_read_barrier_depends()
Message-Id: <20171204185428.GC7829@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171201195053.GA23494@linux.vnet.ibm.com>
	<1512157876-24665-15-git-send-email-paulmck@linux.vnet.ibm.com>
	<alpine.LFD.2.20.1712041159130.1348@localhost>
In-Reply-To: <alpine.LFD.2.20.1712041159130.1348@localhost>
To: linux-security-module@vger.kernel.org

On Mon, Dec 04, 2017 at 11:59:22AM +1100, James Morris wrote:
> On Fri, 1 Dec 2017, Paul E. McKenney wrote:
> 
> > Now that the associative-array library properly heads dependency chains,
> > the various smp_read_barrier_depends() calls in security/keys/keyring.c
> > are no longer needed.  This commit therefore removes them.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: James Morris <james.l.morris@oracle.com>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: <keyrings@vger.kernel.org>
> > Cc: <linux-security-module@vger.kernel.org>
> 
> Reviewed-by: James Morris <james.l.morris@oracle.com>

Applied, thank you for the review!

							Thanx, Paul

