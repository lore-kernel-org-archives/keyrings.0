Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725126;
	b=Ybch91Qyi0pV/uRAq3RwU0AfJKuZfNBCRRz8UmYUyVHQ19HCHgzN/uruIdQbgi825k1z
	 4F9Cx7Z7QJhuFmhGKlEMU7/noUEFVBehqWzd6VW2tQqJXVxEupbwxNFsAxiEvEi5oxXol
	 KVAqGDAA2A+ieQ4NtNWaWL2C5om3QYX9LtqBY6fPvAFxOF08m7ZmUlpMvICiAVnaCZVfc
	 I5DXRZTJEpYbPui2LlF255hlnAvTu0CHQKq43PDiytZAtIeP9YxXiSk1EoM+13mkerY4F
	 8MQRbZhXh21aCQlIS/wdGMNoM4vztc2OtahDmHKSX4WjbLDf+brr3KKKsLgAuN/D1Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725126;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fK4HGLx2bl61G7BQj3adT/NL1+Sgt8o2Uq+I8Yh/8MY=;
	b=ezbGj1I//qDFahpLsvyRcQt1RJ5I8QFBUby7tYuwbYFjCohOa9+BXfDIAwFCGiS5KQ5l
	 OW2mwNlZFD099yvxhh62wyyOAYkibIz6NW6g1f48hd+aoe7wAdU6bdHE633XmmXDqHu/M
	 5RxXXPJfQ0LbX0PejvPXl+uJknvveIIIuBkR8EolaUrERlpN/tlDkL/YVISiokXTEIR7t
	 KT26M/sbdp8wBIt5I7I0XXUY/vrpR7nkUX0GJyqZREF6YY+cvA0j9jmTdqumDV4Do9AqV
	 XsrBwJoSIgPlpnVjHSjMtoaR7dABhfxHK0irgXlhW7zgAKW8+NrJEUGLEj6CDRN0dZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c63b2jI9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C5373606A332;
	Tue,  3 Nov 2026 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c63b2jI9
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1AFCB1F00919;
	Tue,  3 Nov 2026 16:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793725125;
	bh=fK4HGLx2bl61G7BQj3adT/NL1+Sgt8o2Uq+I8Yh/8MY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c63b2jI9+4FWVTZeH4ddFhEzy4MGXLeB8Xi9Vd1lTCnx117QG8qAcTH7UVak3bxZr
	 Z5Q4/eIWLw13tisRUunP5XPhFNGy3cWJcRXSIDSS4k1+cFGCPc4PLnQL/zcaasJujs
	 Ov2dRGFP5/zaJBQ7DELygJWFA151+x9ylnukDsDUSRFAyjd055WI55kOpfw6uBTcpM
	 B3PDlZnEpTUqQ4s86CV5ng+HT7/ztQzOY/HEG8DxVM0G6JRyNUSIxNojHgeSCNfDS7
	 1gNMup02LXU+5HVu1fYBiBqJ/+9g3/p1p9hG9EUfE8ZqJCyx3h+ONAMVsu0a4JA9aq
	 r4vCd5tW+1NXQ==
Date: Tue, 3 Nov 2026 18:58:41 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 00/11] KEYS: Sanitize the garbage collector
Message-ID: <auoSwRMIXLajVeWs@kernel.org>
References: <aun4kXCJDtYomzpu@kernel.org>
 <aunNj35KmcAC4ByH@kernel.org>
 <20261103030226.2685251-1-jarkko@kernel.org>
 <641294.1793700187@dhowells-thinkpadp1gen8.rmtgb.csb>
 <669211.1793714419@dhowells-thinkpadp1gen8.rmtgb.csb>
 <683284.1793719946@dhowells-thinkpadp1gen8.rmtgb.csb>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <683284.1793719946@dhowells-thinkpadp1gen8.rmtgb.csb>

On Tue, Nov 03, 2026 at 03:32:26PM +0000, David Howells wrote:
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > > Actually, it can be done if the rxrpc and rxrpc_s key types are moved out
> > > into their own module upon which rxrpc.ko depends.
> > 
> > Hmm... I'll experiment with this, thanks. This was useful.
> 
> It's not entirely trivial.  I've attached a patch that makes a start on it,
> but it needs access to bits of the security class implementations (rxkad and
> rxgk).  Those bits only parse the key (and in the case of rxgk access the krb5
> code), so in theory it should be possible to extract them out.
> 
> One thing that needs to be considered, though, is the security class selected
> should really be up to the application, not merely switched on by the
> security_id.  This is one of the reasons I would like to add an add_key2()
> syscall that adds an additional parameter string argument.

Thanks I'll investigate this.

> 
> David
> ---
> commit 365e715b91b9b2ac3030f51c31ff4de8f24a4e19
> Author: David Howells <dhowells@redhat.com>
> Date:   Tue Nov 3 14:15:39 2026 +0000
> 
>     rxrpc: Move key types to own module
>     
>     Move the rxrpc and rxrpc_s key types to their own module so that if keys
>     pin the module that implements the type, they don't cause outstanding
>     connections to make the module unremovable.
>     
>     Signed-off-by: David Howells <dhowells@redhat.com>
> 
> diff --git a/net/Makefile b/net/Makefile
> index 5b2dd7f07a85..f543097c89b9 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -30,7 +30,7 @@ obj-$(CONFIG_LAPB)		+= lapb/
>  obj-$(CONFIG_CAN)		+= can/
>  obj-$(CONFIG_BT)		+= bluetooth/
>  obj-$(CONFIG_SUNRPC)		+= sunrpc/
> -obj-$(CONFIG_AF_RXRPC)		+= rxrpc/
> +obj-$(CONFIG_RXRPC_KEYS)	+= rxrpc/
>  obj-$(CONFIG_AF_KCM)		+= kcm/
>  obj-$(CONFIG_STREAM_PARSER)	+= strparser/
>  obj-$(CONFIG_ATM)		+= atm/
> diff --git a/net/rxrpc/Kconfig b/net/rxrpc/Kconfig
> index 2cebb666dc07..ffd42d71f85a 100644
> --- a/net/rxrpc/Kconfig
> +++ b/net/rxrpc/Kconfig
> @@ -3,6 +3,14 @@
>  # RxRPC session sockets
>  #
>  
> +config RXRPC_KEYS
> +	tristate "RxRPC key types"
> +	select CRYPTO
> +	select CRYPTO_LIB_DES if RXKAD
> +	select KEYS
> +	help
> +	  Say Y or M here to include support for rxrpc and rxrpc_s key types.
> +
>  config AF_RXRPC
>  	tristate "RxRPC session sockets"
>  	depends on INET
> @@ -10,6 +18,7 @@ config AF_RXRPC
>  	select CRYPTO_LIB_DES if RXKAD
>  	select KEYS
>  	select NET_UDP_TUNNEL
> +	select RXRPC_KEYS
>  	help
>  	  Say Y or M here to include support for RxRPC session sockets (just
>  	  the transport part, not the presentation part: (un)marshalling is
> diff --git a/net/rxrpc/Makefile b/net/rxrpc/Makefile
> index f994f9f30a29..196e0ce085ba 100644
> --- a/net/rxrpc/Makefile
> +++ b/net/rxrpc/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for Linux kernel RxRPC
>  #
>  
> +obj-$(CONFIG_RXRPC_KEYS) += rxrpc_keys.o
>  obj-$(CONFIG_AF_RXRPC) += rxrpc.o
>  
>  rxrpc-y := \
> @@ -19,7 +20,6 @@ rxrpc-y := \
>  	input_rack.o \
>  	insecure.o \
>  	io_thread.o \
> -	key.o \
>  	local_event.o \
>  	local_object.o \
>  	misc.o \
> @@ -32,7 +32,6 @@ rxrpc-y := \
>  	rtt.o \
>  	security.o \
>  	sendmsg.o \
> -	server_key.o \
>  	skbuff.o \
>  	txbuf.o \
>  	utils.o
> @@ -45,5 +44,9 @@ rxrpc-$(CONFIG_RXGK) += \
>  	rxgk_app.o \
>  	rxgk_kdf.o
>  
> +rxrpc_keys-y := \
> +	key.o \
> +	server_key.o
> +
>  obj-$(CONFIG_RXPERF) += rxperf.o
>  obj-$(CONFIG_KUNIT) += tests/
> diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
> index cbd26da44951..c353a4304788 100644
> --- a/net/rxrpc/key.c
> +++ b/net/rxrpc/key.c
> @@ -893,3 +893,39 @@ static long rxrpc_read(const struct key *key,
>  	_leave(" = %zu", size);
>  	return size;
>  }
> +
> +/*
> + * initialise and register the RxRPC protocol
> + */
> +static int __init rxrpc_keys_init(void)
> +{
> +	int ret;
> +
> +	ret = register_key_type(&key_type_rxrpc);
> +	if (ret < 0) {
> +		pr_crit("Cannot register client key type\n");
> +		goto error_key_type;
> +	}
> +
> +	ret = register_key_type(&key_type_rxrpc_s);
> +	if (ret < 0) {
> +		pr_crit("Cannot register server key type\n");
> +		goto error_key_type_s;
> +	}
> +
> +	return 0;
> +
> +error_key_type_s:
> +	unregister_key_type(&key_type_rxrpc);
> +error_key_type:
> +	return ret;
> +}
> +
> +static void __exit rxrpc_keys_exit(void)
> +{
> +	unregister_key_type(&key_type_rxrpc_s);
> +	unregister_key_type(&key_type_rxrpc);
> +}
> +
> +module_init(rxrpc_keys_init);
> +module_exit(rxrpc_keys_exit);
> diff --git a/net/rxrpc/server_key.c b/net/rxrpc/server_key.c
> index 3efe104b1930..b5e60a3364ad 100644
> --- a/net/rxrpc/server_key.c
> +++ b/net/rxrpc/server_key.c
> @@ -42,6 +42,7 @@ struct key_type key_type_rxrpc_s = {
>  	.destroy	= rxrpc_destroy_s,
>  	.describe	= rxrpc_describe_s,
>  };
> +EXPORT_SYMBOL(key_type_rxrpc_s);
>  
>  /*
>   * Vet the description for an RxRPC server key.
> 


Br, Jarkko
